package model;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

public class AccountPreference {
    private HttpServletRequest request;
    private HttpSession session;
    private UserAccount currentAccount;
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
        username = session.getAttribute("username").toString();
        UserAccount account = DataStore.findByUserName(username);
        preferredTravelMode = request.getParameter("preferredTravelMode");
        account.setPreferredTravelMode(preferredTravelMode);
        DataStore dataStore = new DataStore();
        dataStore.saveAccount(username,account);
    }
}
