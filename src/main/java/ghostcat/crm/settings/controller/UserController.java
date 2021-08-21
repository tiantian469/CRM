package ghostcat.crm.settings.controller;

import com.wxapi.WxApiCall.WxApiCall;
import com.wxapi.model.RequestModel;
import ghostcat.crm.exception.ActOrPwdNotFoundException;
import ghostcat.crm.exception.LoginException;
import ghostcat.crm.settings.domain.User;
import ghostcat.crm.settings.service.DicTypeService;
import ghostcat.crm.settings.service.UserService;
import ghostcat.crm.utils.MD5Util;
import org.springframework.stereotype.Controller;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping(value = "/user")
public class UserController {
    @Resource
    private UserService userService;
    @Resource
    private DicTypeService dicTypeService;
    @RequestMapping(value = "/loginJudgeActandPwd.do")
    @ResponseBody
    public List<Map<String,Object>> judge(String loginAct, String loginPwd, HttpServletRequest request, HttpServletResponse response){
        System.out.println(dicTypeService);
        loginPwd = MD5Util.getMD5(loginPwd);
        String ip = request.getRemoteAddr();
        System.out.println("当前用户的ip地址为：" + ip);
        try {
            User user = userService.loginjudge(loginAct,loginPwd,ip);
            request.getSession().setAttribute("user",user);
            Map<String,Object> map = new HashMap<>();
            map.put("success",true);
            List<Map<String,Object>> list = new ArrayList<>();
            list.add(map);
            return list;
        } catch (LoginException e) {
            e.printStackTrace();
            Map<String,Object> map = new HashMap<>();
            map.put("success",false);
            map.put("exception",e.getMessage());
            List<Map<String,Object>> list = new ArrayList<>();
            list.add(map);
            System.out.println(list);
            return list;
        }
    }
    @RequestMapping(value = "/queryAllUser.do")
    @ResponseBody
    public List<User> queryAllUser(){
        return userService.queryAllUser();
    }

    @RequestMapping(value = "/queryWeather")
    @ResponseBody
    public String queryWeather(String city){
        RequestModel model = new RequestModel();
        model.setGwUrl("https://way.jd.com/jisuapi/weather");
        model.setAppkey("5828e4a6345881b01d1a67143002085b");
        Map<String,Object> queryMap = new HashMap<>();
        queryMap.put("city",city); //访问参数
        //queryMap.put("cityid",""); //访问参数
        //queryMap.put("citycode",""); //访问参数
        model.setQueryParams(queryMap);
        WxApiCall wxApiCall = new WxApiCall();
        wxApiCall.setModel(model);
        System.out.println(wxApiCall.request());
        return wxApiCall.request();
    }
}
