package model;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.Map;

public class AccountForm {
    private static Map<String, UserAccount> userAccounts = new HashMap<String, UserAccount>();
    private HttpServletRequest request;
    private UserAccount newAccount;

    public AccountForm(HttpServletRequest request) {
        this.request = request;
    }

    public boolean createNewAccount() {
        gatherNewAccountInfo();
        if (areAccountCredentialsValid()) {
            userAccounts.put(newAccount.getUsername(), newAccount);
            return true;
        }
        return false;
    }

    private void gatherNewAccountInfo() {
        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String username = request.getParameter("newUsername");
        String password = request.getParameter("newPassword");
        newAccount = new UserAccount(firstName, lastName, username, password);
    }

    public boolean areAccountCredentialsValid() {
        if (newAccount.allFieldsHaveValue()) {
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
