package database.DTO;
import database.DTO.Enums.*;

public class Restaurant extends Place {
    private Integer ID;
    private RestaurantType RestaurantType;
    private PriceCategory PriceCategory;

    //Getters
    public Integer getID(){
        return this.ID;
    }
    public RestaurantType getRestaurantType(){
        return this.RestaurantType;
    }
    public int getRestaurantTypeValue(){
        return this.RestaurantType.ordinal();
    }
    public PriceCategory getPriceCategory(){
        return this.PriceCategory;
    }
    public int getPriceCategoryValue(){
        return this.PriceCategory.ordinal();
    }

    //Setters
    public void setID(int ID){
        this.ID = ID;
    }
    public void setRestaurantType(String stringValue){
        this.RestaurantType = RestaurantType.valueOf(stringValue);
    }
    public void setPriceCategory(String stringValue){
        this.PriceCategory = PriceCategory.valueOf(stringValue);
    }
}
