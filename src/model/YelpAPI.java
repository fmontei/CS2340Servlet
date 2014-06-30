package model;

import controller.BrowserErrorHandling;
import database.*;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.scribe.builder.ServiceBuilder;
import org.scribe.model.OAuthRequest;
import org.scribe.model.Response;
import org.scribe.model.Token;
import org.scribe.model.Verb;
import org.scribe.oauth.OAuthService;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.List;

import java.sql.SQLException;

public class YelpAPI {
    private static final String CONSUMER_KEY = "JBsx0El8iU-8Bh-W7X1dcg";
    private static final String CONSUMER_SECRET = "E0A_ZYP-TNKVvBpbx0LH8nG48aI";
    private static final String TOKEN = "NNtHlbMeM49wgfZw1EsTNPzda7XTVf9t";
    private static final String TOKEN_SECRET = "3cEsSKTA9l1_SgzFW6M0kK4HLqI";

    private static final int MAX_DISTANCE_IN_METERS = 40000;
    private static final String SEARCH_PATH = "/v2/search";
    private static final String BUSINESS_PATH = "/v2/business";
    private static final String API_HOST = "api.yelp.com";

    private String term;
    private String location; // pull from itinerary
    private int radius_filter; // in meters 40000 max ~ 25 miles
    private int offset = 0; // offset number of businesses returned by
    private int limit = 10; // number of businesses returned

    private OAuthService service;
    private Token accessToken;

    private HttpServletRequest request;
    private HttpServletResponse response;

    public YelpAPI(HttpServletRequest request, HttpServletResponse response) {
        this.service = new ServiceBuilder().provider(TwoStepOAuth.class)
                .apiKey(CONSUMER_KEY)
                .apiSecret(CONSUMER_SECRET).build();
        this.accessToken = new Token(TOKEN, TOKEN_SECRET);
        this.request = request;
        this.response = response;
    }

    // Constructor for testing
    public YelpAPI() {
        this.service = new ServiceBuilder().provider(TwoStepOAuth.class)
                .apiKey(CONSUMER_KEY)
                .apiSecret(CONSUMER_SECRET).build();
        this.accessToken = new Token(TOKEN, TOKEN_SECRET);
    }

    public List<Place> queryAPI(String term, String location,
                                      final int radiusInMiles)
            throws SQLException {
        this.term = term;
        this.location = location;
        this.radius_filter = convertMilesToMeters(radiusInMiles);

        String searchResponseJSON = searchForBusinessesByLocation();
        JSONParser parser = new JSONParser();
        JSONObject jsonResponse = null;
        try {
            jsonResponse = (JSONObject) parser.parse(searchResponseJSON);
        } catch (ParseException pe) {

        }
        List<Place> businessResults = new ArrayList<Place>();
        JSONArray businesses = (JSONArray) jsonResponse.get("businesses");
        try {
            for (int j = 0; j < businesses.size(); j++) {
                String businessName, businessURL, ratingAsString,
                        displayAddress, displayPhone;
                boolean isOpen;
                double ratingAsDouble;
                JSONObject jsonObject = (JSONObject) businesses.get(j);
                businessName = jsonObject.get("name").toString();
                displayAddress = getDisplayAddress(jsonObject);
                //displayPhone = jsonObject.get("display_phone").toString();
                ratingAsString = jsonObject.get("rating").toString();
                ratingAsDouble = Double.parseDouble(ratingAsString);
                businessURL = jsonObject.get("url").toString();
                isOpen = getIsOpen(jsonObject);
                Place business = new Place();
                business.setName(businessName);
                business.setFormattedAddress(displayAddress);
                //business.setPhoneNumber(displayPhone);
                business.setRating(ratingAsDouble);
                business.setURL(businessURL);
                business.setOpenNow(isOpen);
                businessResults.add(business);
            }
        } catch (Exception ex) {
            BrowserErrorHandling.printErrorToBrowser(request, response, ex);
        }
        return businessResults;
    }

    private String getDisplayAddress(final JSONObject jsonObject) {
        StringBuilder displayAddress = new StringBuilder();
        JSONObject locationArray = (JSONObject) jsonObject.get("location");
        final JSONArray address = (JSONArray) locationArray.get("display_address");
        for (int i = 0; i < address.size(); i++) {
            final String jsonPiece = address.get(i).toString();
            if (i != 1 && i != 2) {
                if (i == 0) {
                    displayAddress.append(jsonPiece + " ");
                } else {
                    displayAddress.append(jsonPiece);
                }
            }
        }
        return displayAddress.toString();
    }

    private boolean getIsOpen(final JSONObject jsonObject) {
        return jsonObject.get("is_closed").equals("true") ? false : true;
    }

    private int convertMilesToMeters(int miles) {
        int meters = (int) (miles * 1609.34);
        if (meters > MAX_DISTANCE_IN_METERS) {
            meters = MAX_DISTANCE_IN_METERS;
        }
        return meters;
    }

    public String searchForBusinessesByLocation() {
        OAuthRequest request = createOAuthRequest(SEARCH_PATH);
        request.addQuerystringParameter("term", term);
        request.addQuerystringParameter("location", location);
        request.addQuerystringParameter("limit", String.valueOf(limit));
        request.addQuerystringParameter("offset", String.valueOf(offset));
        request.addQuerystringParameter("radius_filter", String.valueOf(radius_filter));
        return sendRequestAndGetResponse(request);
    }

    public String searchByBusinessId(String businessID) {
        OAuthRequest request = createOAuthRequest(BUSINESS_PATH + "/" + businessID);
        return sendRequestAndGetResponse(request);
    }

    private OAuthRequest createOAuthRequest(String path) {
        OAuthRequest request = new OAuthRequest(Verb.GET, "http://" + API_HOST + path);
        return request;
    }

    private String sendRequestAndGetResponse(OAuthRequest request) {
        this.service.signRequest(this.accessToken, request);
        Response response = request.send();
        return response.getBody();
    }
}