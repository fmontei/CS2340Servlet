package database;

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
        String query = "INSERT INTO ITINERARY (name, address, transportation, "
                + "userID) VALUES(?, ?, ?, ?)";
        PreparedStatement preparedStatement =
                super.dbConnection.prepareStatement(query);
        preparedStatement.setString(1, itinerary.getName());
        preparedStatement.setString(2, itinerary.getAddress());
        preparedStatement.setString(3, itinerary.getTransportationMode());
        preparedStatement.setInt(4, itinerary.getUserID());
        preparedStatement.executeUpdate();
    }

    public List<Itinerary> getItinerariesByUserID(int userID)
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
            String name = results.getString("name");
            String address = results.getString("address");
            String transportationMode = results.getString("transportation");
            Itinerary itinerary = new Itinerary(name, address,
                    transportationMode, ID, userID);
            itineraries.add(itinerary);
        }
        return itineraries;
    }
}
