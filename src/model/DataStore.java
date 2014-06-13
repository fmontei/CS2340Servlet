package model;

import java.io.*;
import java.util.Map;
import java.util.HashMap;

public class DataStore {
    private static Map<String, UserAccount> accountData = new HashMap<String, UserAccount>();
    private static File file;

    public void saveAccount(String username, UserAccount account) {
        loadData();
        accountData.put(username, account);
        saveData();
    }

    public static void loadData() {
        if (file == null) {
            file = new File(System.getProperty("user.dir"));
            file = new File(file.getParent());
            String filePath = file.getPath() + "\\webapps\\CS2340Servlet\\UserAccounts.ser";
            file = new File(filePath);
            System.out.println(file.getPath());
        }
        try {
            FileInputStream fileIn = new FileInputStream(file);
            ObjectInputStream in = new ObjectInputStream(fileIn);
            accountData = (Map<String, UserAccount>) in.readObject();
            in.close();
            fileIn.close();
        } catch(IOException i) {
            accountData = new HashMap<String, UserAccount>();
        } catch(ClassNotFoundException c) {
            c.printStackTrace();
        }
    }

    public static void saveData() {
        if (file == null) {
            file = new File(System.getProperty("user.dir"));
            file = new File(file.getParent());
            String filePath = file.getPath() + "\\webapps\\CS2340Servlet\\UserAccounts.ser";
            file = new File(filePath);
        }
        try {
            FileOutputStream fileOut = new FileOutputStream(file);
            ObjectOutputStream out = new ObjectOutputStream(fileOut);
            out.writeObject(accountData);
            out.close();
            fileOut.close();
        } catch(IOException i) {
            i.printStackTrace();
        }
    }

    public static UserAccount findByUserName(String username) {
        loadData();
        return accountData.get(username);
    }
}