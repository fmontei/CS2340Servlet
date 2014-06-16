package model;

import static model.DataStore.findByUserName;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.xml.crypto.Data;

public class LoginForm {
    private HttpServletRequest request;
    private String username;
    private String password;

    public boolean isAuthenticationSuccessful(HttpServletRequest request) {
        this.request = request;
        username = request.getParameter("username");
        password = request.getParameter("password");
        if (!isLoginButtonClicked()) {
            return false;
        }
        try {
            checkIfParametersNotNull();
            AccountValidation validation = new AccountValidation
                    (username, password);
            validation.setOperation(new LoginAccountOperation());
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
        UserAccount currentAccount = findByUserName(username);
        String welcomeName = currentAccount.getName();
        String firstName = currentAccount.getFirstName();
        String lastName = currentAccount.getLastName();
        HttpSession session = request.getSession();
        session.setAttribute("welcomeName", welcomeName);
        session.setAttribute("currentUser", currentAccount);
        session.setAttribute("firstName", firstName);
        session.setAttribute("lastName", lastName);
        session.setAttribute("username", username);
    }

    private boolean isPasswordNull() {
        return password == null || password.isEmpty();
    }

    private boolean isUsernameNull() {
        return username == null || username.isEmpty();
    }
}
