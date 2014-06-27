package model;

public class Place {
    private String name, placeID, formattedAddress;
    int priceLevel;
    double rating;

    public Place(String name, String placeID, String formattedAddress,
                 int priceLevel, double rating) {
        this.name = name;
        this.placeID = placeID;
        this.formattedAddress = formattedAddress;
        this.priceLevel = priceLevel;
        this.rating = rating;
    }

    public String getName() {
        return name;
    }
    public String getPlaceID() {
        return placeID;
    }
    public String getFormattedAddress() {
        return formattedAddress;
    }
    public int getPriceLevel() {
        return priceLevel;
    }
    public double getRating() {
        return rating;
    }
}
