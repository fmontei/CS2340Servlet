package model;

import java.io.Serializable;

public class UserAccount implements Serializable{
    private String firstName;
    private String lastName;
    private String username;
    private String password;
    private String preferredTravelMode;

    public UserAccount(String first, String last, String username, String password) {
        this.firstName = first;
        this.lastName = last;
        this.username = username;
        this.password = password;
        preferredTravelMode = "driving";
    }

    public String getUsername() {
        return username;
    }

    public String getPassword() {
        return password;
    }

    public String getName() {
        return firstName + " " + lastName;
    }

    public String getFirstName() {
        return firstName;
    }

    public String getLastName() {
        return lastName;
    }

    public String getPreferredTravelMode() {
        return preferredTravelMode;
    }

    public void setPreferredTravelMode(String travelMode) {
        preferredTravelMode = travelMode;
    }
}
