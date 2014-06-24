package database;

import java.sql.SQLException;
import java.util.List;

public class TestDB {
    public static void main(String... args)  {
//        Itinerary it = new Itinerary("b", "b", "b", 25);
        try {
            User user = new User("a", "b", "c", "d");
            user = DataManager.fetchUser("c");
            System.out.print(user.getUsername());
            //DataManager.createItinerary(it);
//            List<Itinerary> itineraries = DataManager.getItineraryByUserID(25);
//            System.out.println(itineraries.size());
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
    }
}
