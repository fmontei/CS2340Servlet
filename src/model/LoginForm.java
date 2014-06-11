package model;

import javax.servlet.http.HttpServletRequest;

public class LoginForm {
    private HttpServletRequest request;
    private String username;
    private String password;

    public LoginForm() {
    }

    public boolean isAuthenticationSuccessful(HttpServletRequest request) {
        this.request = request;
        password = request.getParameter("password");
        username = request.getParameter("username");
        if (isLoginButtonClicked() == false)
            return false;
        try {
            checkIfParametersNotNull();
            AccountValidation.validateLoginCredentials(username, password);
            storeLoginAttributes();
            return true;
        } catch(Exception ex) {
            request.setAttribute("error", ex.getMessage());
            return false;
        }
    }

    private boolean isLoginButtonClicked() {
        return request.getParameter("loginButton") != null;
    }

    private void checkIfParametersNotNull() throws Exception {
        if (isPasswordNull()) {
            throw new Exception("Invalid password. Please try again.");
        }
        else if (isUsernameNull()) {
            throw new Exception("Invalid username. Please try again.");
        }
    }

    private void storeLoginAttributes() {
        UserAccount currentAccount = AccountForm.getUserAccounts().get(username);
        String welcomeName = currentAccount.getName();
        String firstName = currentAccount.getFirstName();
        String lastName = currentAccount.getLastName();
        Attributes.storeAttribute(Attributes.CURRENT_USER, welcomeName);
        Attributes.storeAttribute("firstName", firstName);
        Attributes.storeAttribute("lastName", lastName);
        Attributes.storeAttribute("username", username);
    }

    private boolean isPasswordNull() {
        return password == null || password.isEmpty();
    }

    private boolean isUsernameNull() {
        return username == null || username.isEmpty();
    }
}
