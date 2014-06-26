package controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.PrintWriter;
import java.io.StringWriter;
import java.sql.SQLException;

public class BrowserErrorHandling {
    public static final void printErrorToBrowser(HttpServletRequest request,
                                     HttpServletResponse response,
                                     SQLException ex) {
        try {
            StringWriter sw = new StringWriter();
            ex.printStackTrace(new PrintWriter(sw));
            request.setAttribute("STACK_TRACE", sw.toString());
            request.getRequestDispatcher("jsp/errorStackTrace.jsp")
                    .forward(request, response);
        } catch (Exception ignore) {}
    }
}
