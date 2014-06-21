package database.DAL;

import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Statement;

public class SQLQueryUpdate {
    private String query;
    private Connection dbConnection;
    private Statement statement;

    public SQLQueryUpdate(final String query) throws SQLException {
        this.query = query;
        executeQuery();
    }

    private void executeQuery() throws SQLException {
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
