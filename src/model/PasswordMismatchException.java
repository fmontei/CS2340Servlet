package model;

public class PasswordMismatchException extends Exception {
    public PasswordMismatchException() { super(); }
    public PasswordMismatchException(String message) { super(message); }
    public PasswordMismatchException(String message, Throwable cause) { super(message, cause); }
    public PasswordMismatchException(Throwable cause) { super(cause); }
}
