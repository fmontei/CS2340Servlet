package database.DTO;

public class Lodging extends DTO {
    private Integer ID;
    private String name;
    private Address address;

    //Getters
    public Integer getID(){
        return this.ID;
    }
    public String getName(){
        return this.name;
    }
    public Address getAddress(){
        return this.address;
    }

    //Setters
    public void setID(Integer ID){
        this.ID = ID;
    }
    public void setName(String name){
        this.name = name;
    }
    public void setAddress(Address address){
        this.address = address;
    }
}
