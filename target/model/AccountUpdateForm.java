package model;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;

public class AccountUpdateForm {
    private HttpServletRequest request;
    private UserAccount currentAccount;
    private String username;
    private String password;
    private String confirmPassword;
    private String firstName, lastName;
    public AccountUpdateForm(HttpServletRequest request) {
        this.request = request;
    }

    public boolean isAccountCreationSuccessful() {
        try {
            gatherNewAccountInfo();
            validateCredentials();
            storeLoginAttributes();
            return true;
        } catch (ValidationException ex) {
            request.setAttribute("error", ex.getMessage());
            return false;
        }
    }

    private void gatherNewAccountInfo() throws ValidationException {
        ServletContext appContext = request.getServletContext();
        UserAccount currentUser = (UserAccount) appContext.getAttribute("currentUser");
        username = currentUser.getUsername();
        firstName = request.getParameter("updateFirstName");
        lastName = request.getParameter("updateLastName");
        password = request.getParameter("oldPassword");
        confirmPassword = request.getParameter("confirmOldPassword");
    }

    public void validateCredentials() throws ValidationException {
        /* Assumption: User does not want to change password.
         * Why force him to re-enter it? */
       if (isPasswordEmpty()) {
           revertToOldPassword();
           return;
       } else if (!password.equals(confirmPassword)) {
            throw new ValidationException("Passwords do not match. "
                + "Please try again.");
        }
    }

    private boolean isPasswordEmpty() {
        return password == "" && confirmPassword == "";
    }

    private void revertToOldPassword() {
        UserAccount accountBeforeChange = DataStore.findByUserName(username);
        password = accountBeforeChange.getPassword();
    }

    private void storeLoginAttributes() {
        currentAccount = new UserAccount(firstName, lastName, username, password);
        String welcomeName = currentAccount.getName();
        String firstName = currentAccount.getFirstName();
        String lastName = currentAccount.getLastName();
        ServletContext appContext = request.getServletContext();
        appContext.setAttribute("welcomeName", welcomeName);
        appContext.setAttribute("currentUser", currentAccount);
        appContext.setAttribute("firstName", firstName);
        appContext.setAttribute("lastName", lastName);
        updateAccountSettings(currentAccount);
    }

    private void updateAccountSettings(UserAccount updatedAccount) {
        DataStore dataStore = new DataStore();
        String username = updatedAccount.getUsername();
        dataStore.saveAccount(username, updatedAccount);
    }
}
