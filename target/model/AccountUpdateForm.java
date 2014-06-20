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
            if (ex.getMessage().equals("Password is empty.")) {
                revertToOldPasswordAndUpdateAccount();
                return true;
            }
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
        DataManager.updateUser(currentAccount);
    }

    private void revertToOldPasswordAndUpdateAccount() {
        try {
            User accountBeforeChange = DataManager.getUserByUsername(username);
            String passwordBeforeChange = accountBeforeChange.getPassword();
            currentAccount.setPassword(passwordBeforeChange);
            updateAccountSettings();
        } catch (SQLException ex) {
        }
    }

    public boolean hasAccountBeenDeleted() {
        String username = session.getAttribute("username").toString();
        deleteAccount(username);
        return true;
    }

    private void deleteAccount(String username) {
        //DataStore dataStore = new DataStore();
        //dataStore.deleteAccount(username);
    }
}
