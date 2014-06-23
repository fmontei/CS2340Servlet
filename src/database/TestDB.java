package database;

import java.sql.SQLException;

public class TestDB {
    public static void main(String... args)  {
        User u = new User("me11", "me111", "me111", "me11");
        try {
            DataManager.updateUser(u);
            User u1 = DataManager.fetchUser("me111");
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
    }
}
