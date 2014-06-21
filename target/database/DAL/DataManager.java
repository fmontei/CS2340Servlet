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

    public static User fetchUser(String username) {
        String query = Sproc.User_ReadByUsername(username);
        SQLUserSearch userSearch = new SQLUserSearch(query);
        return userSearch.getFetchedUser();
    }

    public static void createUser(User user) throws SQLException {
        final String query = Sproc.User_Save(user);
        try {
            new SQLQueryUpdate(query);
        } catch (SQLException ex) {
            throw new SQLException("Error: username '" + user.getUsername()
                    + "' already exists. Please try again.");
        }
    }

    public static void updateUser(User user) throws SQLException {
        final String query = Sproc.User_Update(user);
        new SQLQueryUpdate(query);
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
                User user = new User();
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
        new SQLQueryUpdate(query);
    }
}
