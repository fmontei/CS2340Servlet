package model;

import controller.BrowserErrorHandling;
import database.Itinerary;
import database.Lodging;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

public class LodgingForm {
    private HttpServletRequest request;
    private HttpServletResponse response;
    private HttpSession session;
    private Itinerary activeItinerary;

    public LodgingForm(HttpServletRequest request, HttpServletResponse response) {
        this.request = request;
        this.response = response;
        this.session = request.getSession();
    }

    public void getLodgingsAroundLocation() {
        session = request.getSession();
        activeItinerary = (Itinerary) session.getAttribute("activeItinerary");
        final String formattedCoords = reformatCoordsForQueryCompliance();
        List<Lodging> lodgings;
        final String lodging = "lodging";
        try {
            GooglePlaceService googleSearch = new GooglePlaceService();
            lodgings = googleSearch.placeSearch(formattedCoords, 50000, lodging);
            session.setAttribute("lodgingResults", lodgings);
        } catch (Exception ex) {
            try {
                PrintWriter out = response.getWriter();
                out.println("<html>ERROR: problem retrieving results.</html>");
            } catch (IOException ignore) {}
        }
    }

    private String reformatCoordsForQueryCompliance() {
        final String coords = activeItinerary.getCoordinates().toString();
        int begin = coords.indexOf("[") + 1;
        int end = coords.length() - 1;
        String formattedCoords = coords.substring(begin, end);
        formattedCoords = formattedCoords.replaceAll("\\s+", "");
        return formattedCoords;
    }

    public void saveLodgingSelection() throws IOException {
        final String lodgingURI = request.getQueryString();
        int begin = lodgingURI.indexOf("=") + 1;
        String lodgingIDAsString = lodgingURI.substring(begin);
        final int lodgingID = Integer.parseInt(lodgingIDAsString);
        List<Lodging> results =
                (List<Lodging>) session.getAttribute("lodgingResults");
        final Lodging selection = results.get(lodgingID);
        session.setAttribute("lodgingSelection", selection);
        response.sendRedirect("jsp/index.jsp");
    }
}
