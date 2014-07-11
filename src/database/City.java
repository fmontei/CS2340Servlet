package database;

public class City {
    private String name, address;
    private int ID, itineraryID;
    private double latitude, longitude;

    public City(String name, String address, double latitude,
                double longitude, int itineraryID) {
        this.name = name;
        this.address = address;
        this.latitude = latitude;
        this.longitude = longitude;
        this.itineraryID = itineraryID;
    }

    public String getName() {
        return this.name;
    }

    public String getAddress() {
        return this.address;
    }

    public int getID() {
        return this.ID;
    }

    public int getItineraryID() {
        return this.itineraryID;
    }

    public double getLatitude() {
        return this.latitude;
    }

    public double getLongitude() {
        return this.longitude;
    }

    public void setName(String name) {
        this.name = name;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public void setID(int ID) {
        this.ID = ID;
    }

    public void setItineraryID(int itineraryID) {
        this.itineraryID = itineraryID;
    }

    public void setLatitude(double latitude) {
        this.latitude = latitude;
    }

    public void setLongitude(double longitude) {
        this.longitude = longitude;
    }
}
