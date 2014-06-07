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

    public boolean isAccountCreationSuccessful() {
        tryToGetAccountInfo();
        return tryToValidateCredentials() && tryToGetAccountInfo();
    }

    private boolean tryToGetAccountInfo() {
        try {
            gatherNewAccountInfo();
            return true;
        } catch(PasswordMismatchException ex) {
            request.setAttribute("error", "Passwords do not match. Please try again.");
            return false;
        }
    }

    private boolean tryToValidateCredentials() {
        try {
            validateAccountCredentials();
            userAccounts.put(newAccount.getUsername(), newAccount);
            return true;
        } catch(UserAlreadyExistsException ex) {
            request.setAttribute("error", "Username already taken. Please try again.");
            return false;
        } catch (EmptyFieldException ex) {
            request.setAttribute("error", "All fields must be populated. Please try again.");
            return false;
        }
    }

    private void gatherNewAccountInfo() throws PasswordMismatchException {
        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String username = request.getParameter("newUsername");
        String password = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");
        newAccount = new UserAccount(firstName, lastName, username, password);
        if (password.equals(confirmPassword) == false) {
            throw new PasswordMismatchException();
        }
    }

    public boolean validateAccountCredentials() throws UserAlreadyExistsException, EmptyFieldException {
        if (newAccount.allFieldsHaveValue()) {
            if (usernameExists(newAccount.getUsername())) {
                throw new UserAlreadyExistsException();
            } else {
                return true;
            }
        } else {
            throw new EmptyFieldException();
        }
    }

    protected static boolean isLoginSuccessful(String username, String password) {
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
