package database.DTO;
import database.DTO.Enums.AttractionType;

public class AttractionPreference extends DTO {
    private Integer ID;
    private AttractionType preferredAttractionType;

    //Getters
    public Integer getID(){
        return this.ID;
    }
    public AttractionType getPreferredAttractionType(){
        return this.preferredAttractionType;
    }

    //Setters
    public void setID(Integer ID){
        this.ID = ID;
    }
    public void setPreferredAttractionType(String stringValue){
        this.preferredAttractionType = AttractionType.valueOf(stringValue);
    }
}
