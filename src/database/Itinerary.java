package database;

import java.text.SimpleDateFormat;
import java.util.Date;

public class Itinerary {
    private int ID;
    private int userID;
    private String name;
    private String address;
    private String transportationMode;
    private String creationDate;
    private SimpleDateFormat dateFormatter = new SimpleDateFormat("yyyy-MM-dd");

    public Itinerary(String name, String address,
                     String transportationMode, int userID) {
        this.userID = userID;
        this.name = name;
        this.address = address;
        this.transportationMode = transportationMode;
        this.creationDate = generateFormattedCreationDate();
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
    public int getUserID() {
        return userID;
    }
    public String getCreationDate() {
        return creationDate;
    }
}
