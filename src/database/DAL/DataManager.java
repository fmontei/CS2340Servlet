package database.DAL;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import database.DTO.*;

public class DataManager {

    private static Connection dbConnection;
    private static Statement statement;

    public DataManager() {}

    //Read
    /*
    public static Address getAddressByID(){

    }

    public static Attraction getAttractionByID(){

    }

    public static AttractionPreference getAttractionPreferenceByID(){

    }

    public static AvailableTime getAvailableTimeByID() {

    }

    public static CustomerFeedback getCustomerFeedBackByID(){

    }

    public static Itinerary getItinerary(){

    }

    public static Lodging getLodgingByID(){

    }

    public static Place getPlaceByID(){

    }*/

    public static List<Preference> getPreferenceByID(int ID) throws SQLException{
        String query = Sproc.Preference_ReadByID(ID);
        ResultSet results = null;
        List<Preference> preferences = new ArrayList<Preference>();
        try {
            dbConnection = ConnectionManager.getConnection();
            statement = dbConnection.createStatement();
            results = statement.executeQuery(query);
            while (results.next()) {
                Preference preference = new Preference();

                preference.setID(results.getInt("ID"));
                preference.setMinimumRating(results.getDouble("minimumRating"));
                //preference.setPriceCategory(results.getInt("priceCategory"));
                preference.setMaxDistance(results.getInt("maxDistance"));

                //add each user to the list
                preferences.add(preference);
            }
        } finally {
            DbUtil.close(results);
            DbUtil.close(statement);
            DbUtil.close(dbConnection);
        }
        return preferences;
    }

    /*
    public static Restaurant getRestaurantByID(){

    }

    public static RestaurantPreference getRestaurantPreferenceByID(){

    }

    public static TimeSlot getTimeSlotByID(){

    }

    public static List<Trip> getTripByID(){

    }*/

    public static List<Trip> getTripsByUserID(int ID) throws SQLException{
        String query = Sproc.Trip_ReadByUserID(ID);
        ResultSet results = null;
        List<Trip> trips = new ArrayList<Trip>();
        try {
            dbConnection = ConnectionManager.getConnection();
            statement = dbConnection.createStatement();
            results = statement.executeQuery(query);
            while (results.next()) {
                Trip trip = new Trip();

                trip.setID(results.getInt("ID"));
                //trip.setLodging();
                //trip.setTransportationMode();
                //trip.setStartDateTime();
                //trip.setEndDateTime();
                //trip.setItinerary();

                trips.add(trip);
            }
        } finally {
            DbUtil.close(results);
            DbUtil.close(statement);
            DbUtil.close(dbConnection);
        }
        return trips;
    }

    public static void createUser(User user) throws SQLException {
        if (usernameExists(user.getUsername())) {
            throw new SQLException("ERROR: Username '" + user.getUsername()
                    + "' already exists.");
        } else {
            final String query = Sproc.User_Save(user);
            new SQLQueryUpdate(query);
        }
    }

    public static void updateUser(User user) throws SQLException {
        if (usernameExists(user.getUsername())) {
            final String query = Sproc.User_Update(user);
            new SQLQueryUpdate(query);
        } else {
            throw new SQLException("ERROR: Update Failed since User " +
                    "does not exist.");
        }
    }

    public static boolean usernameExists(String username) {
        String query = Sproc.User_ReadByUsername(username);
        SQLUserSearch userSearch = new SQLUserSearch(query, username);
        return userSearch.fetchedUsernameExists();
    }

    public static User getUserByUsername(final String username)
            throws SQLException {
        String query = Sproc.User_ReadByUsername(username);
        ResultSet results = null;
        User user = null;
        try {
            dbConnection = ConnectionManager.getConnection();
            statement = dbConnection.createStatement();
            results = statement.executeQuery(query);
            while (results.next()) {
                user = new User("", "", "", "");
                user.setFirstName(results.getString("firstName"));
                user.setLastName(results.getString("lastName"));
                user.setUserName(results.getString("userName"));
                user.setPassword(results.getString("password"));
                break;
            }
        } finally {
            DbUtil.close(results);
            DbUtil.close(statement);
            DbUtil.close(dbConnection);
            return user;
        }
    }

    public static User getUserByID(int ID) throws SQLException{
        String query = Sproc.User_ReadByID(ID);
        ResultSet results = null;
        List<User> users = new ArrayList<User>();
        try {
            dbConnection = ConnectionManager.getConnection();
            statement = dbConnection.createStatement();
            results = statement.executeQuery(query);
            while (results.next()) {
                User user = new User("", "", "", "");

                user.setID(results.getInt("ID"));
                user.setFirstName(results.getString("firstName"));
                user.setLastName(results.getString("lastName"));
                user.setUserName(results.getString("userName"));
                user.setPassword(results.getString("password"));
                //user.setPreference(getPreferenceByID(results.getInt("preferenceID")).get(0));
                //user.setTrips();*/

                //add each user to the list
                users.add(user);
            }
        } finally {
            DbUtil.close(results);
            DbUtil.close(statement);
            DbUtil.close(dbConnection);
        }
        User userDTO = users.get(0);
        return userDTO;
    }

    public static void deleteUser(String username) throws SQLException {
        final String query = Sproc.User_Delete(username);
        System.out.println(query);
        try {
            dbConnection = ConnectionManager.getConnection();
            statement = dbConnection.createStatement();
            statement.executeUpdate(query);
        } finally {
            DbUtil.close(statement);
            DbUtil.close(dbConnection);
        }
    }
}
