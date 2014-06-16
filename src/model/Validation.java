package model;

public interface Validation {
    void validateCredentials() throws ValidationException;
    void init(UserAccount account, String username, String password);
}
