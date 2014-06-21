package database.DTO;
import database.DTO.Enums.TransportationMode;
import java.util.Date;

public class Trip extends DTO {
    private Integer ID;
    private Lodging lodging;
    private TransportationMode transportationMode;
    private Itinerary itinerary;
    private Date startDateTime;
    private Date endDateTime;

    //Getters
    public Integer getID(){
        return this.ID;
    }
    public Lodging getLodging(){
        return this.lodging;
    }
    public TransportationMode getTransportationMode(){
        return this.transportationMode;
    }
    public Itinerary getItinerary(){
        return this.itinerary;
    }
    public Date getStartDateTime(){
        return this.startDateTime;
    }
    public Date getEndDateTime(){
        return this.endDateTime;
    }

    //Setters
    public void setID(int ID){
        this.ID = ID;
    }
    public void setLodging(Lodging lodging){
        this.lodging = lodging;
    }
    public void setTransportationMode(String stringValue){
        this.transportationMode = TransportationMode.valueOf(stringValue);
    }
    public void setItinerary(Itinerary itinerary){
        this.itinerary = itinerary;
    }
    public void setStartDateTime(Date startDateTime){
        this.startDateTime = startDateTime;
    }
    public void setEndDateTime(Date endDateTime){
        this.endDateTime = endDateTime;
    }
}
