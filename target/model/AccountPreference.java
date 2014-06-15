package model;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

public class AccountPreference {
    private HttpServletRequest request;
    private HttpSession session;
    private UserAccount account;
    private String username;
    private String preferredTravelMode;
    private DataStore accountsSave = new DataStore();

    public AccountPreference(HttpServletRequest request) {
        this.request = request;
        session = request.getSession();
    }

    public boolean isPreferredTravelModeSaved() {
        try {
            savePreferredTravelMode();
            return true;
        } catch (Exception e) {
            return false;
        }
    }

    private void savePreferredTravelMode() {
        account = (UserAccount) session.getAttribute("currentUser");
        preferredTravelMode = request.getParameter("preferredTravelMode");
        account.setPreferredTravelMode(preferredTravelMode);
        username = account.getUsername();
        accountsSave.saveAccount(username,account);
    }
}
