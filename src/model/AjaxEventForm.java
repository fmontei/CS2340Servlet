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
            final String googleButton = request.getParameter("getEventsWithGoogleButton");
            if (googleButton != null) {
                eventResults = queryGoogleForEvents(eventName, eventType, radiusInMiles);
            } else {
                eventResults = queryYelpForEvents(eventType, radiusInMiles);
            }
            returnResultsToAjax(eventResults);
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
        JSONArray array = new JSONArray();
        for (Place result : results) {
            JSONObject json = new JSONObject();
            json.put("name", result.getName());
            json.put("address", result.getFormattedAddress());
            json.put("rating", result.getRating());
            json.put("url", result.getURL());
            array.add(json);
        }
        response.getWriter().write(array.toJSONString());
    }
}
