package database;

import model.AccountCreateForm;

import java.sql.SQLException;
import java.util.List;

public class TestDB {
    public static void main(String... args)  {
        try {
            SQLItineraryQuery query = new SQLItineraryQuery();
            Itinerary activeItinerary = query.getItineraryByID(new String("12"));
            System.out.println(activeItinerary.getName());
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
    }
}
