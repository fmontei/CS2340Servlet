package model;

public class UserAccount {
    private String firstName;
    private String lastName;
    private String username;
    private String password;

    public UserAccount(String first, String last, String username, String password) {
        this.firstName = first;
        this.lastName = last;
        this.username = username;
        this.password = password;
    }

    public boolean everythingHasValue() {
        return hasValue(firstName) && hasValue(lastName) && hasValue(username) && hasValue(password);
    }

    private boolean hasValue(String field) {
        return field != null && !field.isEmpty();
    }

    public String getUsername() { return username; }
    public String getPassword() { return password; }
    public String getName() { return firstName + " " + lastName; }
}
