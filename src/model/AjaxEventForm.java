package model;

import controller.BrowserErrorHandling;
import database.City;
import database.Place;
import org.json.JSONException;
import org.json.JSONObject;
import org.json.simple.JSONArray;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.List;

public class AjaxEventForm {
    private HttpServletRequest request;
    private HttpServletResponse response;
    private HttpSession session;
    private City activeCity;

    public AjaxEventForm(HttpServletRequest request,
                         HttpServletResponse response) {
        this.request = request;
        this.response = response;
        this.session = request.getSession();
        this.activeCity = (City) session.getAttribute("activeCity");
    }

    public void getEventsAndRedirectToAjax() throws IOException {
        List<Place> eventResults;
        final String eventName = request.getParameter("eventName");
        final String eventType = request.getParameter("eventType");
        final String radiusAsString = request.getParameter("eventRadius");
        final int radiusInMiles = Integer.parseInt(radiusAsString);
        try {
            if (request.getQueryString().contains("ajaxGoogleButton=Google+Search")) {
                eventResults = queryGoogleForEvents(eventName, eventType, radiusInMiles);
                returnResultsToAjax(eventResults);
            } else if (request.getQueryString().contains("ajaxYelpButton=Yelp+Search")) {
                eventResults = queryYelpForEvents(eventType, radiusInMiles);
                returnResultsToAjax(eventResults);
            }
        } catch (JSONException ex) {

        } catch (IOException ex) {
            BrowserErrorHandling.printErrorToBrowser(request, response, ex);
        } catch (SQLException ex) {
            BrowserErrorHandling.printErrorToBrowser(request, response, ex);
        }
    }

    private List<Place> queryGoogleForEvents(String eventName,
                                             String eventType,
                                             int radius)
            throws IOException, JSONException {
        final double latitude = activeCity.getLatitude();
        final double longitude = activeCity.getLongitude();
        final String coordinates = new Coordinates(latitude, longitude).format();
        GooglePlaceAPI googleSearch = new GooglePlaceAPI();
        List<Place> eventResults = googleSearch.getByNearbyPlaceSearch
                (coordinates, radius, eventType, eventName);
        return eventResults;
    }

    private List<Place> queryYelpForEvents(final String term, final int radius)
            throws SQLException, JSONException {
        List<Place> results;
        final double latitude = activeCity.getLatitude();
        final double longitude = activeCity.getLongitude();
        final String coordinates = new Coordinates(latitude, longitude).format();
        YelpAPI yelpAPI = new YelpAPI(request, response);
        results = yelpAPI.queryAPI(term, coordinates, radius, 20, 0);
        return results;
    }

    private void returnResultsToAjax(final List<Place> results)
            throws IOException, JSONException {
        StringBuilder tableRows = new StringBuilder();
        for (Place result : results) {
            final String url = (result.getURL() != null) ? result.getURL() :
                    "/CS2340Servlet/itinerary?detail_search&place_id=" + 0 +
                            "&event_id=" + 0;
            tableRows.append("<tr><td>" + result.getName() + "</td><td>" +
                    result.getFormattedAddress() + "</td><td>" +
                    result.getRating() + "</td>" + "<td>" +
                    "<a href='" + url + "' target='_blank'>" +
                    "See More</a></td></tr>");
        }
        response.setContentType("text/html");
        PrintWriter writer = response.getWriter();
        writer.println(tableRows.toString());
    }
}
