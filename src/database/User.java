package database;

public class User {
    private int ID;
    private String firstName;
    private String lastName;
    private String userName;
    private String password;
    private String email;

    public User() {

    }

    public User(String firstName, String lastName, String userName,
                String password) {
        this.firstName = firstName;
        this.lastName = lastName;
        this.userName = userName;
        this.password = password;
        this.email = "";
    }

    public User(int userID, String firstName, String lastName, String userName,
                String password) {
        this.ID = userID;
        this.firstName = firstName;
        this.lastName = lastName;
        this.userName = userName;
        this.password = password;
        this.email = "";
    }

    public int getID(){
        return this.ID;
    }
    public String getWelcomeName() {
        return this. firstName + " " + this.lastName;
    }
    public String getFirstName(){
        return this.firstName;
    }
    public String getLastName(){
        return this.lastName;
    }
    public String getUsername(){
        return this.userName;
    }
    public String getPassword(){
        return this.password;
    }
    public String getEmail() {
        return this.email;
    }

    public void setID(int ID) {
        this.ID = ID;
    }
    public void setFirstName(String firstName){
        this.firstName = firstName;
    }
    public void setLastName(String lastName){
        this.lastName = lastName;
    }
    public void setUserName(String userName){
        this.userName = userName;
    }
    public void setPassword(String password){
        this.password = password;
    }
    public void setEmail(String email){
        this.email = email;
    }
}
