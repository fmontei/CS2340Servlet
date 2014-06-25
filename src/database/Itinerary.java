package database;

import java.text.SimpleDateFormat;
import java.util.Date;

public class Itinerary {
    private int ID;
    private int userID;
    private int preferenceID;
    private String name;
    private String address;
    private String transportationMode;
    private String creationDate;

    public Itinerary(String name, String address,
                     String transportationMode, int userID,
                     int preferenceID) {
        this.userID = userID;
        this.name = name;
        this.address = address;
        this.transportationMode = transportationMode;
        this.creationDate = generateFormattedCreationDate();
        this.preferenceID = preferenceID;
    }

    public Itinerary(String name, String address,  String transportationMode,
                     String creationDate, int ID, int userID) {
        this.ID = ID;
        this.userID = userID;
        this.name = name;
        this.address = address;
        this.transportationMode = transportationMode;
        this.creationDate = creationDate;
    }

    private String generateFormattedCreationDate() {
        SimpleDateFormat dateFormatter = new SimpleDateFormat("yyyy-MM-dd");
        String todayDate = dateFormatter.format(new Date());
        return todayDate;
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
    public String getCreationDate() {
        return creationDate;
    }
    public int getID() {
        return ID;
    }
    public int getUserID() {
        return userID;
    }
    public int getPreferenceID() { return preferenceID; }
}

