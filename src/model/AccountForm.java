package model;

import static model.Attributes.*;

import javax.servlet.http.HttpServletRequest;
import java.util.Map;

public class AccountForm {
    private HttpServletRequest request;
    private String firstName, lastName, username;
    private String password, confirmPassword;

    public AccountForm(HttpServletRequest request) {
        this.request = request;
    }

    public boolean isAccountCreationSuccessful() {
        try {
            UserAccount newAccount = gatherNewAccountInfo();
            Validation validation = new AccountValidation(newAccount,
                password, confirmPassword);
            validation.validateCredentials();
            changeAccountSettings(newAccount);
            storeLoginAttributes();
            clearTemporaryAttributes();
            return true;
        } catch (ValidationException ex) {
            saveAttributesForNextAttempt(firstName, lastName, username);
            request.setAttribute("error", ex.getMessage());
            return false;
        }
    }

    private UserAccount gatherNewAccountInfo() throws ValidationException {
        firstName = request.getParameter("firstName");
        lastName = request.getParameter("lastName");
        username = request.getParameter("newUsername");
        password = request.getParameter("newPassword");
        confirmPassword = request.getParameter("confirmPassword");
        UserAccount newAccount = new UserAccount(firstName, lastName,
            username, password);
        return newAccount;
    }

    private void saveAttributesForNextAttempt(String first,
        String last, String user) {
        storeAttribute("prevFirstName", first);
        storeAttribute("prevLastName", last);
        storeAttribute("prevUsername", user);
    }

    private void changeAccountSettings(UserAccount updatedAccount) {
        DataStore dataStore = new DataStore();
        String username = updatedAccount.getUsername();
        dataStore.saveAccount(username, updatedAccount);
    }

    private void storeLoginAttributes() {
        UserAccount currentAccount = DataStore.findByUserName(username);
        String welcomeName = currentAccount.getName();
        String firstName = currentAccount.getFirstName();
        String lastName = currentAccount.getLastName();
        Attributes.storeAttribute(Attributes.WELCOME_NAME, welcomeName);
        Attributes.storeAttribute(Attributes.CURRENT_USER, username);
        Attributes.storeAttribute("firstName", firstName);
        Attributes.storeAttribute("lastName", lastName);
        Attributes.storeAttribute("username", username);
    }

    private void clearTemporaryAttributes() {
        removeAttribute("prevFirstName");
        removeAttribute("prevLastName");
        removeAttribute("prevUsername");
    }
}
