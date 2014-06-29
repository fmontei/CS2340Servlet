package model;

import controller.BrowserErrorHandling;
import database.Event;
import database.NearbyPlace;
import database.Itinerary;
import org.json.JSONException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

public class EventForm {
    private static final int MAX_DISTANCE = 50000;
    private HttpServletRequest request;
    private HttpServletResponse response;
    private HttpSession session;

    public EventForm(HttpServletRequest request, HttpServletResponse response) {
        this.request = request;
        this.response = response;
        this.session = request.getSession();
    }

    public void createNewEvents() {
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

    public void getEventsAroundCentralLocation() {
        final String eventID = parseEventIDFromRequestURI();
        final String eventName = request.getParameter("eventName" + eventID);
        final String eventType = request.getParameter("eventType" + eventID);
        final String eventStartTime
                = request.getParameter("eventStartTime" + eventID);
        final String eventEndTime
                = request.getParameter("eventEventTime" + eventID);
        try {
            List<NearbyPlace> eventResults = queryGoogleForEvents
                    (eventName, eventType);
            populateSessionWithEventResults(eventID, eventResults);
            response.sendRedirect("jsp/index.jsp");
        } catch (IOException ex) {
            BrowserErrorHandling.printErrorToBrowser(request, response, ex);
        } catch (JSONException ex) {
            BrowserErrorHandling.printErrorToBrowser(request, response, ex);
        }
    }

    private String parseEventIDFromRequestURI() {
        final String queryString = request.getQueryString();
        final int startIndex = queryString.indexOf("=") + 1;
        final String eventID = queryString.substring(startIndex);
        return eventID;
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
        final Itinerary activeItinerary
                = (Itinerary) session.getAttribute("activeItinerary");
        final String coords = activeItinerary.getCoordinates().toString();
        int begin = coords.indexOf("[") + 1;
        int end = coords.length() - 1;
        String formattedCoords = coords.substring(begin, end);
        formattedCoords = formattedCoords.replaceAll("\\s+", "");
        return formattedCoords;
    }

    public void populateSessionWithEventResults(final String eventID, List<NearbyPlace> eventResults) {
        session.setAttribute("eventName" + eventID, request.getParameter("eventName" + eventID));
        session.setAttribute("eventType" + eventID, request.getParameter("eventType" + eventID));
        session.setAttribute("eventStartTime" + eventID, request.getParameter("eventStartTime" + eventID));
        session.setAttribute("eventEndTime" + eventID, request.getParameter("eventEndTime" + eventID));
        session.setAttribute("businesses", eventResults);
    }
}
