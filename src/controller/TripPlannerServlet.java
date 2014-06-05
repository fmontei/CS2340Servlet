package controller;

import model.AccountForm;
import model.LoginForm;
import model.UserAccount;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

public class TripPlannerServlet extends HttpServlet {
    private static final String REDIRECT_TO_LOGIN = "html/login.jsp";
    private LoginForm loginForm = new LoginForm();

    public void init() {
    }

    public void doGet(HttpServletRequest request, HttpServletResponse response)
        throws IOException, ServletException {
        response.sendRedirect("html/login.jsp");
    }

    public void doPost(HttpServletRequest request, HttpServletResponse response)
        throws IOException, ServletException {
        if (loginForm.authenticateLogin(request) == true && request.getParameter("loginButton") != null) {
            RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/html/app.jsp");
            dispatcher.forward(request, response);
        }

        else if (request.getParameter("createAccountButton") != null) {
            response.sendRedirect("html/new_account.jsp");
        }

        else if (request.getParameter("submitButton") != null) {
            UserAccount newAccount = gatherNewAccountInfo(request, response);
            AccountForm accountForm = new AccountForm();
            if (accountForm.verifyCredentials(newAccount)) {
                accountForm.createNewUserAccount(newAccount);
                response.sendRedirect(REDIRECT_TO_LOGIN);
            } else {
                response.sendRedirect("html/new_account.jsp");
            }
        }

        else {
            RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/html/login.jsp");
            dispatcher.forward(request, response);
        }
    }

    private UserAccount gatherNewAccountInfo(HttpServletRequest request, HttpServletResponse response) {
        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String username = request.getParameter("newUsername");
        String password = request.getParameter("newPassword");
        UserAccount newAccount = new UserAccount(firstName, lastName, username, password);
        return newAccount;
    }

    private void createNewUserAccount(HttpServletRequest request, HttpServletResponse response) {}
}
