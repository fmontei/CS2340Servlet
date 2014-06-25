package database;

/**
 * Created by Joseph on 6/24/2014.
 */
public class Preference {
    private int ID;
    private float minimumRating;
    private String priceCategory;
    private int maxDistance;
    private String preferredFoodType;
    private String preferredAttractionType;

    public Preference(float minimumRating, String priceCategory,
                      int maxDistance, String preferredAttractionType,
                      String preferredFoodType){
        this.minimumRating = minimumRating;
        this.priceCategory = priceCategory;
        this.maxDistance = maxDistance;
        this.preferredAttractionType = preferredAttractionType;
        this.preferredFoodType = preferredFoodType;
    }

    //Getters
    public int getID(){ return this.ID; }
    public float getMinimumRating() { return this.minimumRating; }
    public String getPriceCategory() { return this.priceCategory; }
    public int getMaxDistance() { return this.maxDistance; }
    public String getPreferredFoodType() { return this.preferredFoodType; }
    public String getPreferredAttractionType() { return this.preferredAttractionType; }

    //Setters
    public void setID() { this.ID = ID; }
    public void setMinimumRating() { this.minimumRating = minimumRating; }
    public void setPriceCategory() { this.priceCategory = priceCategory; }
    public void setMaxDistance() { this.maxDistance = maxDistance; }
    public void setPreferredFoodType() { this.preferredFoodType = preferredFoodType; }
    public void setPreferredAttractionType() { this.preferredAttractionType = preferredAttractionType; }


}
