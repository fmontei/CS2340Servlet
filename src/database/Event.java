package database;

import java.awt.*;

public class Event {
    private String name, placeID, formattedAddress, phoneNumber, Api;
    private Point coordinates = new Point();
    private int priceLevel;
    private double rating;
    private boolean openNow;

    public Event() {

    }

    public Event(String name, String placeID, String formattedAddress,
                   Point coordinates, int priceLevel, double rating,
                   boolean openNow) {
        this.name = name;
        this.placeID = placeID;
        this.formattedAddress = formattedAddress;
        this.coordinates = coordinates;
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
    public Point getCoordinates() {
        return coordinates;
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
    public String getApi() {
        return this.Api;
    }

    public void setName(String name) {
        this.name = name;
    }
    public void setPlaceID(String placeID) {
        this.placeID = placeID;
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
    public void setApi(String API) {
        this.Api = API;
    }
}
