import database.NearbyPlace;
import model.GooglePlaceAPI;

import java.util.List;

public class TestGoogleSearch {
    public static void main(String... args) {
        try {
            GooglePlaceAPI googleService = new GooglePlaceAPI();
            List<NearbyPlace> lodgings = googleService.placeSearch("-33.867217,151.195939", 50000, "lodging");
            for (NearbyPlace l : lodgings) {
                System.out.println( l.getFormattedAddress());
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        }
    }
}
