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
        if (isLoginParametersNotNull()) {
            if (AccountForm.isLoginSuccessful(username, password)) {
                createWelcomeName();
                return true;
            } else {
                generateAuthenticationError();
                return false;
            }
        } else {
            generateNullError();
            return false;
        }
    }

    private boolean isLoginButtonClicked() {
        return request.getParameter("loginButton") != null;
    }

    private boolean isLoginParametersNotNull() {
        return isPasswordNotNull() && isUsernameNotNull();
    }

    private void createWelcomeName() {
        UserAccount currentAccount = AccountForm.getUserAccounts().get(username);
        String welcomeName = currentAccount.getName();
        Attributes.storeAttribute(Attributes.CURRENT_USER, welcomeName);
    }

    private void generateNullError() {
        if (isUsernameNotNull() == false) {
            request.setAttribute("error", "Unknown user. Please try again.");
        } else if (isPasswordNotNull() == false) {
            request.setAttribute("error", "Password is incorrect. Please try again.");
        }
    }

    private void generateAuthenticationError() {
        if (isUsernameNotNull() && isPasswordNotNull()) {
            request.setAttribute("error", "Authentication failed. Please try again.");
        }
    }

    private boolean isPasswordNotNull() {
        return password != null && !password.isEmpty();
    }

    private boolean isUsernameNotNull() {
        return username != null && !username.isEmpty();
    }
}
