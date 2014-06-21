package model;

import database.DAL.DataManager;
import database.DTO.User;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.sql.SQLException;

public class AccountPreference {
    private HttpServletRequest request;
    private HttpSession session;

    public AccountPreference(HttpServletRequest request) {
        this.request = request;
        this.session = request.getSession();
    }

    public boolean isPreferredTravelModeSaved() {
        try {
            savePreferredTravelMode();
            return true;
        } catch (Exception e) {
            return false;
        }
    }

    private void savePreferredTravelMode() throws SQLException {
        String username = session.getAttribute("username").toString();
        User account = (User) session.getAttribute("currentUser");
        String preferredTravelMode = request.getParameter("preferredTravelMode");
        //account.setPreferredTravelMode(preferredTravelMode);
        //DataManager.createUser(account);
    }
}
