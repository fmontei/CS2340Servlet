package model;

import java.io.*;
import java.util.Map;
import java.util.HashMap;

public class UserAccountsSerializable implements Serializable {
    private static Map<String, UserAccount> userAccounts;
    private static File file;

    public Map<String, UserAccount> getUserAccountsSerialized() {
        return userAccounts;
    }

    public void saveData(Map<String, UserAccount> userAccounts) {
        this.userAccounts = userAccounts;
        if (file == null) {
            setFile();
        }
        try
        {
            FileOutputStream fileOut = new FileOutputStream(file);
            ObjectOutputStream out = new ObjectOutputStream(fileOut);
            out.writeObject(this.userAccounts);
            out.close();
            fileOut.close();
        } catch(IOException i) {
            i.printStackTrace();
        }
    }

    public Map<String, UserAccount> loadData() {
        if (file == null) {
            setFile();
        }
        try {
            FileInputStream fileIn = new FileInputStream(file);
            ObjectInputStream in = new ObjectInputStream(fileIn);
            userAccounts = (Map<String, UserAccount>) in.readObject();
            in.close();
            fileIn.close();
        } catch(IOException i) {
            userAccounts = new HashMap<String, UserAccount>();
        } catch(ClassNotFoundException c) {
            c.printStackTrace();
        }
        return userAccounts;
    }

    private void setFile() {
        String filePath = System.getenv("CATALINA_HOME") + "\\webapps\\CS2340Servlet\\UserAccounts.ser";
        file = new File(filePath);
    }
}
