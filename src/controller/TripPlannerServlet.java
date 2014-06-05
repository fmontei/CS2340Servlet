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
        redirectToLoginPage(response);
    }

    private void redirectToLoginPage(HttpServletResponse response)
        throws IOException {
        response.sendRedirect(REDIRECT_TO_LOGIN);
    }

    public void doPost(HttpServletRequest request, HttpServletResponse response)
        throws IOException, ServletException {
        if (loginForm.authenticateLogin(request) == true) {
            forwardRequest(request, response, "/html/app.jsp");
        }

        else if (request.getParameter("createAccountButton") != null) {
            response.sendRedirect("html/new_account.jsp");
        }

        else if (request.getParameter("submitButton") != null) {
            AccountForm accountForm = new AccountForm(request);
            if (accountForm.createNewAccount() == true) {
                response.sendRedirect(REDIRECT_TO_LOGIN);
            } else {
                response.sendRedirect("html/new_account.jsp");
            }
        }

        else {
            forwardRequest(request, response, "/html/login.jsp");
        }
    }

    private void forwardRequest(HttpServletRequest request, HttpServletResponse response, String target)
        throws IOException, ServletException
    {
        RequestDispatcher dispatcher = getServletContext().getRequestDispatcher(target);
        dispatcher.forward(request, response);
    }
}
