package DTO;
import DTO.Enums.RestaurantType;

public class RestaurantPreference extends DTO {
    private Integer ID;
    private RestaurantType preferredRestaurantType;

    //Getters
    public Integer getID(){
        return this.ID;
    }
    public RestaurantType getPreferredRestaurantType(){
        return this.preferredRestaurantType;
    }
    public int getPreferredRestaurantTypeValue(){
        return this.preferredRestaurantType.ordinal();
    }

    //Setters
    public void setID(int ID){
        this.ID = ID;
    }
    public void setPreferredRestaurantType(String stringValue){
        this.preferredRestaurantType = RestaurantType.valueOf(stringValue);
    }
}
