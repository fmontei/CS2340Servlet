package controller;

import database.DataManager;
import database.Event;
import model.CreateItineraryForm;
import model.EventForm;
import model.YelpAPI;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "ItineraryServlet", urlPatterns = { "/itinerary" })
public class ItineraryServlet extends HttpServlet {
    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {
        if (request.getQueryString().contains("create_event=")) {
            EventForm eventForm = new EventForm(request);
            eventForm.createNewEvents();
            response.sendRedirect("jsp/index.jsp");
        } else {
            response.sendRedirect("jsp/itinerary_overview.jsp");
        }
    }
// else if (request.getQueryString().contains("event_id=")) {
//         } 
    @Override
    public void doPost(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {
        if (newItineraryCreationRequested(request)) {
            new CreateItineraryForm(request);
            doGet(request, response);
        } else if (itineraryDeleteRequested(request)) {
            doDeleteRequest(request);
            doGet(request, response);
        } else if (updateEventRequested(request)) {
            EventForm eventForm = new EventForm(request);
            int eventID = eventForm.updateEvent();
            PrintWriter out = response.getWriter();
            out.println("<html>" + "EventID: " + eventID + "</html>");
            
            YelpAPI yelpAPI = new YelpAPI(request);
            yelpAPI.queryAPI();
            response.sendRedirect("jsp/index.jsp");
        }
    }

    private boolean newItineraryCreationRequested(HttpServletRequest request) {
        return request.getParameter("createItineraryButton") != null;
    }

    private boolean itineraryDeleteRequested(HttpServletRequest request) {
        return request.getParameter("deleteItinerary") != null;
    }

    private void doDeleteRequest(HttpServletRequest request) {
        String itineraryID = request.getParameter("deleteItinerary");
        try {
            DataManager.deleteItinerary(itineraryID);
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
    }

    private boolean updateEventRequested(HttpServletRequest request) {
        return request.getParameter("updateEventButton") != null;
    }
}
