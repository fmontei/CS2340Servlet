package database;

import java.sql.SQLException;
import java.util.List;

public class DataManager {

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

    public static void createItinerary(Itinerary itinerary) throws SQLException {
        new SQLItineraryQuery().createItineraryQuery(itinerary);
    }

    public static List<Itinerary> getItineraryByUserID(int userID)
        throws SQLException {
        List<Itinerary> fetchedItneraries =
                new SQLItineraryQuery().getItinerariesByUserID(userID);
        return fetchedItneraries;
    }
}
