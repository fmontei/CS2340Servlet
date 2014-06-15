package model;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

public class AccountPreference {
    private HttpServletRequest request;
    private HttpSession session;
<<<<<<< HEAD
    private UserAccount account;
    private String username;
    private String preferredTravelMode;
    private DataStore accountsSave = new DataStore();
=======
>>>>>>> upstream/master

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

    private void savePreferredTravelMode() {
<<<<<<< HEAD
        account = (UserAccount) session.getAttribute("currentUser");
        preferredTravelMode = request.getParameter("preferredTravelMode");
        account.setPreferredTravelMode(preferredTravelMode);
        username = account.getUsername();
        accountsSave.saveAccount(username,account);
=======
        String username = session.getAttribute("username").toString();
        UserAccount account = (UserAccount) session.getAttribute("currentUser");
        String preferredTravelMode = request.getParameter("preferredTravelMode");
        account.setPreferredTravelMode(preferredTravelMode);
        DataStore dataStore = new DataStore();
        dataStore.saveAccount(username, account);
>>>>>>> upstream/master
    }
}
