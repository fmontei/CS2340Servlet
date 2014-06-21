package database.DAL;
import database.DTO.*;

public class Sproc {
    //Read
    public static String Address_ReadByID(int ID){
        String query = "SELECT * FROM address" +
                        " WHERE address.ID = " +
                        Integer.toString(ID);
        return query;
    }
    public static String Attraction_ReadByID(int ID){
        String query = "SELECT * FROM attraction" +
                        " WHERE attraction.ID = " +
                        Integer.toString(ID);
        return query;
    }
    public static String Attraction_Preference_ReadByPreferenceID(int preferenceID){
        String query = "SELECT * FROM attraction_preference" +
                " WHERE attraction_preference.preferenceID = " +
                Integer.toString(preferenceID);
        return query;
    }
    public static String Available_Time_ReadByTripID(int tripID) {
        String query = "SELECT * FROM available_time" +
                        " WHERE available_time.ID = " +
                        Integer.toString(tripID);
        return query;
    }
    public static String Customer_Feedback_ReadByPlaceID(int placeID){
        String query = "SELECT * FROM customer_feedback" +
                        " WHERE customer_feedback.placeID = " +
                        Integer.toString(placeID);
        return query;
    }
    public static String Itinerary_ReadByID(int ID){
        String query = "SELECT * FROM itinerary" +
                        " WHERE itinerary.ID = " +
                        Integer.toString(ID);
        return query;
    }
    public static String Itinerary_ReadByTripID(int tripID){
        String query = "SELECT * FROM itinerary" +
                        " WHERE itinerary.tripID = " +
                        Integer.toString(tripID);
        return query;
    }
    public static String Lodging_ReadByID(int ID){
        String query = "SELECT * FROM lodging" +
                        " WHERE lodging.ID = " +
                        Integer.toString(ID);
        return query;
    }
    public static String Place_ReadByID(int ID){
        String query = "SELECT * FROM place" +
                        " WHERE place.ID = " +
                        Integer.toString(ID);
        return query;
    }
    public static String Preference_ReadByID(int ID){
        String query = "SELECT * FROM preference" +
                        " WHERE preference.ID = " +
                        Integer.toString(ID);
        return query;
    }
    public static String Restaurant_ReadByPlaceID(int placeID){
        String query = "SELECT * FROM restaurant" +
                        " WHERE restaurant.placeID = " +
                        Integer.toString(placeID);
        return query;
    }
    public static String Restaurant_Preference_ReadByPreferenceID(int preferenceID){
        String query = "SELECT * FROM restaurant_preference" +
                        " WHERE restaurant_preference.preferenceID = " +
                        Integer.toString(preferenceID);
        return query;
    }
    public static String Time_Slot_ReadByItineraryID(int itineraryID){
        String query = "SELECT * FROM time_slot" +
                        " WHERE time_slot.itineraryID = " +
                        Integer.toString(itineraryID);
        return query;
    }
    public static String Trip_ReadByID(int ID){
        String query = "SELECT * FROM trip" +
                        " WHERE trip.ID = " +
                        Integer.toString(ID);
        return query;
    }
    public static String Trip_ReadByUserID(int userID){
        String query = "SELECT * FROM trip" +
                        " WHERE trip.userID = " +
                        Integer.toString(userID);
        return query;
    }
    public static String User_ReadAll(){
        String query = "SELECT * FROM user";
        return query;
    }
    public static String User_ReadByID(int ID){
        String query = "SELECT * FROM user" +
                       " WHERE user.ID = " + ID;
        return query;
    }
    public static String User_ReadByUsername(String userName){
        String query = "SELECT * FROM user" +
                       " WHERE userName = \"" + userName + "\";";
        return query;
    }

    //Save
    public static String User_Save(User user) {
        String query = "INSERT INTO user (" +
            "firstName, " +
            "lastName, " +
            "userName, " +
            "password," +
            "userRole) " +
            " VALUES(" +
            "'" + user.getFirstName() + "', " +
            "'" + user.getLastName() + "', " +
            "'" + user.getUsername() + "', " +
            "'" + user.getPassword() + "', " +
            Integer.toString(user.getUserRoleValue()) + ")";
        return  query;
    }

    public static String User_Update(User user) {
        final String query = "UPDATE user " +
            "SET firstName = '" + user.getFirstName() + "', " +
            "lastName = " + "'" + user.getLastName() + "', " +
            "userName = " + "'" + user.getUsername() + "', " +
            "password = " + "'" + user.getPassword() + "', " +
            "userRole = " + Integer.toString(user.getUserRoleValue()) +
            " WHERE userName = \"" + user.getUsername() +"\";";
        System.out.println(query);
        return query;
    }

    //Delete
    public static String Attraction_Preference_DeleteByPreferenceID(int preferenceID){
        String query = "DELETE FROM attraction_preference" +
                        " WHERE attraction_preference.preferenceID = " +
                        Integer.toString(preferenceID);
        return query;
    }
    public static String Available_Time_Delete(int ID){
        String query = "DELETE FROM available_time" +
                        " WHERE available_time.ID = " +
                        Integer.toString(ID);
        return query;
    }
    public static String Itinerary_Delete(int ID){
        String query = "DELETE FROM itinerary" +
                        " WHERE itinerary.ID = " +
                        Integer.toString(ID);
        return query;
    }
    public static String Lodging_Delete(int ID){
        String query = "DELETE FROM lodging" +
                        " WHERE lodging.ID = " +
                        Integer.toString(ID);
        return query;
    }
    public static String Place_Delete(int ID){
        String query = "DELETE FROM place" +
                        " WHERE place.ID = " +
                        Integer.toString(ID);
        return query;
    }
    public static String Preference_Delete(int ID){
        String query = "DELETE FROM preference" +
                        " WHERE preference.ID = " +
                        Integer.toString(ID);
        return query;
    }
    public static String Restaurant_Preference_DeleteByPreferenceID(int preferenceID){
        String query = "DELETE FROM restaurant_preference" +
                        " WHERE restaurant_preference.preferenceID = " +
                        Integer.toString(preferenceID);
        return query;
    }
    public static String Time_Slot_Delete(int ID){
        String query = "DELETE FROM time_slot" +
                        " WHERE time_slot.ID = " +
                        Integer.toString(ID);
        return query;
    }
    public static String Trip_Delete(int ID){
        String query = "DELETE FROM trip" +
                        " WHERE trip.ID = " +
                        Integer.toString(ID);
        return query;
    }
    public static String User_Delete(final String username){
        String query = "DELETE FROM user" +
                        " WHERE user.userName = '" + username + "';";
        return query;
    }
}
