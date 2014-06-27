import model.GooglePlaceService;
import model.Place;

import java.util.List;

public class TestGoogleSearch {
    public static void main(String... args) {
        List<Place> places;
        try {
            places = new GooglePlaceService().textSearch("pizza in atlanta");
            System.out.println("Printing results:");
            for (Place p : places) {
                System.out.println(p.getName() + "\t" + p.getPriceLevel());
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        }
    }
}
