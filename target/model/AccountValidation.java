package model;

import static model.DataStore.findByUserName;

public class AccountValidation implements  Validation {
    private UserAccount account;
    private String password;
    private String confirmPassword;

    public AccountValidation(UserAccount account,
                             String password,
                             String confirmPassword) {
        this.account = account;
        this.password = password;
        this.confirmPassword = confirmPassword;
    }

    @Override
    public boolean validateCredentials()
            throws ValidationException {
        if (usernameExists(account.getUsername())) {
            throw new ValidationException("Username already taken. "
                + "Please try again.");
        } else if (!password.equals(confirmPassword)) {
            throw new ValidationException("Passwords do not match. "
                + "Please try again.");
        }
        return true;
    }

    private boolean usernameExists(String username) {
        UserAccount temp = findByUserName(username);
        return temp != null;
    }
}
