package DTO;
import java.util.Date;

public class TimeSlot extends DTO {
    private Integer ID;
    private Date startTime;
    private Date endTime;
    private Place place;

    //Getters
    public Integer getID(){
        return this.ID;
    }
    public Date getStartTime(){
        return this.startTime;
    }
    public Date getEndTime(){
        return this.endTime;
    }
    public Place getPlace(){
        return this.place;
    }

    //Setters
    public void setID(int ID){
        this.ID = ID;
    }
    public void setStartTime(Date startTime){
        this.startTime = startTime;
    }
    public void setEndTime(Date endTime){
        this.endTime = endTime;
    }
    public void setPlace(Place place){
        this.place = place;
    }

}
