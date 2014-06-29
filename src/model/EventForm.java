package model;

import controller.BrowserErrorHandling;
import database.Event;
import database.NearbyPlace;
import database.Itinerary;
import database.Preference;
import org.json.JSONException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class EventForm {
    private static final int MAX_DISTANCE = 50000;
    private HttpServletRequest request;
    private HttpServletResponse response;
    private HttpSession session;
    private Itinerary activeItinerary;

    public EventForm(HttpServletRequest request, HttpServletResponse response) {
        this.request = request;
        this.response = response;
        this.session = request.getSession();
        activeItinerary = (Itinerary) session.getAttribute("activeItinerary");
    }

    public void createNewEvents() throws IOException {
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
        response.sendRedirect("jsp/index.jsp");
    }

    public void getEventsAroundCentralLocation() {
        List<NearbyPlace> eventResults;
        final String eventID = parseEventIDFromRequestURI();
        final String API = getSearchAPIFromRequest();
        final String eventName = request.getParameter("eventName" + eventID);
        final String eventType = request.getParameter("eventType" + eventID);
        final String eventStartTime
                = request.getParameter("eventStartTime" + eventID);
        final String eventEndTime
                = request.getParameter("eventEventTime" + eventID);
        try {
            if (API.equals("Google")) {
                eventResults = queryGoogleForEvents(eventName, eventType);
            } else {
                eventResults = queryYelpForEvents(eventType);
            }
            populateSessionWithEventResults(eventID, eventResults);
            response.sendRedirect("jsp/index.jsp");
        } catch (IOException ex) {
            BrowserErrorHandling.printErrorToBrowser(request, response, ex);
        } catch (JSONException ex) {
            BrowserErrorHandling.printErrorToBrowser(request, response, ex);
        } catch (SQLException ex) {
            BrowserErrorHandling.printErrorToBrowser(request, response, ex);
        }
    }

    private String parseEventIDFromRequestURI() {
        final String queryString = request.getQueryString();
        final int startIndex = queryString.indexOf("=") + 1;
        final String eventID = queryString.substring(startIndex);
        return eventID;
    }

    private String getSearchAPIFromRequest() {
        String API;
        if (request.getParameter("getEventsWithGoogleButton") != null ) {
            API = "Google";
        } else {
            API = "Yelp";
        }
        return API;
    }

    private List<NearbyPlace> queryGoogleForEvents(String eventName, String eventType)
        throws IOException, JSONException {
        final String coordinates = reformatCoordsForQueryCompliance();
        GooglePlaceAPI googleSearch = new GooglePlaceAPI();
        List<NearbyPlace> eventResults = googleSearch.placeSearch
                (coordinates, MAX_DISTANCE, eventType);
        return eventResults;
    }

    private String reformatCoordsForQueryCompliance() {
        final String coords = activeItinerary.getCoordinates().toString();
        int begin = coords.indexOf("[") + 1;
        int end = coords.length() - 1;
        String formattedCoords = coords.substring(begin, end);
        formattedCoords = formattedCoords.replaceAll("\\s+", "");
        return formattedCoords;
    }

    private List<NearbyPlace> queryYelpForEvents(final String term)
            throws SQLException {
        List<NearbyPlace> results;
        final String location = activeItinerary.getAddress();
        final String eventID = parseEventIDFromRequestURI();
        final String radiusAsString = request.getParameter("eventRadius" + eventID);
        final int radiusInMiles = Integer.parseInt(radiusAsString);
        YelpAPI yelpAPI = new YelpAPI(request, response);
        results = yelpAPI.queryAPI(term, location, radiusInMiles);
        return results;
    }

    private void populateSessionWithEventResults(final String eventID,
                                                 List<NearbyPlace> eventResults) {
        final String specificEventName = request.getParameter("eventName" + eventID);
        final String specificEventType = request.getParameter("eventType" + eventID);
        session.setAttribute("eventName" + eventID, specificEventName);
        session.setAttribute("eventType" + eventID, specificEventType);
        session.setAttribute("businesses", eventResults);
    }

    public void saveSelection() throws IOException {
        String eventID = parseEventIDFromRequestURI();
        session.setAttribute("isEvent" + eventID + "Set", "true");
        String locationAndURL = request.getParameter("eventLocation" + eventID);
        int delimiterLocation = locationAndURL.indexOf(",");
        session.setAttribute("eventLocation" + eventID, locationAndURL.substring(0, delimiterLocation));
        session.setAttribute("eventBusinessURL" + eventID, locationAndURL.substring(delimiterLocation + 1));
        response.sendRedirect("jsp/index.jsp");
    }
}
