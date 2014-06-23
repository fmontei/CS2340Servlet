package model;

import database.DataManager;
import database.Itinerary;
import database.User;

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
        User user = (User) session.getAttribute("currentUser");
        int userID = user.getID();
        Itinerary newItinerary = new Itinerary(name, address, transportation, userID);
        saveItinerary(newItinerary);
    }

    private void saveItinerary(Itinerary itinerary) {
        try {
            DataManager.createItinerary(itinerary);
        } catch (SQLException ex) {
            request.setAttribute("error", ex.getMessage());
        }
    }
}
