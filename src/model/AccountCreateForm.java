package model;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

public class AccountCreateForm {
    private HttpServletRequest request;
    private HttpSession session;
    private String firstName, lastName, username;
    private String password, confirmPassword;
    private UserAccount newAccount;

    public AccountCreateForm(HttpServletRequest request) {
        this.request = request;
        this.session = request.getSession();
    }

    public boolean isAccountCreationSuccessful() {
        try {
            gatherNewAccountInfo();
            Validation validation = new AccountValidation(newAccount,
                    password, confirmPassword);
            validation.validateCredentials();
            saveAccountSettings();
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

    private void saveAccountSettings() {
        DataStore dataStore = new DataStore();
        dataStore.saveAccount(username, newAccount);
    }

    private void storeSessionAttributes() {
        String welcomeName = newAccount.getName();
        synchronized(session) {
            session.setAttribute("currentUser", newAccount);
            session.setAttribute("username", username);
            session.setAttribute("welcomeName", welcomeName);
            session.setAttribute("firstName", firstName);
            session.setAttribute("lastName", lastName);
        }
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
