package model;

import database.DTO.User;

public interface Validation {
    void validateCredentials() throws ValidationException;
    void init(User account, String username, String password);
}
