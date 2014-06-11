package model;

import static model.AccountForm.getUserAccounts;

public class LoginValidation implements Validation {
    private String username;
    private String password;

    public LoginValidation(String username, String password) {
        this.username = username;
        this.password = password;
    }

    @Override
    public boolean validateCredentials() throws ValidationException {
        if (!usernameExists(username)) {
            throw new ValidationException("Authentication failed. "
                + "Please try again. " + getUserAccounts().get(username).getUsername());
        } else if (!passwordMatches(username, password)) {
            throw new ValidationException("Authentication failed. "
                + "Please try again.");
        }
        return true;
    }

    private boolean passwordMatches(String username, String password) {
        UserAccount currentAccount = getUserAccounts().get(username);
        String realPassword = currentAccount.getPassword();
        return realPassword.equals(password);
    }

    private boolean usernameExists(String username) {
        return getUserAccounts().containsKey(username);
    }
}
