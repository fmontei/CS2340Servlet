package model;

import javax.servlet.http.HttpServletRequest;

import static model.Attributes.removeAttribute;
import static model.Attributes.storeAttribute;

public class AccountUpdateForm {
    private HttpServletRequest request;
    private UserAccount currentAccount;
    private String password;
    private String confirmPassword;
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
        final String username = Attributes.getAttribute(Attributes.CURRENT_USER);
        String firstName = request.getParameter("updateFirstName");
        String lastName = request.getParameter("updateLastName");
        password = request.getParameter("oldPassword");
        confirmPassword = request.getParameter("confirmOldPassword");
        currentAccount = new UserAccount(firstName, lastName, username, password);
    }

    public void validateCredentials() throws ValidationException {
       if (!password.equals(confirmPassword)) {
            throw new ValidationException("Passwords do not match. "
                    + "Please try again.");
        }
    }

    private void storeLoginAttributes() {
        String username = currentAccount.getUsername();
        String welcomeName = currentAccount.getName();
        String firstName = currentAccount.getFirstName();
        String lastName = currentAccount.getLastName();
        Attributes.storeAttribute(Attributes.WELCOME_NAME, welcomeName);
        Attributes.storeAttribute("firstName", firstName);
        Attributes.storeAttribute("lastName", lastName);
        Attributes.storeAttribute("username", username);
        AccountForm.getUserAccounts().put(currentAccount.getUsername(), currentAccount);
    }
}
