package database;

public class SQLQuery {
    public String createUserQuery(User user) {
        final String query = "INSERT INTO user (" +
                "firstName, " +
                "lastName, " +
                "userName, " +
                "password, " +
                "email, " +
                "preferenceID, " +
                "userRole) " +
                " VALUES(" +
                "'" + user.getFirstName() + "', " +
                "'" + user.getLastName() + "', " +
                "'" + user.getUsername() + "', " +
                "'" + user.getPassword() + "', " +
                "'" + user.getEmail() + "', " +
                null + ", " +
                null + ");";
        return  query;
    }

    public String deleteUserQuery(final String username){
        String query = "DELETE FROM user" +
                " WHERE user.userName = '" + username + "';";
        return query;
    }

    public String readUserQuery(String userName){
        String query = "SELECT * FROM user" +
                " WHERE userName = \"" + userName + "\";";
        return query;
    }

    public String updateUserQuery(User user) {
        String firstName = user.getFirstName();
        String lastName = user.getLastName();
        String userName = user.getUsername();
        String password = user.getPassword();
        String email = user.getEmail();
        final String query = "UPDATE user " +
                "SET firstName = '" + firstName + "', " +
                "lastName = '" + lastName + "', " +
                "userName = '" + userName + "', " +
                "password = '" + password + "', " +
                "email = '" + email + "' " +
                "WHERE user.userName = '" + userName + "';";
        return query;
    }

    public String createItineraryQuery(Itinerary itinerary) {
        String query = "INSERT INTO itinerary (name, address, transportationMode) VALUES(" +
                "'" + itinerary.getName() + "', " +
                "'" + itinerary.getAddress() + "', " +
                "'" + itinerary.getTransportationMode() + "');";
        return query;
    }

    public static String updateItineraryQuery(Itinerary itinerary){
        String query = "UPDATE itinerary SET name = " + itinerary.getName() +", " +
                "address = " + itinerary.getAddress() +", " +
                "transportationMode = " + itinerary.getTransportationMode() +", " +
                " WHERE itinerary.ID = " + itinerary.getID() + ";";
        return query;
    }

    public String readItineraryQuery(int ID){
        String query = "SELECT * FROM itinerary" +
                " WHERE itinerary.userID = " + ID + ";";
        return query;
    }
}
