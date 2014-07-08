import database.*;

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

            String pattern = "yyyy-MM-dd-hh.mm.ss";
            SimpleDateFormat format = new SimpleDateFormat(pattern);
            System.out.println(format.format(new Date()));
            String d1 = format.format(new Date());
            Date newDate1 = new Date();

            Thread.sleep(1000);

            System.out.println(format.format(new Date()));
            String d2 = format.format(new Date());
            Date newDate2 = new Date();

            if (d1.compareTo(d2) < 0)
                System.out.println("D1 is before D2");
            if (newDate1.before(newDate2))
                System.out.println("Date1 is before Date2");

            Date newDate3 = new Date();
            Date newDate4 = new Date();
            if (newDate3.before(newDate4))
                System.out.println("Date3 is before Date4");

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
