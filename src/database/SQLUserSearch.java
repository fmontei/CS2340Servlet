package database;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class SQLUserSearch {
    private String query;
    private Connection dbConnection;
    private Statement statement;
    private ResultSet results;
    private User fetchedUser = new User();

    public SQLUserSearch(final String query) {
        this.query = query;
        executeQuery();
    }

    private void executeQuery()  {
        try {
            dbConnection = ConnectionManager.getConnection();
            statement = dbConnection.createStatement();
            results = statement.executeQuery(query);
            while (results.next()) {
                final int userID = results.getInt("ID");
                final String firstName = results.getString("firstName");
                final String lastName = results.getString("lastName");
                final String userName = results.getString("userName");
                final String password = results.getString("password");
                fetchedUser.setID(userID);
                fetchedUser.setFirstName(firstName);
                fetchedUser.setLastName(lastName);
                fetchedUser.setPassword(password);
                fetchedUser.setUserName(userName);
                break;
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        } finally {
            closeAllConnections();
        }
    }

    private void closeAllConnections() {
        DbUtil.close(results);
        DbUtil.close(statement);
        DbUtil.close(dbConnection);
    }

    public User getFetchedUser() {
        return fetchedUser;
    }
}