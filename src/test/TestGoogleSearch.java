import database.NearbyPlace;
import model.GooglePlaceAPI;
import model.YelpAPI;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class TestGoogleSearch {
    public static void main(String... args) {
        TestGoogleSearch test = new TestGoogleSearch();
        try {
            test.testYelpAPI();
        } catch (Exception ex) {
            ex.printStackTrace();
        }
    }

    private void testYelpAPI() throws SQLException {
        List<NearbyPlace> results = new ArrayList<NearbyPlace>();
        YelpAPI yelpAPI = new YelpAPI();
        results = yelpAPI.queryAPI("bar", "atlanta, ga", 5000);
        for (NearbyPlace p : results) {
            System.out.println(p.getName() + "\t\t" + p.getURL());
        }
    }
}
