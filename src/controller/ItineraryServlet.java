package controller;

import database.DataManager;
import database.Place;
import model.*;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;

@WebServlet(name = "ItineraryServlet", urlPatterns = { "/itinerary" })
public class ItineraryServlet extends HttpServlet {
    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {
        if (request.getQueryString().contains("create_event=")) {
            EventForm eventForm = new EventForm(request, response);
            eventForm.createNewEvents();
        } else if (lodgingSearchRequested(request)) {
            doLodgingSearchRequest(request, response);
        } else if (lodgingSelectionMade(request)) {
            new LodgingForm(request, response).saveLodgingSelection();
        } else {
            response.sendRedirect("jsp/itinerary_overview.jsp");
        }
    }

    @Override
    public void doPost(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {
        if (newItineraryCreationRequested(request)) {
            new CreateItineraryForm(request);
            response.sendRedirect("jsp/itinerary_overview.jsp");
        } else if (itineraryDeleteRequested(request)) {
            doDeleteRequest(request);
            response.sendRedirect("jsp/itinerary_overview.jsp");
        } else if (userRequestedEventSearch(request)) {
            EventForm eventForm = new EventForm(request, response);
            eventForm.getEventsAroundCentralLocation();
        } else if (userSelectedEvent(request)) {
            EventForm eventForm = new EventForm(request, response);
            eventForm.saveSelection();
        } else if (textSearchRequest(request)) {
            doSearchRequest(request, response);
        }
    }

    private boolean lodgingSearchRequested(HttpServletRequest request) {
        return request.getQueryString().contains("add_lodging=true");
    }

    private void doLodgingSearchRequest(HttpServletRequest request,
                                        HttpServletResponse response)
        throws IOException {
        new LodgingForm(request, response).getLodgingsAroundLocation();
        response.sendRedirect("jsp/index.jsp");
    }

    private boolean lodgingSelectionMade(HttpServletRequest request) {
        return request.getQueryString().contains("lodging_id=");
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

    private boolean userRequestedEventSearch(HttpServletRequest request) {
        return request.getParameter("getEventsWithGoogleButton") != null ||
                request.getParameter("getEventsWithYelpButton") != null;
    }

    private boolean userSelectedEvent(HttpServletRequest request) {
        return request.getParameter("selectBusinessButton") != null;
    }

    private boolean textSearchRequest(HttpServletRequest request) {
        return request.getParameter("google-textsearch-submit") != null;
    }

    private void doSearchRequest(HttpServletRequest request,
                                 HttpServletResponse response)
            throws IOException {
        final String query = request.getParameter("google-textsearch-query");
        try {
            GooglePlaceAPI googleSearch = new GooglePlaceAPI();
            final ArrayList<Place> results = googleSearch.textSearch(query);
            final HttpSession session = request.getSession();
            session.setAttribute("textSearchResults", results);
        } catch (Exception ex) {
            BrowserErrorHandling.printErrorToBrowser(request, response, ex);
        }
        response.sendRedirect("jsp/index.jsp");
    }
}