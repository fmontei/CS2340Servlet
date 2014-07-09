import database.*;
import model.LodgingForm;

import java.awt.geom.Point2D;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

public class TestDB {
    public static void main(String... args)  {
        try {
            TestDB testDB = new TestDB();
            testDB.testGetPlaceByItineraryID("15");

            SQLPlaceQuery placeQuery = new SQLPlaceQuery();
            Place lodging = placeQuery.getLodgingByItineraryID("16");
            final String checkOut = lodging.getCheckOut();
            System.out.println(checkOut);
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd'T'hh:mm");
            Date parsed = sdf.parse(checkOut);
            System.out.println(parsed.toString());

            SimpleDateFormat sdf1 = new SimpleDateFormat("MM/dd/YYY @ hh:mm a");
            sdf1.setTimeZone(sdf.getTimeZone());
            String newDate = sdf1.format(parsed);
            System.out.println(newDate);

        } catch (Exception ex) {
            System.out.println("CAUGHT EXCEPTION");
            ex.printStackTrace();
        }
    }

    public void testCoordinates() {
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
    }

    public void testCreateLodging(final String name) throws SQLException {
        Place lodging = new Place();
        lodging.setName(name);
        lodging.setFormattedAddress(name);
        DataManager.createLodging(lodging, 14);
    }

    public void testGetPlaceByItineraryID(final String ID) throws SQLException {
        Place lodging = DataManager.getLodgingByItineraryID(ID);
        System.out.println(lodging.getName());
    }

    public void testDeleteItineraryByID(final String ID) throws SQLException {
        DataManager.deleteItinerary(ID);
    }

    public void testGetEventsByItineraryID(final String ID) throws SQLException {
        List<Place> events = DataManager.getEventsByItineraryID(ID);
        System.out.println("Itinerary ID: " + ID);
        System.out.println("Number of events: " + events.size());
        for (Place p : events) {
            System.out.println(p.getName());
        }
    }

    public void testDeleteEventByEventID(final Place place)
            throws SQLException {
        DataManager.deleteEventByEventAttributes(place);
    }
}
