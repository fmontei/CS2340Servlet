package controller; 

import database.Itinerary;
import database.SQLItineraryQuery;
import model.AccountPreference;
import model.CreateItineraryForm;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;

import static model.ServletUtilities.forwardRequest;

@WebServlet(name = "IndexServlet", urlPatterns = { "/index" })
public class IndexServlet extends HttpServlet {

    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse response)
        throws IOException, ServletException {
        if (request.getQueryString().contains("itinerary_id=")) {
            loadActiveItineraryOnIndexPage(request);
            response.sendRedirect("jsp/index.jsp");
        } else
            response.sendRedirect("jsp/createLoginSession.jsp");
    }

    @Override
    public void doPost(HttpServletRequest request, HttpServletResponse response)
        throws IOException, ServletException {
        if (isTravelModeButtonClicked(request)) {
            AccountPreference accountPreference = new AccountPreference(request);
            if (accountPreference.isPreferredTravelModeSaved()) {
                goToPreviousScreen(response);
            }
        }
    }

    private boolean isTravelModeButtonClicked(HttpServletRequest request) {
        return request.getParameter("submitTravelMode") != null;
    }

    private void goToPreviousScreen(HttpServletResponse response)
            throws IOException {
        response.sendRedirect("jsp/index.jsp");
    }

    private void loadActiveItineraryOnIndexPage(HttpServletRequest request) {
        final HttpSession session = request.getSession();
        final String queryString = request.getQueryString();
        final int startIndex = queryString.indexOf("=") + 1;
        String itineraryId = queryString.substring(startIndex);
        try {
            SQLItineraryQuery query = new SQLItineraryQuery();
            Itinerary activeItinerary = query.getItineraryByID(itineraryId);
            session.setAttribute("activeItinerary", activeItinerary);
            session.setAttribute("ITINERARY_NAME", activeItinerary.getName());
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
    }
}
