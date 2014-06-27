package model;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.ArrayList;

public class GooglePlaceService {
    private static final String PLACES_API_BASE = "https://maps.googleapis.com/maps/api/place";
    private static final String TYPE_AUTOCOMPLETE = "/autocomplete";
    private static final String TYPE_DETAILS = "/details";
    private static final String TYPE_SEARCH = "/search";
    private static final String TEXT_SEARCH = "/textsearch";
    private static final String OUT_JSON = "/json";
    private static final String API_KEY = "AIzaSyArSEUjPiYSGlkygmjWk7-IzcozBDqNKqw";

    private StringBuilder jsonResults;

    public GooglePlaceService() {
        jsonResults = new StringBuilder();
    }

    public ArrayList<Place> textSearch(final String query) throws
        IOException, JSONException {
        ArrayList<Place> results = new ArrayList<Place>();
        final String urlQuery = buildTextSearchQuery(query);
        queryGoogle(urlQuery);
        results = parseJsonResults();
        return results;
    }

    private String buildTextSearchQuery(String query) {
        query = query.replaceAll("\\s+", "+");
        StringBuilder queryBuilder = new StringBuilder();
        queryBuilder.append(PLACES_API_BASE);
        queryBuilder.append(TEXT_SEARCH);
        queryBuilder.append(OUT_JSON);
        queryBuilder.append("?query=" + query);
        queryBuilder.append("&key=" + API_KEY);
        return queryBuilder.toString();
    }

    private void queryGoogle(final String urlQuery)
            throws IOException {
        InputStreamReader in = null;
        try {
            final URL url = new URL(urlQuery);
            final HttpURLConnection conn = (HttpURLConnection) url.openConnection();
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

    private ArrayList<Place> parseJsonResults() throws JSONException {
        ArrayList<Place> placeResults;
        JSONObject jsonObj = new JSONObject(jsonResults.toString());
        JSONArray jsonArray = jsonObj.getJSONArray("results");
        placeResults = new ArrayList<Place>(jsonArray.length());
        for (int i = 0; i < jsonArray.length(); i++) {
            final JSONObject jsonObject = jsonArray.getJSONObject(i);
            String name = jsonObject.getString("name");
            String placeID = jsonObject.getString("place_id");
            String formattedAddress = jsonObject.getString("formatted_address");
            int priceLevel = jsonObject.getInt("price_level");
            double rating = jsonObject.getDouble("rating");
            final Place place = new Place(name, placeID, formattedAddress,
                    priceLevel, rating);
            placeResults.add(place);
        }
        return placeResults;
    }
}