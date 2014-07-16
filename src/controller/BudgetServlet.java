package controller;

import database.Itinerary;

import model.BudgetForm;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

/**
 * Created by Joseph on 7/15/2014.
 */
@WebServlet(name = "BudgetServlet", urlPatterns = { "/budget" })
public class BudgetServlet extends HttpServlet {

    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse response) {
        //pending
    }

    @Override
    public void doPost(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        if (createBudgetRequested(request)) {
            BudgetForm budgetForm = new BudgetForm(request);
            budgetForm.createBudget();
            returnToActiveItineraryIndex(request, response);
        } else if (addExpenditureRequested(request)) {
            BudgetForm budgetForm = new BudgetForm(request);
            budgetForm.createExpenditures();
            returnToActiveItineraryIndex(request, response);
        } else {
            //pending
        }
    }

    private boolean createBudgetRequested(HttpServletRequest request) {
        return request.getParameter("createBudgetButton") != null;
    }

    private boolean addExpenditureRequested(HttpServletRequest request) {
        return request.getParameter("saveExpenseBtn") != null;
    }

    private void returnToActiveItineraryIndex(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        HttpSession session = request.getSession();
        Itinerary itinerary = (Itinerary) session.getAttribute("activeItinerary");
        String itineraryID = Integer.toString(itinerary.getID());
        String redirectLink = "/CS2340Servlet/index?itinerary_id=" + itineraryID;
        response.sendRedirect(redirectLink);
    }
}