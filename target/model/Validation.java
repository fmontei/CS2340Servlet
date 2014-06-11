package model;

public interface Validation {
    boolean validateCredentials() throws ValidationException;
}
