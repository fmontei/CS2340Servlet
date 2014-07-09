package model;

import controller.BrowserErrorHandling;
import database.DataManager;
import database.Itinerary;
import database.Place;
import database.SQLPlaceQuery;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;

public class LodgingForm {
    private HttpServletRequest request;
    private HttpServletResponse response;
    private HttpSession session;
    private Itinerary activeItinerary;

    public LodgingForm(HttpServletRequest request, HttpServletResponse response) {
        this.request = request;
        this.response = response;
        this.session = request.getSession();
        this.activeItinerary = (Itinerary) session.getAttribute("activeItinerary");
    }

    public void getLodgingsAroundLocation() {
        session = request.getSession();
        final String name = parseName();
        final String formattedCoords = activeItinerary.getCoordinates().format();
        final int radius = parseRadius();
        final int limit = parseLimit();
        List<Place> lodgings;
        try {
            YelpAPI yelpAPI = new YelpAPI();
            lodgings = yelpAPI.queryAPI(name, formattedCoords, radius, limit, 0);
            session.setAttribute("lodgingResults", lodgings);
            session.setAttribute("lastLodgingName", name);
            session.setAttribute("lastLodgingRadius", radius);
            session.setAttribute("lastLodgingLimit", limit);
        } catch (Exception ex) {
            try {
                PrintWriter out = response.getWriter();
                out.println("<html>ERROR: problem retrieving results.</html>");
            } catch (IOException ignore) {}
        }
    }

    public void getMoreLodgingResults() {
        final String name = session.getAttribute("lastLodgingName").toString();
        final String radius = session.getAttribute("lastLodgingRadius").toString();
        final String limit = session.getAttribute("lastLodgingLimit").toString();
        final int radiusInt = Integer.parseInt(radius);
        final int limitInt = Integer.parseInt(limit);
        final String formattedCoords = activeItinerary.getCoordinates().format();
        List<Place> currentResults;
        List<Place> previousResults = (List) session.getAttribute("lodgingResults");
        try {
            YelpAPI yelpAPI = new YelpAPI();
            currentResults = yelpAPI.queryAPI(name, formattedCoords,
                    radiusInt, limitInt, limitInt);
            List<Place> mergedResults = mergeResults(previousResults, currentResults);
            session.setAttribute("lodgingResults", mergedResults);
        } catch (Exception ex) {
            try {
                PrintWriter out = response.getWriter();
                out.println("<html>ERROR: problem retrieving results.</html>");
            } catch (IOException ignore) {}
        }
    }

    private List mergeResults(List<Place> previousResults, List<Place>currentResults) {
        currentResults.removeAll(previousResults);
        previousResults.addAll(currentResults);
        return previousResults;
    }

    private String parseName() {
        String lodgingName = request.getParameter("lodgingName");
        if (lodgingName == null || lodgingName.isEmpty()) {
            lodgingName = "lodging";
        }
        return lodgingName;
    }

    private int parseLimit() {
        final String limit = request.getParameter("lodgingFilter");
        final int limitInt = (limit != null && !limit.isEmpty())
                ? Integer.parseInt(limit) : 10;
        return limitInt;
    }

    private int parseRadius() {
        final String radius = request.getParameter("lodgingRadius");
        int radiusInt = (radius != null && !radius.isEmpty())
                ? Integer.parseInt(radius) : 15;
        return radiusInt;
    }

    public void saveLodgingSelection() throws IOException {
        final String lodgingURI = request.getQueryString();
        int begin = lodgingURI.indexOf("=") + 1;
        String lodgingIDAsString = lodgingURI.substring(begin);
        final int lodgingID = Integer.parseInt(lodgingIDAsString);
        List<Place> results =
                (List<Place>) session.getAttribute("lodgingResults");
        final Place selection = results.get(lodgingID);
        try {
            DataManager.createLodging(selection, activeItinerary.getID());
            session.setAttribute("lodgingSelection", selection);
            response.sendRedirect("jsp/index.jsp");
        } catch (SQLException ex) {
            BrowserErrorHandling.printErrorToBrowser(request, response, ex);
        }
    }

    public void setLodgingTime() throws IOException {
        final String checkIn = request.getParameter("lodgingCheckIn");
        final String checkOut = request.getParameter("lodgingCheckOut");
        final String reformattedCheckIn = reformatHTMLDateTime(checkIn);
        final String reformattedCheckOut = reformatHTMLDateTime(checkOut);
        final SQLPlaceQuery sqlQuery = new SQLPlaceQuery();
        final Integer itineraryID = activeItinerary.getID();
        try {
            Place lodging = sqlQuery.getLodgingByItineraryID(itineraryID.toString());
            lodging.setCheckIn(checkIn);
            lodging.setCheckOut(checkOut);
            sqlQuery.updateLodgingTimeByID(lodging.getID(), reformattedCheckIn,
                    reformattedCheckOut);
            updateLodgingSession(reformattedCheckIn, reformattedCheckOut);
            response.sendRedirect("jsp/index.jsp");
        } catch (SQLException ex) {
            BrowserErrorHandling.printErrorToBrowser(request, response, ex);
        }
    }

    private String reformatHTMLDateTime(final String unformatted) {
        String formattedDate = unformatted;
        try {
            SimpleDateFormat oldFormat = new SimpleDateFormat("yyyy-MM-dd'T'hh:mm");
            Date parsed = oldFormat.parse(unformatted);
            SimpleDateFormat newFormat = new SimpleDateFormat("MM/dd/YYY @ hh:mm a");
            formattedDate = newFormat.format(parsed);
        } catch (ParseException ignore) {
        } finally {
            return formattedDate;
        }
    }

    private void updateLodgingSession(final String checkIn, final String checkOut) {
        Place lodging = (Place) session.getAttribute("lodgingSelection");
        lodging.setCheckIn(checkIn);
        lodging.setCheckOut(checkOut);
        session.setAttribute("lodgingSelection", lodging);
    }
}
