package database.DTO;

/**
 * Created by Joseph on 6/21/2014.
 */
public class DataScope {
    public User_DataScope user_dataScope;
    public Trip_DataScope trip_dataScope;
    public Preference_DataScope preference_dataScope;
    public Itinerary_DataScope itinerary_dataScope;
    public TimeSlot_DataScope timeSlot_dataScope;

    public class User_DataScope {
        public boolean loadTrips;
        public boolean loadPreference;
        public Trip_DataScope trip_dataScope;
        public Preference_DataScope preference_dataScope;
    }
    public class Trip_DataScope {
        public boolean loadItinerary;
        public boolean loadAvailableTimes;
        public boolean loadPreference;
        public boolean loadLodging;
        public Preference_DataScope preference_dataScope;
        public Itinerary_DataScope itinerary_dataScope;
    }
    public class Preference_DataScope {
        public boolean loadRestaurantPreferences;
        public boolean loadAttractionPreferences;
    }
    public class Itinerary_DataScope {
        public boolean loadTimeSlots;
        public TimeSlot_DataScope timeSlot_dataScope;
    }
    public class TimeSlot_DataScope {
        public boolean loadPlace;
    }
}
