package database;

import java.awt.*;
import java.awt.geom.Point2D;
import java.text.SimpleDateFormat;
import java.util.Date;

public class Itinerary {
    private int ID;
    private int userID;
    private int preferenceID;
    private String name;
    private String address, transportationMode, creationDate;
    private Point2D coordinates;

    public Itinerary() {
        this.userID = this.preferenceID = this.ID = 0;
        this.name = this.address = this.transportationMode = this.address = "";
        this.coordinates = new Point();
    }

    public Itinerary(String name, String address, Point2D coordinates,
                     String transportationMode, int userID,
                     int preferenceID) {
        this.userID = userID;
        this.name = name;
        this.address = address;
        this.coordinates = coordinates;
        this.transportationMode = transportationMode;
        this.creationDate = generateFormattedCreationDate();
        this.preferenceID = preferenceID;
    }

    public Itinerary(String name, String address, Point2D coordinates,
                     String transportationMode, String creationDate, int ID,
                     int userID, int preferenceID) {
        this.ID = ID;
        this.userID = userID;
        this.preferenceID = preferenceID;
        this.name = name;
        this.address = address;
        this.coordinates = coordinates;
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
    public Point2D getCoordinates() {
        return coordinates;
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

