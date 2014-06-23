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
        try {
            new SQLUserQuery().createUserQuery(user);
        } catch (SQLException ex) {
            ex.printStackTrace();
            throw new SQLException("Error: username '" + user.getUsername()
                    + "' already exists. Please try again.");
        }
    }

    public static void deleteUser(final String username) throws SQLException {
        new SQLUserQuery().deleteUserQuery(username);
    }

    public static User fetchUser(String username) throws SQLException {
        User fetchedUser =  new SQLUserQuery().readUserQuery(username);
        return fetchedUser;
    }

    public static void updateUser(User user) throws SQLException {
        new SQLUserQuery().updateUserQuery(user);
    }

    public static List<Itinerary> getItineraryByUserID(int userID)
            throws SQLException {
        String query = new SQLQuery().readItineraryQuery(userID);
        List<Itinerary> itineraries = new ArrayList<Itinerary>();
        try{
            //executeRead(query);
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
}
