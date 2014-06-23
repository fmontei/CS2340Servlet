package database;

import java.sql.SQLException;

public class TestDB {
    public static void main(String... args) throws SQLException {
        User u = new User("me1", "me1", "me1", "me1");
        DataManager.deleteUser("fmontei1");
    }
}
