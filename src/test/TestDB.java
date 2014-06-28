import database.*;
import model.AccountCreateForm;

import java.awt.geom.Point2D;
import java.sql.SQLException;
import java.util.List;

public class TestDB {
    public static void main(String... args)  {
        try {
            Point2D point = new Point2D.Double(3.333, 4.444);
            System.out.println(point.getX() + " " + point.getY());
            SQLItineraryQuery query = new SQLItineraryQuery();

            String coordinates = "(33.7489954, -84.3879824)";
            int latBeginIndex = coordinates.indexOf("(") + 1;
            int lngBeginIndex = coordinates.indexOf(",") + 1;
            String latitude = coordinates.substring(latBeginIndex, lngBeginIndex - 1);
            String longitude = coordinates.substring(lngBeginIndex, coordinates.length() - 1);
            Point2D coords = new Point2D.Double(Double.parseDouble(latitude), Double.parseDouble(longitude));
            String formattedCoords = coords.toString();
            formattedCoords = formattedCoords.substring(formattedCoords.indexOf("[") + 1, formattedCoords.length() - 1);
            formattedCoords = formattedCoords.replaceAll("\\s", "");
            System.out.println(formattedCoords);

            //Itinerary it = new Itinerary("Name", "Brazil", new Point2D.Double(3.33333, 4.4444), "car", 42, 2);
            //DataManager.createItinerary(it);
            //Itinerary activeItinerary = query.getItineraryByID(new String("12"));
            //Preference activePreference = new SQLPreferenceQuery().getPreferencesByID(activeItinerary.getID());
            //System.out.println(activePreference.getPreferredAttractionType());

            //SQLPreferenceQuery query1 = new SQLPreferenceQuery();
            //Preference activePreference1 = query1.getPreferencesByID(5);
            //System.out.println("Preferred attractiont type: " + activePreference1.getPreferredAttractionType());
            throw new SQLException("");
        } catch (SQLException ex) {
            System.out.println("CAUGHT EXCEPTION");
            ex.printStackTrace();
        }
    }
}
