package model;

public class AccountValidation {
    private UserAccount account;
    private String username, confirmPassword;
    private Validation operation;

    public AccountValidation(UserAccount account, String confirmPassword) {
        this.account = account;
        this.username = account.getUsername();
        this.confirmPassword = confirmPassword;
    }

    public AccountValidation(String username, String confirmPassword) {
        this.account = DataStore.findByUserName(username);
        this.username = username;
        this.confirmPassword = confirmPassword;
    }

    public void setOperation(Validation operation) {
        this.operation = operation;
        operation.init(account, username, confirmPassword);
    }

    public void validateCredentials() throws ValidationException {
        operation.validateCredentials();
    }
}
