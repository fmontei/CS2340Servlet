package model;

import static model.Attributes.*;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.Map;

public class AccountForm {
    private static Map<String, UserAccount> userAccounts
        = new HashMap<String, UserAccount>();
    private HttpServletRequest request;
    private String firstName, lastName, username;
    private String password, confirmPassword;
    private static UserAccountsSerializable accountDataStore
            = new UserAccountsSerializable();

    public AccountForm(HttpServletRequest request) {
        userAccounts = accountDataStore.loadData();
        this.request = request;
    }

    public boolean isAccountCreationSuccessful() {
        try {
            UserAccount newAccount = gatherNewAccountInfo();
            Validation validation = new AccountValidation(newAccount,
                password, confirmPassword);
            validation.validateCredentials();
            changeAccountSettings(newAccount);
            clearTemporaryAttributes();
            return true;
        } catch (ValidationException ex) {
            saveAttributesForNextAttempt(firstName, lastName, username);
            request.setAttribute("error", ex.getMessage());
            return false;
        }
    }

    private UserAccount gatherNewAccountInfo() throws ValidationException {
        firstName = request.getParameter("firstName");
        lastName = request.getParameter("lastName");
        username = request.getParameter("newUsername");
        password = request.getParameter("newPassword");
        confirmPassword = request.getParameter("confirmPassword");
        UserAccount newAccount = new UserAccount(firstName, lastName,
            username, password);
        return newAccount;
    }

    private void saveAttributesForNextAttempt(String first,
        String last, String user) {
        storeAttribute("prevFirstName", first);
        storeAttribute("prevLastName", last);
        storeAttribute("prevUsername", user);
    }

    private void clearTemporaryAttributes() {
        removeAttribute("prevFirstName");
        removeAttribute("prevLastName");
        removeAttribute("prevUsername");
    }

    public static void changeAccountSettings(UserAccount updatedAccount) {
        String username = updatedAccount.getUsername();
        userAccounts.put(username, updatedAccount);
        accountDataStore.saveData(userAccounts);
    }

    public static Map<String, UserAccount> getUserAccounts() {
        accountDataStore = new UserAccountsSerializable();
        userAccounts = accountDataStore.loadData();
        return userAccounts;
    }

    public static UserAccount findByUserName(String username) {
        return userAccounts.get(username);
    }
}
