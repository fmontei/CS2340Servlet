package controller;

import database.DataManager;
import model.CreateItineraryForm;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;

@WebServlet(name = "ItineraryServlet", urlPatterns = { "/itinerary" })
public class ItineraryServlet extends HttpServlet {
    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {
        response.sendRedirect("jsp/itinerary_overview.jsp");
    }

    @Override
    public void doPost(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {
        if (newItineraryCreationRequested(request)) {
            new CreateItineraryForm(request);
            doGet(request, response);
        } else if (itineraryDeleteRequested(request)) {
            doDeleteRequest(request);
            doGet(request, response);
        }
    }

    private boolean newItineraryCreationRequested(HttpServletRequest request) {
        return request.getParameter("submitButton") != null;
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
}
