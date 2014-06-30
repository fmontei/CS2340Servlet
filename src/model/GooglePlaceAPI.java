package model;

import database.Place;
import org.json.JSONException;

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
    protected static final String OUT_JSON = "/json";
    protected static final String API_KEY =
            "AIzaSyB5fL-GAeqRAg0eRTf3NGaiQPrKAlR8iGE";

    private StringBuilder jsonResults = new StringBuilder();

    public ArrayList<Place> textSearch(final String query) throws
            IOException, JSONException {
        ArrayList<Place> results;
        GooglePlaceTextSearch placeTextSearch = new GooglePlaceTextSearch(query);
        final String urlQuery = placeTextSearch.getTextSearchURL();
        queryGoogle(urlQuery);
        results = placeTextSearch.parseJsonResults(jsonResults);
        return results;
    }

    public List<Place> placeSearch(final String coordinates,
                                         final int radius,
                                         final String type)
            throws IOException, JSONException {
        GooglePlaceNearbySearch placeNearbySearch =
                new GooglePlaceNearbySearch(coordinates, radius, type);
        final String urlQuery = placeNearbySearch.getSearchURL();
        queryGoogle(urlQuery);
        List<Place> results = placeNearbySearch.parseJsonResults(jsonResults);
        return results;
    }

    private void queryGoogle(final String urlQuery)
            throws IOException {
        InputStreamReader in = null;
        try {
            final URL url = new URL(urlQuery);
            final HttpURLConnection conn =
                    (HttpURLConnection) url.openConnection();
            in = new InputStreamReader(conn.getInputStream());
            recordResults(in);
        } finally {
            if (in != null) {
                in.close();
            }
        }
    }

    private void recordResults(final InputStreamReader in) throws IOException {
        int read;
        char[] buff = new char[1024];
        while ((read = in.read(buff)) != -1) {
            jsonResults.append(buff, 0, read);
        }
    }
}