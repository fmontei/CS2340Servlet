package controller; 

import database.*;
import model.AccountPreference;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet(name = "IndexServlet", urlPatterns = { "/index" })
public class IndexServlet extends HttpServlet {

    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse response)
        throws IOException, ServletException {
        if (request.getQueryString().contains("itinerary_id=")) {
            loadActiveItineraryAndPreferences(request, response);
        } else {
            response.sendRedirect("jsp/createLoginSession.jsp");
        }
    }

    @Override
    public void doPost(HttpServletRequest request, HttpServletResponse response)
        throws IOException, ServletException {
        if (isTravelModeButtonClicked(request)) {
            AccountPreference accountPreference = new AccountPreference(request);
            if (accountPreference.isPreferredTravelModeSaved()) {
                goToPreviousScreen(response);
            }
        }
    }

    private boolean isTravelModeButtonClicked(HttpServletRequest request) {
        return request.getParameter("submitTravelMode") != null;
    }

    private void goToPreviousScreen(HttpServletResponse response)
            throws IOException {
        response.sendRedirect("jsp/index.jsp");
    }

    private void loadActiveItineraryAndPreferences(HttpServletRequest request,
                                                   HttpServletResponse response)
            throws IOException {
        try {
            Itinerary active = loadActiveItinerary(request);
            loadActivePreferences(active, request);
            response.sendRedirect("jsp/index.jsp");
        } catch (SQLException ex) {
            BrowserErrorHandling.printErrorToBrowser(request, response, ex);
        }
    }

    private Itinerary loadActiveItinerary(HttpServletRequest request)
            throws SQLException {
        final HttpSession session = request.getSession();
        final String queryString = request.getQueryString();
        final int startIndex = queryString.indexOf("=") + 1;
        String itineraryID = queryString.substring(startIndex);
        SQLItineraryQuery query = new SQLItineraryQuery();
        Itinerary activeItinerary = query.getItineraryByID(itineraryID);
        session.setAttribute("activeItinerary", activeItinerary);
        loadLodging(session, itineraryID);
        loadEvents(session, itineraryID);
        return activeItinerary;
    }

    private void loadLodging(final HttpSession session,
                             final String itineraryID) throws SQLException {
        Place lodging = DataManager.getLodgingByItineraryID(itineraryID);
        if (lodgingExists(lodging)) {
            storeLodgingIntoSession(session, lodging);
        } else {
            removeLodgingFromSession(session);
        }
    }

    private boolean lodgingExists(Place lodging) {
        return lodging != null && lodging.getName() != null;
    }

    private void storeLodgingIntoSession(HttpSession session, Place lodging) {
        session.setAttribute("lodgingSelection", lodging);
    }

    private void removeLodgingFromSession(HttpSession session) {
        session.removeAttribute("lodgingSelection");
    }

    private void loadEvents(final HttpSession session,
                            final String itineraryID) throws SQLException {
        List<Place> events = DataManager.getEventsByItineraryID(itineraryID);
        if (eventsExist(events)) {
            storeEventsIntoSession(session, events);
        } else {
            removeEventsFromSession(session);
        }
    }

    private boolean eventsExist(List<Place> events) {
        return events != null && events.size() > 0;
    }

    private void storeEventsIntoSession(HttpSession session, List<Place> events) {
        session.setAttribute("events", events);
    }

    private void removeEventsFromSession(HttpSession session) {
        session.removeAttribute("events");
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
