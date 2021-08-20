package ghostcat.crm.workbench.handle;

import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerExceptionResolver;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@Component
public class ExceptionHandle implements HandlerExceptionResolver {
    @Override
    public ModelAndView resolveException(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Object o, Exception e) {
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.addObject("message",e.getMessage());
        httpServletRequest.getSession().setAttribute("message",e.getMessage());
        modelAndView.setViewName("exception");
        return modelAndView;
    }
}
