import database.Lodging;
import model.GooglePlaceService;

import java.util.List;

public class TestGoogleSearch {
    public static void main(String... args) {
        try {
            GooglePlaceService googleService = new GooglePlaceService();
            List<Lodging> lodgings = googleService.placeSearch("18.971188,-72.28522", 5000, "lodging");
            System.out.println(lodgings.size());
        } catch (Exception ex) {
            ex.printStackTrace();
        }
    }
}
