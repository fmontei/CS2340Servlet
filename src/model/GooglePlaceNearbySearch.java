package model;

import database.Lodging;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.io.IOException;
import java.util.ArrayList;

public class GooglePlaceNearbySearch extends GooglePlaceService {
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

    public ArrayList<Lodging> parseJsonResults(StringBuilder jsonResults)
            throws JSONException {
        ArrayList<Lodging> lodgingResults;
        JSONObject mainJsonObj = new JSONObject(jsonResults.toString());
        JSONArray jsonArray = mainJsonObj.getJSONArray("results");
        lodgingResults = new ArrayList<Lodging>(jsonArray.length());
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
            if (jsonObject.has("formatted_address"))
                formattedAddress = jsonObject.getString("formatted_address");
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
            final Lodging lodging = new Lodging();
            lodging.setName(name);
            lodging.setPlaceID(placeID);
            lodging.setFormattedAddress(formattedAddress);
            lodging.setPriceLevel(priceLevel);
            lodging.setRating(rating);
            lodging.setOpenNow(openNow);
            lodgingResults.add(lodging);
        }
        return lodgingResults;
    }
}


