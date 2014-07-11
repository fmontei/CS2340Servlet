import database.*;

import java.awt.geom.Point2D;
import java.sql.SQLException;
import java.util.List;

public class TestDB {
    public static void main(String... args)  {
        try {
            TestDB testDB = new TestDB();
            //testDB.testLodgingByItineraryID("16");
            City city = new City("another city", "another", 2, 2, 19);
            Place place = new Place();
            place.setID(110);
            place.setCheckIn("hi");
            place.setCheckOut("hiagain");
            List<City> cities = DataManager.getCitiesAndPlacesByItineraryID(21);
            for (City c : cities) {
                List<Place> events = c.getEvents();
                for (Place e : events) {
                    System.out.println(e.getName());
                }
            }

        } catch (Exception ex) {
            System.out.println("CAUGHT EXCEPTION");
            ex.printStackTrace();
        }
    }

    public void testCoordinates() {
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

    public void testGetPlaceByItineraryID(final int ID) throws SQLException {
        Place lodging = DataManager.getLodgingByCityID(ID);
        System.out.println(lodging.getName());
    }

    public void testDeleteItineraryByID(final String ID) throws SQLException {
        DataManager.deleteItinerary(ID);
    }

    public void testGetEventsByItineraryID(final int ID) throws SQLException {
        List<Place> events = DataManager.getEventsByCityID(ID);
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

    public void testLodgingByItineraryID(final int itineraryID)
            throws SQLException  {
        final SQLPlaceQuery placeQuery = new SQLPlaceQuery();
        Place lodging = placeQuery.getLodgingByCityID(itineraryID);
        System.out.println(lodging.getName());
    }
}
