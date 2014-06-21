package database.DTO;
import database.DTO.Enums.AttractionType;

public class Attraction extends Place {
    private Integer ID;
    private AttractionType attractionType;
    private Double cost;

    //Getters
    public Integer getID(){
        return this.ID;
    }
    public AttractionType getAttractionType(){
        return this.attractionType;
    }
    public Double getCost(){
        return this.cost;
    }

    //Setters
    public void setID(Integer ID){
        this.ID = ID;
    }
    public void setAttractionType(String stringValue){
        this.attractionType = AttractionType.valueOf(stringValue);
    }
    public void setCost(Double cost){
        this.cost = cost;
    }
}
