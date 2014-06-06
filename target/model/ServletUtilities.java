package model;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class ServletUtilities {
    public static final String LOGIN_RED = "jsp/login.jsp";
    public static final String LOGIN_FOR = "/login";
    public static final String MENU_RED = "jsp/menu.jsp";
    public static final String MENU_FOR = "/menu";
    public static final String NEW_ACCOUNT_RED = "jsp/new_account.jsp";
    public static final String NEW_ACCOUNT_FOR = "/new_account";

    public static void forwardRequest(HttpServlet servlet,
                                      HttpServletRequest request,
                                      HttpServletResponse response,
                                      String target)
            throws IOException, ServletException {
        RequestDispatcher dispatcher = servlet.getServletContext().getRequestDispatcher(target);
        dispatcher.forward(request, response);
    }
}
