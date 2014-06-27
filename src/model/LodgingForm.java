package model;

import database.Itinerary;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

public class LodgingForm {
    private HttpServletRequest request;
    private HttpSession session;
    private String lodgingAddress;
    private Itinerary activeItinerary;

    public LodgingForm(HttpServletRequest request) {
        this.request = request;
    }

    public void getLodgingsAroundLocation() {
        session = request.getSession();
        activeItinerary = (Itinerary) session.getAttribute("activeItinerary");
        lodgingAddress = request.getParameter("lodgingAddress");
        if (noLodgingAddressSpecifiedByUser()) {
            useItineraryCentralLocation();
        }
    }

    private boolean noLodgingAddressSpecifiedByUser() {
        return lodgingAddress == null;
    }

    private void useItineraryCentralLocation() {
        lodgingAddress = activeItinerary.getAddress();
    }
}
