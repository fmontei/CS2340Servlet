package database;

public class Place {
    private String name, placeID, formattedAddress, phoneNumber, URL;
    private int priceLevel;
    private double rating;
    private boolean openNow;

    public Place() {}

    public Place(String name, String placeID, String formattedAddress,
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
    public String getPhoneNumber() {
        return phoneNumber;
    }
    public String getURL() {
        return this.URL;
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

    public void setPlaceID(String placeID) {
        this.placeID = placeID;
    }
    public void setName(String name) {
        this.name = name;
    }
    public void setURL(String URL) {
        this.URL = URL;
    }
    public void setFormattedAddress(String formattedAddress) {
        this.formattedAddress = formattedAddress;
    }
    public void setPhoneNumber(String phoneNumber) {
        this.phoneNumber = phoneNumber;
    }
    public void setPriceLevel(int priceLevel) {
        this.priceLevel = priceLevel;
    }
    public void setRating(double rating) {
        this.rating = rating;
    }
    public void setOpenNow(boolean openNow) {
        this.openNow = openNow;
    }
}
