package ghostcat.crm.exception;

public class LockStateException extends LoginException{
    public LockStateException() {
        super();
    }

    public LockStateException(String message) {
        super(message);
    }
}
