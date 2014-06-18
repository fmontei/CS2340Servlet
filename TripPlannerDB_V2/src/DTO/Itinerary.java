package DTO;
import java.util.List;

public class Itinerary extends DTO {
    private Integer ID;
    private String name;
    private List<TimeSlot> timeSlots;

    //Getters
    public Integer getID(){
        return this.ID;
    }
    public String getName(){
        return this.name;
    }
    public List<TimeSlot> getTimeSlots(){
        return this.timeSlots;
    }

    //Setters
    public void setID(Integer ID){
        this.ID = ID;
    }
    public void setName(String name){
        this.name = name;
    }
    public void setTimeSlots(List<TimeSlot> timeSlots){
        this.timeSlots = timeSlots;
    }
}
