package database.main;

import java.sql.SQLException;
import database.DAL.*;
import database.DTO.User;

public class DbDemo {
    public static void main(String[] args) throws SQLException {
        System.out.println("HELLO WORLD!");
        User user = new User("Felipe", "onTEIRO!!", "fmontei", "1");
        if (DataManager.usernameExists(user.getUsername())) {
            System.out.println("User exists");
        } else {
            System.out.println("User does NOT exist!");
        }
        deleteUser(user.getUsername());
        if (DataManager.usernameExists(user.getUsername())) {
            System.out.println("User exists");
        } else {
            System.out.println("User does NOT exist!");
        }
    }

    private static void getUser() throws SQLException {
        try {
            User user = DataManager.getUserByID(1);
            displayUser(user);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    private static void displayUser(User user) {
        System.out.println("User ID:" + user.getID());
        System.out.println("User First Name:" + user.getFirstName());
        System.out.println("User Last Name:" + user.getLastName());
        System.out.println("User User Name:" + user.getUsername());
        System.out.println("User Password:" + user.getPassword());
        System.out.println();
    }

    private static void saveUser(User user) throws SQLException {
        try {
            DataManager.createUser(user);
            System.out.println("User has been saved!");
        } catch (SQLException e){
            e.printStackTrace();
        }
    }

    private static void deleteUser(String username) throws SQLException {
        try {
            DataManager.deleteUser(username);
            System.out.println("User has been deleted!");
        } catch (SQLException e){
            e.printStackTrace();
        }
    }
}
