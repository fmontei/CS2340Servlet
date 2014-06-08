package model;

import static model.Attributes.*;

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
        if (tryToGetAccountInfoAndValidateCredentials() == false)
            return false;
        elseClearSavedAttributes();
        return true;
    }

    private boolean tryToGetAccountInfoAndValidateCredentials() {
        try {
            gatherNewAccountInfo();
            validateAccountCredentials();
            userAccounts.put(newAccount.getUsername(), newAccount);
            return true;
        } catch(PasswordMismatchException ex) {
            request.setAttribute("error", ex.getMessage());
            return false;
        } catch(UserAlreadyExistsException ex) {
            request.setAttribute("error", ex.getMessage());
            return false;
        } catch (EmptyFieldException ex) {
            request.setAttribute("error", ex.getMessage());
            return false;
        }
    }

    private void gatherNewAccountInfo() throws PasswordMismatchException {
        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String username = request.getParameter("newUsername");
        String password = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");
        storeAttribute("prevFirstName", firstName);
        storeAttribute("prevLastName", lastName);
        storeAttribute("prevUsername", username);
        newAccount = new UserAccount(firstName, lastName, username, password);
        if (password.equals(confirmPassword) == false) {
            throw new PasswordMismatchException("Passwords do not match. Please try again.");
        }
    }

    public boolean validateAccountCredentials() throws UserAlreadyExistsException, EmptyFieldException {
        if (newAccount.allFieldsHaveValue()) {
            if (usernameExists(newAccount.getUsername())) {
                throw new UserAlreadyExistsException("Username already taken. Please try again.");
            } else {
                return true;
            }
        } else {
            throw new EmptyFieldException("All fields must be populated. Please try again.");
        }
    }

    private void elseClearSavedAttributes() {
        removeAttribute("prevFirstName");
        removeAttribute("prevLastName");
        removeAttribute("prevUsername");
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
