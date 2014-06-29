package database;

public class TextSearchPlace {
    private String name, placeID, formattedAddress;
    private int priceLevel;
    private double rating;
    private boolean openNow;

    public TextSearchPlace(String name, String placeID, String formattedAddress,
                           int priceLevel, double rating, boolean openNow) {
        this.name = name;
        this.placeID = placeID;
        this.formattedAddress = formattedAddress;
        this.priceLevel = priceLevel;
        this.rating = rating;
        this.openNow = openNow;
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
    public boolean isOpenNow() {
        return openNow;
    }
}
