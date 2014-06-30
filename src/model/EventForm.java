package model;

import controller.BrowserErrorHandling;
import database.Event;
import database.Itinerary;
import database.Place;
import org.json.JSONException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class EventForm {
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

    public void saveSelection() throws IOException {
        int businessNum, eventNum;
        final String eventID = parseEventIDFromQueryString();
        final String businessID = parseBusinessIDFromQueryString();
        eventNum = Integer.parseInt(eventID);
        businessNum = Integer.parseInt(businessID);
        List<Event> events = (List<Event>) session.getAttribute("events");
        List<Place> businesses = (List<Place>) session.getAttribute("businesses" + eventNum);
        Event eventToBeUpdated = events.get(eventNum);
        Place businessToBeSaved = businesses.get(businessNum);
        eventToBeUpdated.setName(businessToBeSaved.getName());
        events.set(eventNum, eventToBeUpdated);
        session.setAttribute("events", events);
        response.sendRedirect("jsp/index.jsp");
    }

    private String parseEventIDFromQueryString() {
        final String queryString = request.getQueryString();
        final int startIndex = queryString.lastIndexOf("=") + 1;
        final String eventID = queryString.substring(startIndex);
        return eventID;
    }

    private String parseBusinessIDFromQueryString() {
        final String queryString = request.getQueryString();
        final int startIndex = queryString.indexOf("=") + 1;
        final int endIndex = queryString.indexOf("&");
        final String businessID = queryString.substring(startIndex, endIndex);
        return businessID;
    }

    public void getEventsAroundCentralLocation() throws IOException {
        List<Place> eventResults;
        final String eventID = parseEventIDFromQueryString();
        final String API = getSearchAPIFromRequest();
        final String eventName = request.getParameter("eventName" + eventID);
        final String eventType = request.getParameter("eventType" + eventID);
        final String radiusAsString = request.getParameter("eventRadius" + eventID);
        final int radiusInMiles = Integer.parseInt(radiusAsString);
        putQueryStringForReviewInSession(eventID, eventName, eventType,
                radiusAsString);
        try {
            if (API.equals("Google")) {
                eventResults = queryGoogleForEvents(eventName, eventType,
                        radiusInMiles);
            } else {
                eventResults = queryYelpForEvents(eventType, radiusInMiles);
            }
            populateSessionWithEventResults(eventID, eventResults);
            response.sendRedirect("jsp/index.jsp?event-no-" + eventID);
        } catch (JSONException ex) {
            request.setAttribute("googleSearchError", ex.getMessage());
            ServletUtilities.forwardRequest(request, response, "/jsp/index.jsp");
        } catch (IOException ex) {
            BrowserErrorHandling.printErrorToBrowser(request, response, ex);
        } catch (SQLException ex) {
            BrowserErrorHandling.printErrorToBrowser(request, response, ex);
        }
    }

    private void putQueryStringForReviewInSession(String eventID,
                                                  String eventName,
                                                  String eventType,
                                                  String radius) {
        session.setAttribute("eventQueryString" + eventID, "Event Name = '" +
                eventName + "' | Event Type = '" + eventType + "' | Radius = '" +
                radius + "'.");
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

    private List<Place> queryGoogleForEvents(String eventName,
                                                   String eventType,
                                                   int radius)
        throws IOException, JSONException {
        final String coordinates = reformatCoordsForQueryCompliance();
        GooglePlaceAPI googleSearch = new GooglePlaceAPI();
        List<Place> eventResults = googleSearch.placeSearch
                (coordinates, radius, eventType);
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

    private List<Place> queryYelpForEvents(final String term, int radius)
            throws SQLException {
        List<Place> results;
        final String location = activeItinerary.getAddress();
        YelpAPI yelpAPI = new YelpAPI(request, response);
        results = yelpAPI.queryAPI(term, location, radius);
        return results;
    }

    private void populateSessionWithEventResults(String eventID,
                                                 List<Place> eventResults) {
        session.setAttribute("businesses" + eventID, eventResults);
    }
}
