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
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "IndexServlet", urlPatterns = { "/index" })
public class IndexServlet extends HttpServlet {

    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse response)
        throws IOException, ServletException {
        if (request.getQueryString().contains("itinerary_id=")) {
            loadActiveItineraryAndPreferences(request, response);
        } else if (request.getQueryString().contains("create_event=")) {
            createNewEvents(request);
            response.sendRedirect("jsp/index.jsp");
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
        String itineraryId = queryString.substring(startIndex);
        SQLItineraryQuery query = new SQLItineraryQuery();
        Itinerary activeItinerary = query.getItineraryByID(itineraryId);
        session.setAttribute("activeItinerary", activeItinerary);
        session.setAttribute("ITINERARY_NAME", activeItinerary.getName());
        return activeItinerary;
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

    private void createNewEvents(HttpServletRequest request) {
        final HttpSession session = request.getSession();
        final String queryString = request.getQueryString();
        final int startIndex = queryString.indexOf("=") + 1;
        final String numberOfEvents = queryString.substring(startIndex);
        List<Event> events = new ArrayList<Event>();
        if (session.getAttribute("events") != null) {
            events = (ArrayList<Event>) session.getAttribute("events");
        }
        for (int i = 0; i < Integer.parseInt(numberOfEvents); i++) {
            events.add(new Event());
        }
        session.setAttribute("events", events);
    }
}
