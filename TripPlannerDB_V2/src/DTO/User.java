package DTO;
import DTO.Enums.UserRole;
import java.util.List;

public class User extends DTO {
    private Integer ID;
    private String firstName;
    private String lastName;
    private String userName;
    private String password;
    private String email;
    private UserRole userRole;
    private Preference defaultPreference;
    private List<Trip> trips;

    //Getters
    public Integer getID(){
        return this.ID;
    }
    public String getFirstName(){
        return this.firstName;
    }
    public String getLastName(){
        return this.lastName;
    }
    public String getUserName(){
        return this.userName;
    }
    public String getPassword(){
        return this.password;
    }
    public String getEmail(){
        return this.email;
    }
    public UserRole getUserRole(){
        return this.userRole;
    }
    public int getUserRoleValue(){
        return this.userRole.ordinal();
    }
    public Preference getPreference(){
        return this.defaultPreference;
    }
    public List<Trip> getTrips(){
        return this.trips;
    }

    //Setters
    public void setID(Integer ID){
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
    public void setUserRole(String stringValue) {
        this.userRole = UserRole.valueOf(stringValue);
    }
    public void setPreference(Preference preference){
        this.defaultPreference = preference;
    }
    public void setTrips(List<Trip> trips){
        this.trips = trips;
    }
}
