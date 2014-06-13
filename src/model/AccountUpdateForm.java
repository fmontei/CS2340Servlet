package model;

import javax.servlet.http.HttpServletRequest;

public class AccountUpdateForm {
    private HttpServletRequest request;
    private UserAccount currentAccount;
    private String username;
    private String password;
    private String confirmPassword;
    private String firstName, lastName;
    private UserAccountsSerializable accountsSave = new UserAccountsSerializable();
    public AccountUpdateForm(HttpServletRequest request) {
        this.request = request;
    }

    public boolean isAccountCreationSuccessful() {
        try {
            gatherNewAccountInfo();
            validateCredentials();
            storeLoginAttributes();
            return true;
        } catch (ValidationException ex) {
            request.setAttribute("error", ex.getMessage());
            return false;
        }
    }

    private void gatherNewAccountInfo() throws ValidationException {
        username = Attributes.getAttribute(Attributes.CURRENT_USER);
        firstName = request.getParameter("updateFirstName");
        lastName = request.getParameter("updateLastName");
        password = request.getParameter("oldPassword");
        confirmPassword = request.getParameter("confirmOldPassword");
    }

    public void validateCredentials() throws ValidationException {
       if (password == "" && confirmPassword == "") {
           UserAccount accountBeforeChange = AccountForm.getUserAccounts().get(username);
           password = accountBeforeChange.getPassword();
           return;
       }

       if (!password.equals(confirmPassword)) {
            throw new ValidationException("Passwords do not match. "
                + "Please try again.");
        }
    }

    private void storeLoginAttributes() {
        currentAccount = new UserAccount(firstName, lastName, username, password);
        String username = currentAccount.getUsername();
        String welcomeName = currentAccount.getName();
        String firstName = currentAccount.getFirstName();
        String lastName = currentAccount.getLastName();
        Attributes.storeAttribute(Attributes.WELCOME_NAME, welcomeName);
        Attributes.storeAttribute("firstName", firstName);
        Attributes.storeAttribute("lastName", lastName);
        Attributes.storeAttribute("username", username);
        AccountForm.changeAccountSettings(currentAccount);
    }
}
