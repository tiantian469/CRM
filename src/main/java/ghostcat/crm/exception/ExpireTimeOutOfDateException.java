package ghostcat.crm.exception;

public class ExpireTimeOutOfDateException extends LoginException{
    public ExpireTimeOutOfDateException() {
        super();
    }

    public ExpireTimeOutOfDateException(String message) {
        super(message);
    }
}
