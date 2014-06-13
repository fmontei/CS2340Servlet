package model;

import javax.servlet.http.HttpServletRequest;

public class LoginForm {
    private HttpServletRequest request;
    private String username;
    private String password;

    public boolean isAuthenticationSuccessful(HttpServletRequest request) {
        this.request = request;
        password = request.getParameter("password");
        username = request.getParameter("username");
        if (!isLoginButtonClicked()) {
            return false;
        }
        try {
            checkIfParametersNotNull();
            Validation validation = new LoginValidation(username, password);
            validation.validateCredentials();
            storeLoginAttributes();
            return true;
        } catch (ValidationException ex) {
            request.setAttribute("error", ex.getMessage());
            return false;
        }
    }

    private boolean isLoginButtonClicked() {
        return request.getParameter("loginButton") != null;
    }

    private void checkIfParametersNotNull() throws ValidationException {
        if (isPasswordNull()) {
            throw new ValidationException("Invalid password."
                + "Please try again.");
        } else if (isUsernameNull()) {
            throw new ValidationException("Invalid username."
                + "Please try again.");
        }
    }

    private void storeLoginAttributes() {
        DataStore dataStore = new DataStore();
        UserAccount currentAccount = dataStore.findByUserName(username);
        String welcomeName = currentAccount.getName();
        String firstName = currentAccount.getFirstName();
        String lastName = currentAccount.getLastName();
        Attributes.storeAttribute(Attributes.WELCOME_NAME, welcomeName);
        Attributes.storeAttribute(Attributes.CURRENT_USER, username);
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
