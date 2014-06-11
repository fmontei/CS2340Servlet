package model;

import static model.Attributes.*;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.Map;

public class AccountForm {
    private static Map<String, UserAccount> userAccounts
        = new HashMap<String, UserAccount>();
    private HttpServletRequest request;
    private String password;
    private String confirmPassword;

    public AccountForm(HttpServletRequest request) {
        this.request = request;
    }

    public boolean isAccountCreationSuccessful() {
        try {
            UserAccount newAccount = gatherNewAccountInfo();
            Validation validation = new AccountValidation(newAccount,
                password, confirmPassword);
            boolean isValid = validation.validateCredentials();
            if (isValid) {
                clearSavedAttributes();
            }
            userAccounts.put(newAccount.getUsername(), newAccount);
            return true;
        } catch (ValidationException ex) {
            request.setAttribute("error", ex.getMessage());
            return false;
        }
    }

    private UserAccount gatherNewAccountInfo() throws ValidationException {
        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String username = request.getParameter("newUsername");
        password = request.getParameter("newPassword");
        confirmPassword = request.getParameter("confirmPassword");
        saveAttributesForNextAttempt(firstName, lastName, username);
        UserAccount newAccount = new UserAccount(firstName, lastName,
            username, password);
        return newAccount;
    }

    private void saveAttributesForNextAttempt(String first,
                                              String last,
                                              String user) {
        storeAttribute("prevFirstName", first);
        storeAttribute("prevLastName", last);
        storeAttribute("prevUsername", user);
    }

    private void clearSavedAttributes() {
        removeAttribute("prevFirstName");
        removeAttribute("prevLastName");
        removeAttribute("prevUsername");
    }

    public static Map<String, UserAccount> getUserAccounts() {
        return userAccounts;
    }
}
