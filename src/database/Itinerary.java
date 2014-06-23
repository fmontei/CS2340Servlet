package database;

public class Itinerary {
    private int ID;
    private int userID;
    private String name;
    private String address;
    private String transportationMode;

    public Itinerary(String name, String address,
                     String transportationMode, int userID) {
        this.userID = userID;
        this.name = name;
        this.address = address;
        this.transportationMode = transportationMode;
    }

    public Itinerary(String name, String address,
                     String transportationMode, int ID, int userID) {
        this.ID = ID;
        this.userID = userID;
        this.name = name;
        this.address = address;
        this.transportationMode = transportationMode;
    }

    public String getName() {
        return name;
    }

    public String getAddress() {
        return address;
    }

    public String getTransportationMode() {
        return transportationMode;
    }

    public int getUserID() {
        return userID;
    }
}
