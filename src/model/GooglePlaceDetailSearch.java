package model;

import database.Place;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.io.IOException;

public class GooglePlaceDetailSearch extends GooglePlaceAPI {
    private Place place;
    private String placeID;

    public GooglePlaceDetailSearch(Place place) {
        this.place = place;
        this.placeID = place.getPlaceID();
    }

    public String getSearchURL() throws IOException, JSONException {
        final String urlQuery = buildTextSearchQuery();
        return urlQuery;
    }

    private String buildTextSearchQuery() {
        StringBuilder queryBuilder = new StringBuilder();
        queryBuilder.append(PLACES_API_BASE);
        queryBuilder.append(DETAIL_SEARCH);
        queryBuilder.append(OUT_JSON);
        queryBuilder.append("?placeid=" + placeID);
        queryBuilder.append("&key=" + API_KEY);
        return queryBuilder.toString();
    }

    public void parseJsonResults(StringBuilder jsonResults)
            throws JSONException {
        JSONObject mainJsonObj = new JSONObject(jsonResults.toString());
        super.parsePotentialError(mainJsonObj);
        String url;
        JSONObject result = mainJsonObj.getJSONObject("result");
        if (result.has("url")) {
            url = result.getString("url");
            place.setURL(url);
        }
    }
}
