package model;

import static model.AccountForm.getUserAccounts;

public class AccountValidation {

    public static boolean validateAccountCredentials(UserAccount newAccount) throws AccountFormException {
        if (newAccount.allFieldsHaveValue()) {
            if (usernameExists(newAccount.getUsername())) {
                throw new AccountFormException("Username already taken. " +
                        "Please try again.");
            } else {
                return true;
            }
        } else {
            throw new AccountFormException("All fields must be populated. " +
                    "Please try again.");
        }
    }

    protected static boolean isLoginSuccessful(String username, String password) {
        return usernameExists(username) && passwordMatches(username, password);
    }

    protected static boolean usernameExists(String username) {
        return getUserAccounts().containsKey(username);
    }

    protected static boolean passwordMatches(String username, String password) {
        UserAccount currentAccount = getUserAccounts().get(username);
        String realPassword = currentAccount.getPassword();
        return realPassword.equals(password);
    }
}
