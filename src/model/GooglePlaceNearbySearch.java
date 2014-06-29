package model;

import database.NearbyPlace;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

public class GooglePlaceNearbySearch extends GooglePlaceAPI {
    private String coordinates, type;
    private int radius;

    public GooglePlaceNearbySearch(String coordinates, int radius,
                                   String type) {
        this.coordinates = coordinates;
        this.radius = radius;
        this.type = type;
    }

    public String getSearchURL() throws IOException, JSONException {
        final String urlQuery = buildTextSearchQuery();
        return urlQuery;
    }

    private String buildTextSearchQuery() {
        StringBuilder queryBuilder = new StringBuilder();
        queryBuilder.append(PLACES_API_BASE);
        queryBuilder.append(NEARBY_SEARCH);
        queryBuilder.append(OUT_JSON);
        queryBuilder.append("?location=" + coordinates);
        queryBuilder.append("&radius=" + radius);
        queryBuilder.append("&types=" + type);
        queryBuilder.append("&key=" + API_KEY);
        return queryBuilder.toString();
    }

    public List<NearbyPlace> parseJsonResults(StringBuilder jsonResults)
            throws JSONException {
        ArrayList<NearbyPlace> results;
        JSONObject mainJsonObj = new JSONObject(jsonResults.toString());
        JSONArray jsonArray = mainJsonObj.getJSONArray("results");
        results = new ArrayList<NearbyPlace>(jsonArray.length());
        for (int i = 0; i < jsonArray.length(); i++) {
            final JSONObject jsonObject = jsonArray.getJSONObject(i);
            String name = "", placeID = "", formattedAddress = "";
            int priceLevel = 0;
            double rating = 0;
            boolean openNow = false;
            if (jsonObject.has("name"))
                name = jsonObject.getString("name");
            if (jsonObject.has("place_id"))
                placeID = jsonObject.getString("place_id");
            if (jsonObject.has("vicinity"))
                formattedAddress = jsonObject.getString("vicinity");
            if (jsonObject.has("price_level"))
                priceLevel = jsonObject.getInt("price_level");
            if (jsonObject.has("rating"))
                rating = jsonObject.getDouble("rating");
            if (jsonObject.has("opening_hours")) {
                JSONObject hours = jsonObject.getJSONObject("opening_hours");
                if (hours.has("open_now")) {
                    openNow = hours.getBoolean("open_now");
                }
            }
            final NearbyPlace parsedObject = new NearbyPlace();
            parsedObject.setName(name);
            parsedObject.setPlaceID(placeID);
            parsedObject.setFormattedAddress(formattedAddress);
            parsedObject.setPriceLevel(priceLevel);
            parsedObject.setRating(rating);
            parsedObject.setOpenNow(openNow);
            results.add(parsedObject);
        }
        return results;
    }
}


