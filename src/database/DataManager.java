package database;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

public class DataManager {
    private static ResultSet results;
    private static Connection dbConnection;
    private static Statement statement;

    public static void createUser(User user) throws SQLException {
        final String query = new SQLQuery().createUserQuery(user);
        try {
            new SQLQueryUpdate(query);
        } catch (SQLException ex) {
            ex.printStackTrace();
            throw new SQLException("Error: username '" + user.getUsername()
                    + "' already exists. Please try again.");
        }
    }

    public static void deleteUser(final String username) throws SQLException {
        final String query = new SQLQuery().deleteUserQuery(username);
        new SQLQueryUpdate(query);
    }

    public static User fetchUser(String username) {
        final String query = new SQLQuery().readUserQuery(username);
        SQLUserSearch userSearch = new SQLUserSearch(query);
        return userSearch.getFetchedUser();
    }

    public static void updateUser(User user) throws SQLException {
        final String query = new SQLQuery().updateUserQuery(user);
        new SQLQueryUpdate(query);
    }

    public static List<Itinerary> getItineraryByUserID(int userID)
            throws SQLException {
        String query = new SQLQuery().readItineraryQuery(userID);
        List<Itinerary> itineraries = new ArrayList<Itinerary>();
        try{
            executeRead(query);
            while(results.next()) {
                int ID = results.getInt("ID");
                String name = results.getString("name");
                String address = results.getString("address");
                String transportationMOde = results.getString("transportationMode");
                Itinerary itinerary = new Itinerary(ID, name, address, transportationMOde);
                itineraries.add(itinerary);
            }
        }catch(SQLException e){
            e.printStackTrace();
        }
        return itineraries;
    }

    private static void executeRead(String query) throws SQLException {
        try{
            dbConnection = ConnectionManager.getConnection();
            statement = dbConnection.createStatement();
            results = statement.executeQuery(query);
        }catch(SQLException e){
            e.printStackTrace();
        }
    }
}
