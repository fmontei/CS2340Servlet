package database;

import model.Coordinates;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class SQLPlaceQuery extends SQLQuery {
    public SQLPlaceQuery() {
        super();
    }

    public void createEventQuery(final Place event, final String type,
                                 final int itineraryID)
        throws SQLException {
        createEventOrLodging(event, type, itineraryID);
    }

    public void createLodgingQuery(final Place lodging, final String type,
                                   final int itineraryID)
        throws SQLException {
        createEventOrLodging(lodging, type, itineraryID);
    }

    private void createEventOrLodging(final Place place, final String type,
                                      final int itineraryID)
        throws SQLException {
        String query = "INSERT INTO PLACE (itineraryID, placeType, name, " +
                "address, phoneNumber, apiType, priceLevel, rating, latitude," +
                "longitude, url, creationDate) " +
                "VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        PreparedStatement preparedStatement =
                super.dbConnection.prepareStatement(query);
        preparedStatement.setInt(1, itineraryID);
        preparedStatement.setString(2, type);
        preparedStatement.setString(3, place.getName());
        preparedStatement.setString(4, place.getFormattedAddress());
        preparedStatement.setString(5, place.getPhoneNumber());
        preparedStatement.setString(6, place.getAPI());
        preparedStatement.setInt(7, place.getPriceLevel());
        preparedStatement.setDouble(8, place.getRating());
        preparedStatement.setDouble(9, place.getCoordinates().getLat());
        preparedStatement.setDouble(10, place.getCoordinates().getLng());
        preparedStatement.setString(11, place.getURL());
        preparedStatement.setString(12, place.getCreationDate().toString());
        preparedStatement.executeUpdate();
    }

    public Place getLodgingByItineraryID(final String itineraryID)
            throws SQLException {
        final String query =
                "SELECT * FROM place, itinerary WHERE itinerary.ID = ? AND " +
                        "place.placeType = ?;";
        PreparedStatement preparedStatement =
                super.dbConnection.prepareStatement(query);
        preparedStatement.setString(1, itineraryID);
        preparedStatement.setString(2, "lodging");
        ResultSet result = preparedStatement.executeQuery();
        Place lodging = new Place();
        while (result.next()) {
            int ID = result.getInt("ID");
            String name = result.getString("name");
            String address = result.getString("address");
            String phoneNumber = result.getString("phoneNumber");
            int priceLevel = result.getInt("priceLevel");
            double rating = result.getDouble("rating");
            double latitude = result.getDouble("latitude");
            double longitude = result.getDouble("longitude");
            Coordinates coordinates = new Coordinates(latitude, longitude);
            String url = result.getString("url");
            String creationDate = result.getString("creationDate");
            String checkIn = result.getString("checkIn");
            String checkOut = result.getString("checkOut");
            lodging.setID(ID);
            lodging.setName(name);
            lodging.setFormattedAddress(address);
            lodging.setPhoneNumber(phoneNumber);
            lodging.setPriceLevel(priceLevel);
            lodging.setRating(rating);
            lodging.setCoordinates(coordinates);
            lodging.setURL(url);
            lodging.setCreationDate(creationDate);
            lodging.setCheckIn(checkIn);
            lodging.setCheckOut(checkOut);
            break;
        }
        return lodging;
    }

    protected void updatePlaceTimeByID(final Place place, final String placeType)
        throws SQLException {
        if (placeType.equals("lodging")) {
            updateLodgingTimeByID(place);
        } else if (placeType.equals("event")) {
            updateEventTimeByID(place);
        }
    }

    private void updateLodgingTimeByID(final Place lodging)
        throws SQLException {
        final String query = "UPDATE PLACE SET checkIn = ?, checkOut = ? " +
                "WHERE ID = ? AND placeType = ?";
        PreparedStatement preparedStatement =
                super.dbConnection.prepareStatement(query);
        preparedStatement.setString(1, lodging.getCheckIn());
        preparedStatement.setString(2, lodging.getCheckOut());
        preparedStatement.setInt(3, lodging.getID());
        preparedStatement.setString(4, "lodging");
        preparedStatement.executeUpdate();
    }

    private void updateEventTimeByID(final Place event)
            throws SQLException {
        final String query = "UPDATE PLACE SET checkIn = ?, checkOut = ? " +
                "WHERE ID = ? AND placeType = ?";
        PreparedStatement preparedStatement =
                super.dbConnection.prepareStatement(query);
        preparedStatement.setString(1, event.getCheckIn());
        preparedStatement.setString(2, event.getCheckOut());
        preparedStatement.setInt(3, event.getID());
        preparedStatement.setString(4, "event");
        preparedStatement.executeUpdate();
    }

    public List<Place> getEventsByItineraryID(final String itineraryID)
            throws SQLException {
        final String query =
                "SELECT * FROM PLACE WHERE PLACE.itineraryID = ? AND " +
                        "PLACE.placeType = ?;";
        PreparedStatement preparedStatement =
                super.dbConnection.prepareStatement(query);
        preparedStatement.setString(1, itineraryID);
        preparedStatement.setString(2, "event");
        ResultSet result = preparedStatement.executeQuery();
        List<Place> events = new ArrayList<Place>();
        while (result.next()) {
            int ID = result.getInt("ID");
            String name = result.getString("name");
            String address = result.getString("address");
            String phoneNumber = result.getString("phoneNumber");
            String apiType = result.getString("apiType");
            int priceLevel = result.getInt("priceLevel");
            double rating = result.getDouble("rating");
            double latitude = result.getDouble("latitude");
            double longitude = result.getDouble("longitude");
            Coordinates coordinates = new Coordinates(latitude, longitude);
            String url = result.getString("url");
            String creationDate = result.getString("creationDate");
            String checkIn = result.getString("checkIn");
            String checkOut = result.getString("checkOut");
            Place event = new Place();
            event.setID(ID);
            event.setName(name);
            event.setFormattedAddress(address);
            event.setPhoneNumber(phoneNumber);
            event.setAPI(apiType);
            event.setPriceLevel(priceLevel);
            event.setRating(rating);
            event.setCoordinates(coordinates);
            event.setURL(url);
            event.setCreationDate(creationDate);
            event.setCheckIn(checkIn);
            event.setCheckOut(checkOut);
            events.add(event);
        }
        return events;
    }

    public void deleteAllPlacesByItineraryID(final String itineraryID)
            throws SQLException {
        final String query = "DELETE FROM PLACE WHERE PLACE.itineraryID = ?";
        PreparedStatement preparedStatement =
                super.dbConnection.prepareStatement(query);
        preparedStatement.setString(1, itineraryID);
        preparedStatement.executeUpdate();
    }

    public void deletePlaceByAttributes(final Place place)
        throws SQLException {
        final String query = "DELETE FROM PLACE WHERE PLACE.name = ? " +
                "AND PLACE.address = ? AND PLACE.phoneNumber = ?";
        PreparedStatement preparedStatement =
                super.dbConnection.prepareStatement(query);
        preparedStatement.setString(1, place.getName());
        preparedStatement.setString(2, place.getFormattedAddress());
        preparedStatement.setString(3, place.getPhoneNumber());
        preparedStatement.executeUpdate();
    }
}
