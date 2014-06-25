package database;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by Joseph on 6/24/2014.
 */
public class SqlPreferenceQuery extends SQLQuery {
    public SqlPreferenceQuery() { super(); }

    public int createPreferenceQuery(Preference preference) throws SQLException {
        String query = "INSERT INTO preference (minimumRating, priceCategory, maxDistance, "
                + "foodType, attractionType) VALUES(?, ?, ?, ?, ?)";
        PreparedStatement preparedStatement =
                super.dbConnection.prepareStatement(query);
        preparedStatement.setFloat(1, preference.getMinimumRating());
        preparedStatement.setString(2, preference.getPriceCategory());
        preparedStatement.setInt(3, preference.getMaxDistance());
        preparedStatement.setString(4, preference.getPreferredAttractionType());
        preparedStatement.setString(5, preference.getPreferredFoodType());
        preparedStatement.executeUpdate();

        ResultSet results = preparedStatement.getGeneratedKeys();
        int lastID = 0;
        while (results.next()) {
            lastID = results.getBigDecimal(1).intValueExact();
        }
        return lastID;
    }

    public List<Preference> getPreferencesByUserID(int userID)
            throws SQLException {
        List<Preference> preferences = new ArrayList<Preference>();
        final String query = "SELECT * FROM preference " +
                "WHERE userID = ?;";
        PreparedStatement preparedStatement =
                super.dbConnection.prepareStatement(query);
        preparedStatement.setInt(1, userID);
        ResultSet results = preparedStatement.executeQuery();
        while (results.next()) {
            int ID = results.getInt("ID");
            float minimumRating = results.getFloat("minimumRating");
            String priceCategory = results.getString("priceCategory");
            int maxDistance = results.getInt("maxDistance");
            String foodType = results.getString("preferredFoodType");
            String attractionType = results.getString("preferredAttractionType");
            Preference preference = new Preference(minimumRating, priceCategory,
                    maxDistance, foodType, attractionType);
            preferences.add(preference);
        }
        return preferences;
    }
}
