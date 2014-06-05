package model;

import javax.servlet.http.HttpServletRequest;

public class LoginForm {
    private static final String CURRENT_USER = "currentUser";
    private HttpServletRequest request;
    private String username;
    private String password;

    public LoginForm() {
    }

    public boolean authenticateLogin(HttpServletRequest request) {
        this.request = request;
        password = (String) request.getParameter("password");
        username = (String) request.getParameter("username");

        if (loginParametersNotNull()) {
            if (AccountForm.loginSuccessful(username, password)) {
                String welcomeName = AccountForm.getUserAccounts().get(username).getName();
                request.setAttribute(CURRENT_USER, welcomeName);
                return true;
            }
            else {
                generateAuthenticationError();
                return false;
            }
        }
        else {
            generateNullError();
            return false;
        }
    }

    private boolean loginParametersNotNull() {
        return passwordNotNull() && usernameNotNull();
    }

    private void generateNullError() {
        if (usernameNotNull() == false && passwordNotNull() == false) {
            resetErrorMessage();
        }
        else if (usernameNotNull() == false) {
            request.setAttribute("error", "Unknown user. Please try again.");
        }
        else if (passwordNotNull() == false) {
            request.setAttribute("error", "Password is incorrect. Please try again.");
        }
    }

    private void generateAuthenticationError() {
        if (usernameNotNull() && passwordNotNull()) {
            request.setAttribute("error", "Authentication failed. Please try again.");
        }
    }

    private boolean passwordNotNull() {
        return password != null && !password.isEmpty();
    }

    private boolean usernameNotNull() {
        return username != null && !username.isEmpty();
    }

    private void resetErrorMessage() {
        request.setAttribute("error", "");
    }
}
