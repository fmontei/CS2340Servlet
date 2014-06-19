package main;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.sql.SQLException;
import DAL.*;
import DTO.*;

public class DbDemo {
    public static void main(String[] args) throws SQLException {
        getUser();
    }

    private static void getUser() throws SQLException {
        try {
            User user = new User();
            user = DataManager.getUserByID(1);
            displayUser(user);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    private static void displayUser(User user) {
        System.out.println("User ID:" + user.getID());
        System.out.println("User First Name:" + user.getFirstName());
        System.out.println("User Last Name:" + user.getLastName());
        System.out.println("User User Name:" + user.getUserName());
        System.out.println("User Password:" + user.getPassword());
        System.out.println();
    }

    private static void saveUser(User user) throws SQLException {
        try {
            DataManager.saveUser(user);
            System.out.println("User has been saved!");
        } catch (SQLException e){
            e.printStackTrace();
        }
    }

    private static void deleteUser(int ID) throws SQLException {
        try {
            DataManager.deleteUser(ID);
            System.out.println("User has been deleted!");
        } catch (SQLException e){
            e.printStackTrace();
        }
    }
}
