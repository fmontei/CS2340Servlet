package database;

import model.AccountCreateForm;

import java.sql.SQLException;
import java.util.List;

public class TestDB {
    public static void main(String... args)  {
        Itinerary it = new Itinerary("b", "b", "b", 41);
        try {
            //User u = new User("u", "u", "u", "u");
            //DataManager.createUser(u);
            DataManager.createItinerary(it);
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
    }
}
