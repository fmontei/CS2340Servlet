package controller; 

import model.AccountPreference;
import model.CreateItineraryForm;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

import static model.ServletUtilities.forwardRequest;

@WebServlet(name = "IndexServlet", urlPatterns = { "/index", "itineraryCreation" })
public class IndexServlet extends HttpServlet {

    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse response)
        throws IOException, ServletException {
        response.sendRedirect("jsp/createLoginSession.jsp");
    }

    @Override
    public void doPost(HttpServletRequest request, HttpServletResponse response)
        throws IOException, ServletException {
        if (newItineraryCreationRequested(request)) {
            new CreateItineraryForm(request);
            response.sendRedirect("jsp/itinerary_overview.jsp");
        } else if (isTravelModeButtonClicked(request)) {
            AccountPreference accountPreference = new AccountPreference(request);
            if (accountPreference.isPreferredTravelModeSaved()) {
                goToPreviousScreen(response);
            }
        }
    }

    private boolean newItineraryCreationRequested(HttpServletRequest request) {
        String uri = request.getRequestURI();
        return uri.endsWith("/itineraryCreation");
    }

    private boolean isTravelModeButtonClicked(HttpServletRequest request) {
        return request.getParameter("submitTravelMode") != null;
    }

    private void goToPreviousScreen(HttpServletResponse response)
            throws IOException {
        response.sendRedirect("jsp/index.jsp");
    }

    private void automaticallyLogin(HttpServletRequest request,
                                    HttpServletResponse response)
            throws IOException, ServletException {
        request.setAttribute("accountCreateSuccess", "success");
        forwardRequest(this, request, response, "/jsp/index.jsp");
    }

    private void reloadBecauseAccountCreateFailed(HttpServletRequest request,
                                                  HttpServletResponse response)
            throws IOException, ServletException {
        forwardRequest(this, request, response, "/jsp/index.jsp");
    }
}
