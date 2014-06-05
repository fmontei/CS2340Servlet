package model;

import java.util.HashMap;
import java.util.Map;

public class AccountForm {
    private static Map<String, UserAccount> userAccounts = new HashMap<String, UserAccount>();
    public static final int NUM_FIELDS = 4;

    public void createNewUserAccount(UserAccount newAccount) {
        userAccounts.put(newAccount.getUsername(), newAccount);
    }

    public boolean verifyCredentials(UserAccount newAccount) {
        if (newAccount.everythingHasValue()) {
            if (usernameExists(newAccount.getUsername())) {
                return false;
            }
            else {
                return true;
            }
        }
        else {
            return false;
        }
    }

    protected static boolean loginSuccessful(String username, String password) {
        return usernameExists(username) && passwordMatches(username, password);
    }

    protected static boolean usernameExists(String username) {
        return userAccounts.containsKey(username);
    }

    protected static boolean passwordMatches(String username, String password) {
        UserAccount currentAccount = userAccounts.get(username);
        String realPassword = currentAccount.getPassword();
        return realPassword.equals(password);
    }

    public static Map<String, UserAccount> getUserAccounts() {
        return userAccounts;
    }
}
