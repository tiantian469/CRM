package ghostcat.crm.settings.listener;

import ghostcat.crm.settings.domain.DicValue;
import ghostcat.crm.settings.service.DicTypeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Component;
import org.springframework.web.context.support.WebApplicationContextUtils;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import java.util.*;

@Component
public class SystemInitListener implements ServletContextListener {
    @Autowired
    private DicTypeService dicTypeService;
    @Override
    public void contextInitialized(ServletContextEvent sce) {
        WebApplicationContextUtils.getRequiredWebApplicationContext(sce.getServletContext())
                .getAutowireCapableBeanFactory().autowireBean(this);
        System.out.println("全局作用域对象生成了！");
        ServletContext application = sce.getServletContext();
        Map<String,List<DicValue>> map = dicTypeService.getDIC();
        Set<String> set = map.keySet();
        for (String key:set){
            application.setAttribute(key,map.get(key));
        }
        ResourceBundle resourceBundle = ResourceBundle.getBundle("Stage2Possibility");
        Enumeration<String> enumeration = resourceBundle.getKeys();
        Map<String,String> s2pMap = new HashMap<>();
        while (enumeration.hasMoreElements()){
            String key = enumeration.nextElement();
            String value = resourceBundle.getString(key);
            s2pMap.put(key,value);
            System.out.println(key);
            System.out.println(value);
        }
        application.setAttribute("s2pMap",s2pMap);
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        System.out.println("全局作用域对象销毁了！");
    }
}
