package model;

import database.DAL.DataManager;
import database.DTO.User;

import java.sql.SQLException;

public class UpdateAccountOperation implements Validation {
    private String username, password, confirmPassword;

    public void init(User account, String username, String password) {
        this.username = username;
        this.password = account.getPassword();
        this.confirmPassword = password;
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
        try {
            User accountBeforeChange = DataManager.getUserByUsername(username);
            password = accountBeforeChange.getPassword();
        } catch (SQLException ex) {}
    }
}
