package ghostcat.crm.exception;

public class ActOrPwdNotFoundException extends LoginException{
    public ActOrPwdNotFoundException() {
        super();
    }

    public ActOrPwdNotFoundException(String message) {
        super(message);
    }
}
