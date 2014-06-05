package controller;

import model.LoginForm;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "LoginServlet", urlPatterns = {"/login"})
public class LoginServlet extends HttpServlet {
    private static final String REDIRECT_TO_LOGIN = "jsp/login.jsp";
    private static final String REDIRECT_TO_NEW_ACCOUNT = "jsp/new_account.jsp";
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
        if (loginForm.isAuthenticationSuccessful(request)) {
            forwardRequest(request, response, "/menu");
        } else if (isCreateAccountButtonClicked(request)) {
            response.sendRedirect("createAccount");
        } else {
            reloadBecauseAuthenticateFailed(request, response);
        }
    }

    private boolean isCreateAccountButtonClicked(HttpServletRequest request) {
        return request.getParameter("createAccountButton") != null;
    }

    private void reloadBecauseAuthenticateFailed(HttpServletRequest request, HttpServletResponse response)
        throws IOException, ServletException {
        forwardRequest(request, response, "/jsp/login.jsp");
    }

    private void forwardRequest(HttpServletRequest request, HttpServletResponse response, String target)
        throws IOException, ServletException {
        RequestDispatcher dispatcher = getServletContext().getRequestDispatcher(target);
        dispatcher.forward(request, response);
    }
}
