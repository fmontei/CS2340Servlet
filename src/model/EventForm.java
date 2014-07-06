package model;

import controller.BrowserErrorHandling;
import database.DataManager;
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
        List<Place> events = new ArrayList<Place>();
        if (session.getAttribute("events") != null) {
            events = (List<Place>) session.getAttribute("events");
        }
        for (int i = 0; i < Integer.parseInt(numberOfEvents); i++) {
            events.add(new Place());
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
        List<Place> events = (List) session.getAttribute("events");
        List<Place> businesses =
                (List) session.getAttribute("businesses" + eventNum);
        Place eventToBeUpdated = events.get(eventNum);
        Place businessToBeSaved = businesses.get(businessNum);
        setEventParameters(eventToBeUpdated, businessToBeSaved);
        events.set(eventNum, eventToBeUpdated);
        try {
            DataManager.createEvent(businessToBeSaved, activeItinerary.getID());
            session.setAttribute("events", events);
            response.sendRedirect("jsp/index.jsp");
        } catch (SQLException ex) {
            BrowserErrorHandling.printErrorToBrowser(request, response, ex);
        }
    }

    private void setEventParameters(Place event, Place business) {
        event.setName(business.getName());
        event.setFormattedAddress(business.getFormattedAddress());
        event.setPhoneNumber(business.getPhoneNumber());
        event.setRating(business.getRating());
    }

    public String parseEventIDFromQueryString() {
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
            returnQueryResults(eventID, API);
        } catch (JSONException ex) {
            returnSearchError(eventID, ex);
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
        session.setAttribute("eventQueryString" + eventID, "Place Name = '" +
                eventName + "' | Place Type = '" + eventType + "' | Radius = '" +
                radius + "'.");
    }

    private List<Place> queryGoogleForEvents(String eventName,
                                                   String eventType,
                                                   int radius)
        throws IOException, JSONException {
        final String coordinates = parseAndReformatCoordinates();
        GooglePlaceAPI googleSearch = new GooglePlaceAPI();
        List<Place> eventResults = googleSearch.getByPlaceSearch
                (coordinates, radius, eventType, eventName);
        return eventResults;
    }

    private List<Place> queryYelpForEvents(final String term, final int radius)
            throws SQLException, JSONException {
        List<Place> results;
        final String coordinates = parseAndReformatCoordinates();
        YelpAPI yelpAPI = new YelpAPI(request, response);
        results = yelpAPI.queryAPI(term, coordinates, radius, 20, 0);
        return results;
    }

    private String parseAndReformatCoordinates() {
        final String coords = activeItinerary.getCoordinates().toString();
        int begin = coords.indexOf("[") + 1;
        int end = coords.length() - 1;
        String formattedCoords = coords.substring(begin, end);
        formattedCoords = formattedCoords.replaceAll("\\s+", "");
        return formattedCoords;
    }

    private void populateSessionWithEventResults(String eventID,
                                                 List<Place> eventResults) {
        session.setAttribute("businesses" + eventID, eventResults);
    }

    public void getDetailedInformationForPlace() throws IOException {
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
            redirectUserToRequestedURL(eventID, placeToBeUpdated);
        } catch (JSONException ex) {
            returnSearchError(eventID, ex);
        } catch (IOException ex) {
            BrowserErrorHandling.printErrorToBrowser(request, response, ex);
        }
    }

    private void returnQueryResults(String eventID, String API)
            throws IOException {
        updateImageIcon(eventID, API);
        session.removeAttribute("apiSearchError" + eventID);
        response.sendRedirect("jsp/index.jsp?search=" + API +
                "&event-no=" + eventID);
    }

    private void updateImageIcon(final String eventID, final String API) {
        final int eventNum = Integer.parseInt(eventID);
        List<Place> events = (List) session.getAttribute("events");
        events.get(eventNum).setAPI(API);
    }

    private void redirectUserToRequestedURL(String eventID, Place place)
        throws IOException {
        session.removeAttribute("apiSearchError" + eventID);
        response.sendRedirect(place.getURL());
    }

    private void returnSearchError(String eventID, JSONException ex)
        throws IOException {
        session.removeAttribute("businesses" + eventID);
        session.setAttribute("apiSearchError" + eventID, ex.getMessage());
        response.sendRedirect("jsp/index.jsp?search=google&event-no=" + eventID);
    }
}
