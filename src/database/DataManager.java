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

    public static void deleteItinerary(String itineraryID) throws SQLException {
        DataManager.deleteAllPlacesAssociatedWithItinerary(itineraryID);
        final SQLItineraryQuery itineraryQuery = new SQLItineraryQuery();
        itineraryQuery.deleteItineraryQuery(itineraryID);
    }

    private static void deleteAllPlacesAssociatedWithItinerary(
            final String itineraryID) throws SQLException {
        SQLPlaceQuery sqlQuery = new SQLPlaceQuery();
        sqlQuery.deletePlaceByItineraryID(itineraryID);
    }

    public static List<Itinerary> getItineraryByUserID(int userID)
            throws SQLException {
        List<Itinerary> fetchedItneraries =
                new SQLItineraryQuery().getItinerariesByUserID(userID);
        return fetchedItneraries;
    }

    public static int createPreference(Preference preference) throws SQLException {
        int lastID = 0;
        try {
            lastID = new SQLPreferenceQuery().createPreferenceQuery(preference);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return lastID;
    }

    public static void createLodging(final Place lodging, final int itineraryID)
            throws SQLException {
        SQLPlaceQuery sqlQuery = new SQLPlaceQuery();
        sqlQuery.createLodgingQuery(lodging, "lodging", itineraryID);
    }

    public static Place getLodgingByItineraryID(final String itineraryID)
        throws SQLException {
        SQLPlaceQuery sqlQuery = new SQLPlaceQuery();
        final Place lodging = sqlQuery.getLodgingByItineraryID(itineraryID);
        return lodging;
    }

    public static void createEvent(final Place event, final int itineraryID)
        throws SQLException {
        SQLPlaceQuery sqlQuery = new SQLPlaceQuery();
        sqlQuery.createEventQuery(event, "event", itineraryID);
    }

    public static List<Place> getEventsByItineraryID(final String itineraryID)
            throws SQLException {
        SQLPlaceQuery sqlQuery = new SQLPlaceQuery();
        final List<Place> events = sqlQuery.getEventsByItineraryID(itineraryID);
        return events;
    }
}
