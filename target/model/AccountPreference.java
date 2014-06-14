package model;

import javax.servlet.http.HttpServletRequest;

public class AccountPreference {
    private HttpServletRequest request;
    private UserAccount currentAccount;
    private String username;
    private String preferredTravelMode;
    private DataStore accountsSave = new DataStore();
    public AccountPreference(HttpServletRequest request) {
        this.request = request;
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
        username = Attributes.getAttribute(Attributes.CURRENT_USER);
        UserAccount account = DataStore.findByUserName(username);
        preferredTravelMode = request.getParameter("preferredTravelMode");
        account.setPreferredTravelMode(preferredTravelMode);
        DataStore dataStore = new DataStore();
        dataStore.saveAccount(username,account);
    }
}
