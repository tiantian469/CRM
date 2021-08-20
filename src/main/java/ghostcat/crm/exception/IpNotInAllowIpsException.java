package ghostcat.crm.exception;

public class IpNotInAllowIpsException extends LoginException{
    public IpNotInAllowIpsException() {
        super();
    }

    public IpNotInAllowIpsException(String message) {
        super(message);
    }
}
