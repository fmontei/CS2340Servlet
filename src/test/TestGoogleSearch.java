import database.Place;
import model.GooglePlaceAPI;
import model.YelpAPI;
import org.json.JSONException;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class TestGoogleSearch {
    public static void main(String... args) {
        TestGoogleSearch test = new TestGoogleSearch();
        try {
            test.testYelpAPI();
            //test.testGoogleNearbySearch();
        } catch (Exception ex) {
            ex.printStackTrace();
        }
    }

    private void testYelpAPI() throws SQLException {
        List<Place> results = new ArrayList<Place>();
        YelpAPI yelpAPI = new YelpAPI();
        try {
            results = yelpAPI.queryAPI("lodging", "atlanta, ga", 24, 1, 0);
            System.out.println("NUMBER OF RESULTS: " + results.size());
        } catch (JSONException ex) {
            ex.printStackTrace();
        }
        for (Place p : results) {
            System.out.println(p.getFormattedAddress());
        }
    }

    private void testGoogleNearbySearch() throws IOException, JSONException {
        GooglePlaceAPI googleSearch
                = new GooglePlaceAPI();
        List<Place> results = googleSearch.getByPlaceSearch("-33.870943,151.190311", 15, "gas_station", "bp");
        for (Place p : results) {
            System.out.println(p.getRating() + "\t" + p.isOpenNow());
        }
        googleSearch.getByDetailSearch(results.get(0));
        System.out.println(results.get(0).getURL());
    }
}
