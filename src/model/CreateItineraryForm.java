package model;

import database.DataManager;
import database.Itinerary;
import database.User;
import database.Preference;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.sql.SQLException;

public class CreateItineraryForm {
    private HttpServletRequest request;
    private HttpSession session;

    public CreateItineraryForm(HttpServletRequest request) {
        this.request = request;
        this.session = request.getSession();
        gatherNewItineraryInfo();
    }

    private void gatherNewItineraryInfo() {
        String name = request.getParameter("itineraryName");
        String address = request.getParameter("itineraryAddress");
        String transportation = request.getParameter("itineraryTransportation");
        //preference info
        float minRating = Float.parseFloat(request.getParameter("minRating").trim());
        String priceCategory = request.getParameter("priceCategory");
        int maxDistance = Integer.parseInt(request.getParameter("maxDistance").trim());
        String foodType = request.getParameter("preferredFoodType");
        String attrType = request.getParameter("preferredAttrType");
        Preference preference = new Preference(minRating, priceCategory, maxDistance,
                foodType, attrType);
        int preferenceID = savePreference(preference);
        User user = (User) session.getAttribute("currentUser");
        int userID = user.getID();
        Itinerary newItinerary = new Itinerary(name, address, transportation, userID, preferenceID);
        saveItinerary(newItinerary);
    }

    private int savePreference(Preference preference){
        int preferenceID = 0;
        try{
            preferenceID = DataManager.createPreference(preference);
        } catch (SQLException ex) {
            request.setAttribute("error", ex.getMessage());
        }
        return preferenceID;
    }

    private void saveItinerary(Itinerary itinerary) {
        try {
            DataManager.createItinerary(itinerary);
        } catch (SQLException ex) {
            request.setAttribute("error", ex.getMessage());
        }
    }
}