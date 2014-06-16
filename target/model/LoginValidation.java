package model;

import org.apache.catalina.User;

import static model.DataStore.findByUserName;

public class LoginValidation {
    private String username;
    private String password;

    public LoginValidation(String username, String password) {
        this.username = username;
        this.password = password;
    }

    public void validateCredentials() throws ValidationException {
        
    }
}
