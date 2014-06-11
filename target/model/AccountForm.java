package model;

import static model.Attributes.*;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.Map;

public class AccountForm {
    private static Map<String, UserAccount> userAccounts = new HashMap<String, UserAccount>();
    private HttpServletRequest request;

    public AccountForm(HttpServletRequest request) {
        this.request = request;
    }

    public boolean isAccountCreationSuccessful() {
        try {
            UserAccount newAccount = gatherNewAccountInfo();
            AccountValidation.validateAccountCredentials(newAccount);
            clearSavedAttributes();
            userAccounts.put(newAccount.getUsername(), newAccount);
            return true;
        } catch(AccountFormException ex) {
            request.setAttribute("error", ex.getMessage());
            return false;
        }
    }

    private UserAccount gatherNewAccountInfo() throws AccountFormException {
        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String username = request.getParameter("newUsername");
        String password = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");
        storeAttribute("prevFirstName", firstName);
        storeAttribute("prevLastName", lastName);
        storeAttribute("prevUsername", username);
        UserAccount newAccount = new UserAccount(firstName, lastName, username, password);
        if (password.equals(confirmPassword) == false) {
            throw new AccountFormException("Passwords do not match. " +
                    "Please try again.");
        }
        return newAccount;
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
