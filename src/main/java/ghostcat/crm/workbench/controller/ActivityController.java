package ghostcat.crm.workbench.controller;

import ghostcat.crm.settings.domain.User;
import ghostcat.crm.utils.DateTimeUtil;
import ghostcat.crm.utils.UUIDUtil;
import ghostcat.crm.vo.PageVo;
import ghostcat.crm.workbench.domain.Activity;
import ghostcat.crm.workbench.domain.ActivityRemark;
import ghostcat.crm.workbench.service.ActivityService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.sql.rowset.spi.SyncResolver;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping(value = "/activity")
public class ActivityController {
    @Resource
    private ActivityService activityService;
    @RequestMapping(value = "/queryAllUser.do")
    @ResponseBody
    public List<User> queryAllUser(){
        return activityService.queryAllUser();
    }
    @RequestMapping(value = "/addActivity.do")
    @ResponseBody
    public List<Map<String,Object>> addActivity(String owner, String name, String startDate, String endDate, String cost, String description, HttpServletRequest request){
        String id = UUIDUtil.getUUID();
        String createTime = DateTimeUtil.getSysTime();
        User user = (User) request.getSession().getAttribute("user");
        String createBy = user.getName();
        int result = activityService.addActivity(id,owner,name,startDate,endDate,cost,description,createTime,createBy);
        if (result == 1){
            List<Map<String,Object>> list = new ArrayList<>();
            Map<String,Object> map = new HashMap<>();
            map.put("success",true);
            list.add(map);
            return list;
        }else {
            List<Map<String,Object>> list = new ArrayList<>();
            Map<String,Object> map = new HashMap<>();
            map.put("success",false);
            list.add(map);
            return list;
        }
    }
    //测试用模块
    @RequestMapping(value = "/addActivity02.do")
    @ResponseBody
    public Map<String,Object> addActivity02(String owner, String name, String startDate, String endDate, String cost, String description, HttpServletRequest request){
        String id = UUIDUtil.getUUID();
        String createTime = DateTimeUtil.getSysTime();
        User user = (User) request.getSession().getAttribute("user");
        String createBy = user.getName();
        int result = activityService.addActivity(id,owner,name,startDate,endDate,cost,description,createTime,createBy);
        if (result == 1){
            //List<Student> list = new ArrayList<>();
            //Student student01 = new Student(1,"rmg",15);
            //Student student02 = new Student(2,"ghostcat",18);
            //Student student03 = new Student(3,"liangchen",21);
            //list.add(student01);
            //list.add(student02);
            //list.add(student03);
            List<Map<String,Object>> list = new ArrayList<>();
            Map<String,Object> studentMap01 = new HashMap<>();
            Map<String,Object> studentMap02 = new HashMap<>();
            Map<String,Object> studentMap03 = new HashMap<>();
            studentMap01.put("id",1);studentMap01.put("name","rmg");studentMap01.put("age",15);
            studentMap02.put("id",2);studentMap02.put("name","ghostcat");studentMap02.put("age",18);
            studentMap03.put("id",3);studentMap03.put("name","liangchen");studentMap03.put("age",21);
            list.add(studentMap01);
            list.add(studentMap02);
            list.add(studentMap03);
            Map<String,Object> map = new HashMap<>();
            map.put("success",true);
            map.put("message",list);
            return map;
        }else {
            Map<String,Object> map = new HashMap<>();
            map.put("success",false);
            return map;
        }
    }
    @RequestMapping(value = "/queryActivityWithPage.do")
    @ResponseBody
    public PageVo<Activity> queryActivityWithPage(Integer pageNo,Integer pageSize,String name,String owner,String startTime,String endTime){
        List<Activity> activityList = activityService.queryActivityWithPage(pageNo,pageSize,name,owner,startTime,endTime);
        Integer count = activityService.queryActivityWithPageCount(name,owner,startTime,endTime);
        return new PageVo<Activity>(count, activityList);
    }
    @RequestMapping(value = "/deleteActivity.do")
    @ResponseBody
    public Map<String,Boolean> deleteActivity(HttpServletRequest request){
        Map<String,Boolean> map = new HashMap<>();
        String[] ids = request.getParameterValues("id");
        int sum = 0;
        for (String id:ids) {
            int result = activityService.deleteActivity(id);
            int result2 = activityService.deleteActivityRemarkWithActivityID(id);
            sum += result;
        }
        //System.out.println(sum +"/" + ids.length);
        if (sum == ids.length){
            map.put("success",true);
        }else {
            map.put("success",false);
        }return map;
    }
    @RequestMapping(value = "/queryUserAndActivity.do")
    @ResponseBody
    public Map<String,List> queryUserAndActivity(String id){
        List<User> userList = activityService.queryAllUser();
        List<Activity> activityList = activityService.queryActivityWithID(id);
        Map<String,List> map = new HashMap<>();
        map.put("user",userList);
        map.put("activity",activityList);
        return map;
    }
    @RequestMapping(value = "/editActivity.do")
    @ResponseBody
    public Map<String,Boolean> editActivity(String id, String owner, String name, String startDate, String endDate, String cost, String description, HttpServletRequest request){
        User user = (User) request.getSession().getAttribute("user");
        String editBy = user.getName();
        String nowTime = DateTimeUtil.getSysTime();
        int result = activityService.editActivity(id,owner,name,startDate,endDate,cost,description,editBy,nowTime);
        Map<String,Boolean> map = new HashMap<>();
        if (result == 1){
            map.put("success",true);
            return map;
        }
        map.put("success",false);
        return map;
    }
    @RequestMapping(value = "/detail.do")
    public ModelAndView detail(HttpServletRequest request){
        String id = request.getParameter("id");
        ModelAndView modelAndView = new ModelAndView();
        Activity activity = activityService.queryActivityWithIDForDetail(id);
        modelAndView.addObject("id",activity.getId());
        modelAndView.addObject("owner",activity.getOwner());
        modelAndView.addObject("startDate",activity.getStartDate());
        modelAndView.addObject("endDate",activity.getEndDate());
        modelAndView.addObject("cost",activity.getCost());
        modelAndView.addObject("description",activity.getDescription());
        modelAndView.addObject("createTime",activity.getCreateTime());
        modelAndView.addObject("createBy",activity.getCreateBy());
        modelAndView.addObject("editTime",activity.getEditTime());
        modelAndView.addObject("editBy",activity.getEditBy());
        modelAndView.addObject("name",activity.getName());
        modelAndView.setViewName("detail");
        return modelAndView;
    }
    /*@RequestMapping(value = "/detail.do")
    public void detail(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String id = request.getParameter("id");
        Activity activity = activityService.queryActivityWithIDForDetail(id);
        request.setAttribute("activity",activity);
        request.getRequestDispatcher("/static/workbench/activity/cluedetail.jsp").forward(request,response);
    }*/
    @RequestMapping(value = "/queryActivityRemarkWithActivityID.do")
    @ResponseBody
    public List<ActivityRemark> queryActivityRemarkWithActivityID(String activityId){
        System.out.println(activityId);
        return activityService.queryActivityRemarkWithActivityID(activityId);
    }
    @RequestMapping(value = "/deleteActivityRemarkWithAID.do")
    @ResponseBody
    public Map<String,Boolean> deleteActivityRemarkWithAID(String id){
        int result = activityService.deleteActivityRemarkWithAID(id);
        Map<String,Boolean> map = new HashMap<>();
        if (result != 0){
            map.put("success",true);
            return map;
        }
        map.put("success",false);
        return map;
    }
    @RequestMapping(value = "/addActivityRemark.do")
    @ResponseBody
    public Map<String,Object> addActivityRemark(String noteContent, String activityId, HttpServletRequest request){
        String id = UUIDUtil.getUUID();
        String createTime = DateTimeUtil.getSysTime();
        User user = (User) request.getSession().getAttribute("user");
        String createBy = user.getName();
        String editFlag = "0";
        int result = activityService.addActivityRemark(noteContent,activityId,id,createTime,createBy,editFlag);
        Map<String,Object> map = new HashMap<>();
        if (result != 1){
            map.put("success",false);
            return map;
        }
        map.put("success",true);
        ActivityRemark activityRemark = activityService.queryActivityRemarkWithID(id);
        List<ActivityRemark> activityRemarkList = new ArrayList<>();
        activityRemarkList.add(activityRemark);
        map.put("activityRemark",activityRemarkList);
        return map;
    }
    @RequestMapping(value = "/editActivityRemarknoteContent.do")
    @ResponseBody
    public Map<String,Object> editActivityRemarknoteContent(String id, String noteContent, HttpServletRequest request){
        Map<String,Object> map = new HashMap<>();
        int result = activityService.editActivityRemarknoteContent(id,noteContent,request);
        if (result == 1){
            map.put("success",true);
            map.put("id",id);
            return map;
        }
        map.put("success",false);
        return map;
    }
    @RequestMapping(value = "/deleteActivityInDetail.do")
    @ResponseBody
    public Map<String,Boolean> deleteActivityInDetail(String id){
        int result = activityService.deleteActivity(id);
        int result2 = activityService.deleteActivityRemarkWithActivityID(id);
        Map<String,Boolean> map = new HashMap<>();
        if (result == 1){
            map.put("success",true);
            return map;
        }
        map.put("success",false);
        return map;
    }
}
