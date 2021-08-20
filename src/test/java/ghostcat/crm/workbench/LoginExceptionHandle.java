package ghostcat.crm.workbench;

import ghostcat.crm.exception.ActOrPwdNotFoundException;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;

import javax.servlet.http.HttpServletRequest;

@ControllerAdvice
public class LoginExceptionHandle {
    @ExceptionHandler(value = ActOrPwdNotFoundException.class)
    public String actOrPwdNotFoundException(Exception e,HttpServletRequest request){
        request.setAttribute("exception",e);
        return e.getMessage();
    }
}
