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
        List<Event> events = (List) session.getAttribute("events");
        List<Place> businesses =
                (List) session.getAttribute("businesses" + eventNum);
        Event eventToBeUpdated = events.get(eventNum);
        Place businessToBeSaved = businesses.get(businessNum);
        setEventParameters(eventToBeUpdated, businessToBeSaved);
        events.set(eventNum, eventToBeUpdated);
        session.setAttribute("events", events);
        response.sendRedirect("jsp/index.jsp");
    }

    private void setEventParameters(Event event, Place business) {
        event.setName(business.getName());
        event.setFormattedAddress(business.getFormattedAddress());
        event.setPhoneNumber(business.getPhoneNumber());
        event.setRating(business.getRating());
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
            if (API.equals("google")) {
                eventResults = queryGoogleForEvents(eventName, eventType,
                        radiusInMiles);
            } else {
                eventResults = queryYelpForEvents(eventType, radiusInMiles);
            }
            populateSessionWithEventResults(eventID, eventResults);
            updateImageIcon(eventID, API);
            session.removeAttribute("googleSearchError" + eventID);
            response.sendRedirect("jsp/index.jsp?search=" + API +
                    "&event-no=" + eventID);
        } catch (JSONException ex) {
            session.setAttribute("googleSearchError" + eventID, ex.getMessage());
            response.sendRedirect("jsp/index.jsp");
        } catch (IOException ex) {
            BrowserErrorHandling.printErrorToBrowser(request, response, ex);
        } catch (SQLException ex) {
            BrowserErrorHandling.printErrorToBrowser(request, response, ex);
        }
    }

    private String getSearchAPIFromRequest() {
        String API;
        if (request.getParameter("getEventsWithGoogleButton") != null ) {
            API = "google";
        } else {
            API = "yelp";
        }
        return API;
    }

    private void putQueryStringForReviewInSession(String eventID,
                                                  String eventName,
                                                  String eventType,
                                                  String radius) {
        session.setAttribute("eventQueryString" + eventID, "Event Name = '" +
                eventName + "' | Event Type = '" + eventType + "' | Radius = '" +
                radius + "'.");
    }

    private List<Place> queryGoogleForEvents(String eventName,
                                                   String eventType,
                                                   int radius)
        throws IOException, JSONException {
        final String coordinates = activeItinerary.getCoordinates().toString();
        GooglePlaceAPI googleSearch = new GooglePlaceAPI();
        List<Place> eventResults = googleSearch.getByPlaceSearch
                (coordinates, radius, eventType, eventName);
        return eventResults;
    }

    private void updateImageIcon(final String eventID, final String API) {
        final int eventNum = Integer.parseInt(eventID);
        List<Event> events = (List) session.getAttribute("events");
        events.get(eventNum).setApi(API);
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

    public void doDetailedSearch() throws IOException {
        final String queryString = request.getQueryString();
        final int placeBeginIndex = queryString.indexOf("=") + 1;
        final int placeEndIndex = queryString.lastIndexOf("&");
        final String placeID = queryString.substring(placeBeginIndex, placeEndIndex);
        final int placeNum = Integer.parseInt(placeID);
        final int eventBeginIndex = queryString.lastIndexOf("=") + 1;
        final String eventID = queryString.substring(eventBeginIndex);
        final List<Place> places = (List) session.getAttribute("businesses" + eventID);
        final Place placeToBeUpdated = places.get(placeNum);
        GooglePlaceAPI googlePlaceAPI = new GooglePlaceAPI();
        try {
            googlePlaceAPI.getByDetailSearch(placeToBeUpdated);
            session.removeAttribute("googleSearchError" + eventID);
            response.sendRedirect(placeToBeUpdated.getURL());
        } catch (JSONException ex) {
            session.setAttribute("googleSearchError" + eventID, ex.getMessage());
            response.sendRedirect("jsp/index.jsp");
        } catch (IOException ex) {
            BrowserErrorHandling.printErrorToBrowser(request, response, ex);
        }
    }
}
