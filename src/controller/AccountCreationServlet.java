package controller;

import static model.ServletUtilities.*;

import model.AccountCreateForm;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "AccountCreationServlet", urlPatterns = {"/createAccount"})
public class AccountCreationServlet extends HttpServlet {

    @Override
    public void doGet(HttpServletRequest request,
                      HttpServletResponse response)
        throws IOException, ServletException {
        response.sendRedirect("jsp/create_account.jsp");
    }

    @Override
    public void doPost(HttpServletRequest request,
                       HttpServletResponse response)
        throws IOException, ServletException {
        if (isSignUpButtonClicked(request)) {
            AccountCreateForm accountForm = new AccountCreateForm(request);
            if (accountForm.isAccountCreationSuccessful()) {
                automaticallyLogin(request, response);
            } else {
                reloadBecauseAccountCreateFailed(request, response);
            }
        }
    }

    private boolean isSignUpButtonClicked(HttpServletRequest request) {
        return request.getParameter("signUpButton") != null;
    }

    private void automaticallyLogin(HttpServletRequest request,
                                    HttpServletResponse response)
            throws IOException, ServletException {
        request.setAttribute("accountCreateSuccess", "success");
        forwardRequest(this, request, response, "/jsp/create_account.jsp");
    }

    private void reloadBecauseAccountCreateFailed(HttpServletRequest request,
                                                  HttpServletResponse response)
            throws IOException, ServletException {
        forwardRequest(this, request, response, "/jsp/create_account.jsp");
    }
}
