import database.Itinerary;
import database.Preference;
import database.SQLItineraryQuery;
import database.SQLPreferenceQuery;
import model.AccountCreateForm;

import java.sql.SQLException;
import java.util.List;

public class TestDB {
    public static void main(String... args)  {
        try {
            SQLItineraryQuery query = new SQLItineraryQuery();
            Itinerary activeItinerary = query.getItineraryByID(new String("12"));
            Preference activePreference = new SQLPreferenceQuery().getPreferencesByID(activeItinerary.getID());
            System.out.println(activePreference.getPreferredAttractionType());

            SQLPreferenceQuery query1 = new SQLPreferenceQuery();
            Preference activePreference1 = query1.getPreferencesByID(5);
            System.out.println("Preferred attractiont type: " + activePreference1.getPreferredAttractionType());
        } catch (SQLException ex) {
            System.out.println("CAUGHT EXCEPTION");
            ex.printStackTrace();
        }
    }
}
