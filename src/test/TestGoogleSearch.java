import model.GooglePlaceService;

public class TestGoogleSearch {
    public static void main(String... args) {
        try {
            GooglePlaceService googleService = new GooglePlaceService();
            //String search = googleService.placeSearch("-33.8670522,151.1957362", 5000, "lodging", "lodging");
            //System.out.println(search);
        } catch (Exception ex) {
            ex.printStackTrace();
        }
    }
}
