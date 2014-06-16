package model;

public class LoginAccountOperation implements Validation {
    private UserAccount account;
    private  String username, password;

    public void init(UserAccount account, String username, String password) {
        this.account = account;
        this.username = username;
        this.password = password;
    }

    public void validateCredentials() throws ValidationException {
        if (!usernameExists()) {
            throw new ValidationException("Username " + "\"" + username + "\""
                + " does not exist. Please try again.");
        } else if (!passwordMatches()) {
            throw new ValidationException("Authentication failed. "
                + "Please try again.");
        }
    }

    private boolean passwordMatches() {
        String realPassword = account.getPassword();
        return realPassword.equals(password);
    }

    private boolean usernameExists() {
        return account != null;
    }
}
