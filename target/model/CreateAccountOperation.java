package model;

import database.DAL.DataManager;
import database.DTO.User;

public class CreateAccountOperation implements Validation {
    private String username, password, confirmPassword;
    private User account;

    @Override
    public void init(User account, String username, String password) {
        this.account = account;
        this.username = account.getUsername();
        this.password = account.getPassword();
        this.confirmPassword = password;
    }

    @Override
    public void validateCredentials()
            throws ValidationException {
        if (usernameExists(account.getUsername())) {
            throw new ValidationException("Username already taken. "
                + "Please try again.");
        } else if (!password.equals(confirmPassword)) {
            throw new ValidationException("Passwords do not match. "
                + "Please try again.");
        }
    }

    private boolean usernameExists(String username) {
        return DataManager.usernameExists(username);
    }
}
