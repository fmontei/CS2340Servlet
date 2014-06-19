package model;

import database.DAL.DataManager;
import database.DTO.User;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.sql.SQLException;

public class AccountUpdateForm {
    private HttpServletRequest request;
    private HttpSession session;
    private User currentAccount;
    private String username;
    private String password;
    private String confirmPassword;
    private String firstName, lastName;

    public AccountUpdateForm(HttpServletRequest request) {
        this.request = request;
        this.session = request.getSession();
        this.username = session.getAttribute("username").toString();
    }

    public boolean isAccountUpdateSuccessful() {
        try {
            gatherNewAccountInfo();
            AccountValidation validation = new AccountValidation
                    (currentAccount, confirmPassword);
            validation.setOperation(new UpdateAccountOperation());
            validation.validateCredentials();
            updateAccountSettings();
            updateSessionAttributes();
            return true;
        } catch (ValidationException ex) {
            request.setAttribute("error", ex.getMessage());
            return false;
        } catch (SQLException ex) {
            request.setAttribute("error", ex.getMessage());
            return false;
        }
    }

    private void gatherNewAccountInfo() throws ValidationException {
        firstName = request.getParameter("updateFirstName");
        lastName = request.getParameter("updateLastName");
        password = request.getParameter("oldPassword");
        confirmPassword = request.getParameter("confirmOldPassword");
        currentAccount = new User(firstName, lastName, username, password);
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

    private void updateSessionAttributes() {
        String welcomeName = currentAccount.getWelcomeName();
        synchronized(session) {
            session.setAttribute("currentUser", currentAccount);
            session.setAttribute("welcomeName", welcomeName);
            session.setAttribute("firstName", firstName);
            session.setAttribute("lastName", lastName);
        }
    }

    private void updateAccountSettings() throws SQLException {
        DataManager.saveUser(currentAccount);
    }

    public boolean hasAccountBeenDeleted() {
        String username = session.getAttribute("username").toString();
        deleteAccount(username);
        return true;
    }

    private void deleteAccount(String username) {
        DataStore dataStore = new DataStore();
        dataStore.deleteAccount(username);
    }
}
