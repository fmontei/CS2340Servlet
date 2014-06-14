package model;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;

public class AccountCreateForm {
    private HttpServletRequest request;
    private String firstName, lastName, username;
    private String password, confirmPassword;
    private UserAccount newAccount;

    public AccountCreateForm(HttpServletRequest request) {
        this.request = request;
    }

    public boolean isAccountCreationSuccessful() {
        try {
            gatherNewAccountInfo();
            Validation validation = new AccountValidation(newAccount,
                password, confirmPassword);
            validation.validateCredentials();
            saveAccountSettings(newAccount);
            storeSessionAttributes();
            return true;
        } catch (ValidationException ex) {
            storeAttributesForNextAttempt(request);
            request.setAttribute("error", ex.getMessage());
            return false;
        }
    }

    private void gatherNewAccountInfo() throws ValidationException {
        firstName = request.getParameter("firstName");
        lastName = request.getParameter("lastName");
        username = request.getParameter("newUsername");
        password = request.getParameter("newPassword");
        confirmPassword = request.getParameter("confirmPassword");
        newAccount = new UserAccount(firstName, lastName, username, password);
    }

    private void saveAccountSettings(UserAccount updatedAccount) {
        DataStore dataStore = new DataStore();
        String username = updatedAccount.getUsername();
        dataStore.saveAccount(username, updatedAccount);
    }

    private void storeSessionAttributes() {
        String firstName = newAccount.getFirstName();
        String lastName = newAccount.getLastName();
        String welcomeName = newAccount.getName();
        ServletContext appContext = request.getServletContext();
        appContext.setAttribute("currentUser", newAccount);
        appContext.setAttribute("username", username);
        appContext.setAttribute("welcomeName", welcomeName);
        appContext.setAttribute("firstName", firstName);
        appContext.setAttribute("lastName", lastName);
    }

    /* These attributes repopulate previously filled-in fields for the user
     * following a page reload due to an error being thrown
     */
    private void storeAttributesForNextAttempt(HttpServletRequest request) {
        request.setAttribute("prevFirstName", firstName);
        request.setAttribute("prevLastName", lastName);
        request.setAttribute("prevUsername", username);
    }
}
