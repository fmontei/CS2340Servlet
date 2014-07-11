package model;

import controller.BrowserErrorHandling;
import database.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

public class ItineraryLoader {
    private String redirectQuery = "jsp/index.jsp?";

    public void loadItineraryAndAllDependencies(HttpServletRequest request,
                                                HttpServletResponse response)
            throws IOException {
        try {
            Itinerary activeItinerary = loadActiveItinerary(request);
            loadActivePreferences(activeItinerary, request);
            response.sendRedirect(redirectQuery);
        } catch (SQLException ex) {
            BrowserErrorHandling.printErrorToBrowser(request, response, ex);
        }
    }

    private Itinerary loadActiveItinerary(HttpServletRequest request)
            throws SQLException {
        final HttpSession session = request.getSession();
        final String queryString = request.getQueryString();
        final int startIndex = queryString.indexOf("=") + 1;
        final String itineraryID = queryString.substring(startIndex);
        final int itineraryIntID = Integer.parseInt(itineraryID);
        SQLItineraryQuery query = new SQLItineraryQuery();
        Itinerary activeItinerary = query.getItineraryByID(itineraryID);
        session.setAttribute("activeItinerary", activeItinerary);
        loadCities(session, itineraryIntID);
        return activeItinerary;
    }

    private void loadCities(final HttpSession session,
                            final int itineraryID) throws SQLException {
        List<City> cities = DataManager.getCitiesAndPlacesByItineraryID(itineraryID);
        if (citiesExist(cities)) {
            storeCitiesIntoSession(session, cities);
        } else {
            removeCitiesFromSession(session);
        }
    }

    private boolean citiesExist(List<City> cities) {
        return cities != null && cities.size() > 0;
    }

    private void storeCitiesIntoSession(HttpSession session, List<City> cities) {
        session.setAttribute("cities", cities);
        session.setAttribute("activeCity", cities.get(0));
        redirectQuery += cities.get(0).getName();
    }

    private void removeCitiesFromSession(HttpSession session) {
        session.removeAttribute("cities");
        session.removeAttribute("activeCity");
    }

    private void loadActivePreferences(Itinerary activeItinerary,
                                       HttpServletRequest request)
            throws SQLException {
        HttpSession session = request.getSession();
        final int preferenceID = activeItinerary.getPreferenceID();
        SQLPreferenceQuery query = new SQLPreferenceQuery();
        Preference activePreferences = query.getPreferencesByID(preferenceID);
        session.setAttribute("activePreferences", activePreferences);
    }
}
