package model;

import database.Place;
import org.json.JSONException;
import org.json.JSONObject;

import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.ArrayList;
import java.util.List;

public class GooglePlaceAPI {
    protected static final String PLACES_API_BASE =
            "https://maps.googleapis.com/maps/api/place";
    protected static final String TEXT_SEARCH = "/textsearch";
    protected static final String NEARBY_SEARCH = "/nearbysearch";
    protected static final String DETAIL_SEARCH = "/details";
    protected static final String OUT_JSON = "/json";
    protected static final String API_KEY =
            "AIzaSyB5fL-GAeqRAg0eRTf3NGaiQPrKAlR8iGE";

    public List<Place> getByTextSearch(final String query) throws
            IOException, JSONException {
        ArrayList<Place> results;
        GooglePlaceTextSearch placeTextSearch = new GooglePlaceTextSearch(query);
        final String urlQuery = placeTextSearch.getTextSearchURL();
        final StringBuilder jsonResults = queryGoogle(urlQuery);
        results = placeTextSearch.parseJsonResults(jsonResults);
        return results;
    }

    public List<Place> getByPlaceSearch(final String coordinates,
                                        final int radius,
                                        final String type,
                                        final String name)
            throws IOException, JSONException {
        GooglePlaceNearbySearch placeNearbySearch =
                new GooglePlaceNearbySearch(coordinates, radius, type, name);
        final String urlQuery = placeNearbySearch.getSearchURL();
        final StringBuilder jsonResults = queryGoogle(urlQuery);
        List<Place> results = placeNearbySearch.parseJsonResults(jsonResults);
        return results;
    }

    public void getByDetailSearch(final Place place)
            throws IOException, JSONException {
        GooglePlaceDetailSearch detailSearch = new GooglePlaceDetailSearch(place);
        final String urlQuery = detailSearch.getSearchURL();
        final StringBuilder jsonResults = queryGoogle(urlQuery);
        detailSearch.parseJsonResults(jsonResults);
    }

    private StringBuilder queryGoogle(final String urlQuery)
            throws IOException {
        InputStreamReader in = null;
        StringBuilder jsonResults = new StringBuilder();
        try {
            final URL url = new URL(urlQuery);
            final HttpURLConnection conn =
                    (HttpURLConnection) url.openConnection();
            in = new InputStreamReader(conn.getInputStream());
            jsonResults = recordResults(in);
        } finally {
            if (in != null) {
                in.close();
            }
            return jsonResults;
        }
    }

    private StringBuilder recordResults(final InputStreamReader in)
            throws IOException {
        int read;
        StringBuilder jsonResults = new StringBuilder();
        char[] buff = new char[1024];
        while ((read = in.read(buff)) != -1) {
            jsonResults.append(buff, 0, read);
        }
        return jsonResults;
    }

    protected void parsePotentialError(final JSONObject mainJsonObj)
            throws JSONException {
        final String status = mainJsonObj.getString("status");
        if (!status.equals("OK")) {
            throw new JSONException("The search could not be completed. " +
                    "Google return the following error code: " + status + ".");
        }
    }
}