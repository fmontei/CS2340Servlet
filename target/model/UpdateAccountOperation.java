package model;

import database.DAL.DataManager;
import database.DTO.User;

import java.sql.SQLException;

public class UpdateAccountOperation implements Validation {
    private String username, password, confirmPassword;
    private User account;

    public void init(User account, String username, String password) {
        this.account = account;
        this.username = username;
        this.password = account.getPassword();
        this.confirmPassword = password;
    }

    public void validateCredentials() throws ValidationException {
        if (isPasswordEmpty()) {
            throw new ValidationException("Password is empty.");
        } else if (!password.equals(confirmPassword)) {
            throw new ValidationException("Passwords do not match. "
                    + "Please try again.");
        }
    }

    private boolean isPasswordEmpty() {
        return password.isEmpty() && confirmPassword.isEmpty();
    }
}
