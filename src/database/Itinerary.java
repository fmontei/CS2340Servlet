package database;

public class Itinerary {
    private int ID;
    private String name;
    private String address;
    private String transportationMode;

    public Itinerary(String name, String address, String transportationMode) {
        this.name = name;
        this.address = address;
        this.transportationMode = transportationMode;
    }

    public Itinerary(int ID, String name, String address, String transportationMode) {
        this.ID = ID;
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

    public int getID() {
        return ID;
    }
}
