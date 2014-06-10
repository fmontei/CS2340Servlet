package model;

public class AccountFormException extends Exception {
    public AccountFormException() { super(); }
    public AccountFormException(String message) { super(message); }
    public AccountFormException(String message, Throwable cause) { super(message, cause); }
    public AccountFormException(Throwable cause) { super(cause); }
}
