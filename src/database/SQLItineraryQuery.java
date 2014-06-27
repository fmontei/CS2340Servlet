package database;

import java.awt.geom.Point2D;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class SQLItineraryQuery extends SQLQuery {
    public SQLItineraryQuery() {
        super();
    }

    public void createItineraryQuery(Itinerary itinerary) throws SQLException {
        String query = "INSERT INTO ITINERARY (userID, name, address, " +
                "latitude, longitude, transportation, creationDate," +
                "preferenceID) VALUES(?, ?, ?, ?, ?, ?, ?, ?)";
        PreparedStatement preparedStatement =
                super.dbConnection.prepareStatement(query);
        preparedStatement.setInt(1, itinerary.getUserID());
        preparedStatement.setString(2, itinerary.getName());
        preparedStatement.setString(3, itinerary.getAddress());
        preparedStatement.setDouble(4, itinerary.getCoordinates().getX());
        preparedStatement.setDouble(5, itinerary.getCoordinates().getY());
        preparedStatement.setString(6, itinerary.getTransportationMode());
        preparedStatement.setString(7, itinerary.getCreationDate());
        preparedStatement.setInt(8, itinerary.getPreferenceID());
        preparedStatement.executeUpdate();
    }

    public void deleteItineraryQuery(String itineraryID) throws SQLException {
        String query = "DELETE FROM ITINERARY WHERE ITINERARY.ID = ?";
        PreparedStatement preparedStatement =
                super.dbConnection.prepareStatement(query);
        preparedStatement.setString(1, itineraryID);
        preparedStatement.executeUpdate();
    }

    public Itinerary getItineraryByID(final String ID) throws SQLException {
        final String query = "SELECT * FROM itinerary WHERE ID = ?;";
        PreparedStatement preparedStatement =
                super.dbConnection.prepareStatement(query);
        preparedStatement.setString(1, ID);
        ResultSet results = preparedStatement.executeQuery();
        Itinerary itinerary = new Itinerary();
        while (results.next()) {
            String name = results.getString("name");
            String address = results.getString("address");
            String transportationMode = results.getString("transportation");
            String creationDate = results.getString("creationDate");
            int intID = Integer.parseInt(ID);
            int userID = results.getInt("userID");
            int preferenceID = results.getInt("preferenceID");
            float latitude = results.getFloat("latitude");
            float longitude = results.getFloat("longitude");
            Point2D coordinates = new Point2D.Float(latitude, longitude);
            itinerary = new Itinerary(name, address, coordinates,
                    transportationMode, creationDate, intID, userID,
                    preferenceID);
            break;
        }
        return itinerary;
    }

    public List<Itinerary> getItinerariesByUserID(final int userID)
            throws SQLException {
        List<Itinerary> itineraries = new ArrayList<Itinerary>();
        final String query = "SELECT * FROM itinerary " +
                "WHERE userID = ?;";
        PreparedStatement preparedStatement =
                super.dbConnection.prepareStatement(query);
        preparedStatement.setInt(1, userID);
        ResultSet results = preparedStatement.executeQuery();
        while(results.next()) {
            int ID = results.getInt("ID");
            int preferenceID = results.getInt("preferenceID");
            String name = results.getString("name");
            String address = results.getString("address");
            String transportationMode = results.getString("transportation");
            String creationDate = results.getString("creationDate");
            float latitude = results.getFloat("latitude");
            float longitude = results.getFloat("longitude");
            Point2D coordinates = new Point2D.Float(latitude, longitude);
            Itinerary itinerary = new Itinerary(name, address, coordinates,
                    transportationMode, creationDate, ID, userID, preferenceID);
            itineraries.add(itinerary);
        }
        return itineraries;
    }
}
