import database.Lodging;
import model.GooglePlaceService;

import java.util.List;

public class TestGoogleSearch {
    public static void main(String... args) {
        try {
            GooglePlaceService googleService = new GooglePlaceService();
            List<Lodging> lodgings = googleService.placeSearch("-33.867217,151.195939", 50000, "lodging");
            for (Lodging l : lodgings) {
                System.out.println( l.getFormattedAddress());
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        }
    }
}
