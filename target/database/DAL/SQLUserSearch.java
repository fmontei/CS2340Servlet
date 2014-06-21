package database.DAL;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class SQLUserSearch {
    private String query, username, fetchedUsername;
    private Connection dbConnection;
    private Statement statement;
    private ResultSet results;

    public SQLUserSearch(final String query, final String username) {
        this.query = query;
        this.username = username;
        executeQuery();
    }

    private void executeQuery()  {
        try {
            dbConnection = ConnectionManager.getConnection();
            statement = dbConnection.createStatement();
            results = statement.executeQuery(query);
            while (results.next()) {
                fetchedUsername = results.getString("userName");
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

    public boolean fetchedUsernameExists() {
        if (fetchedUsername != null && username.equals(fetchedUsername)) {
            return true;
        } else {
            return false;
        }
    }
}
