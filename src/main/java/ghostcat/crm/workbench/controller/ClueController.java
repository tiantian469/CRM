package ghostcat.crm.workbench.controller;

import com.alibaba.druid.stat.TableStat;
import com.sun.source.doctree.SeeTree;
import ghostcat.crm.exception.ConvertException;
import ghostcat.crm.settings.domain.User;
import ghostcat.crm.settings.service.UserService;
import ghostcat.crm.utils.DateTimeUtil;
import ghostcat.crm.utils.UUIDUtil;
import ghostcat.crm.vo.PageVo;
import ghostcat.crm.workbench.domain.Activity;
import ghostcat.crm.workbench.domain.Clue;
import ghostcat.crm.workbench.domain.ClueRemark;
import ghostcat.crm.workbench.domain.Tran;
import ghostcat.crm.workbench.service.ActivityService;
import ghostcat.crm.workbench.service.ClueService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping(value = "/clue")
public class ClueController {
    @Resource
    private ClueService clueService;
    @Resource
    private UserService userService;
    @Resource
    private ActivityService activityService;

    @RequestMapping(value = "/addClue.do")
    @ResponseBody
    public Map<String, Boolean> addClue(String fullname, String appellation, String owner, String company, String job, String email, String phone, String website
            , String mphone, String state, String source, String description, String contactSummary, String nextContactTime, String address, HttpServletRequest request) {
        String createTime = DateTimeUtil.getSysTime();
        User user = (User) request.getSession().getAttribute("user");
        String createBy = user.getName();
        String id = UUIDUtil.getUUID();
        int result = clueService.addClue(fullname, appellation, owner, company, job, email, phone, website, mphone, state, source, description, contactSummary, nextContactTime, address, createTime, createBy, id);
        Map<String, Boolean> map = new HashMap<>();
        if (result == 1) {
            map.put("success", true);
            return map;
        }
        map.put("success", false);
        return map;
    }

    @RequestMapping(value = "/queryClue.do")
    @ResponseBody
    public PageVo<Clue> queryClue(Integer pageNo, Integer pageSize, String fullname, String company, String phone, String source, String owner, String mphone, String state) {
        List<Clue> clueList = clueService.queryClue(pageNo, pageSize, fullname, company, phone, source, owner, mphone, state);
        Integer count = clueService.queryClueCount(fullname, company, phone, source, owner, mphone, state);
        return new PageVo<Clue>(count, clueList);
    }

    @RequestMapping(value = "/queryAllUserAndClue.do")
    @ResponseBody
    public Map<String, Object> queryAllUserAndClue(String id) {
        List<User> userList = userService.queryAllUser();
        List<Clue> clueList = clueService.queryAllClue(id);
        Map<String, Object> map = new HashMap<>();
        map.put("user", userList);
        map.put("clue", clueList);
        return map;
    }

    @RequestMapping(value = "/editClue.do")
    @ResponseBody
    public Map<String, Boolean> editClue(String id, String fullname, String appellation, String owner, String company, String job, String email, String phone, String website
            , String mphone, String state, String source, String description, String contactSummary, String nextContactTime, String address, HttpServletRequest request) {
        System.out.println(id);
        String editTime = DateTimeUtil.getSysTime();
        User user = (User) request.getSession().getAttribute("user");
        String editBy = user.getName();
        int result = clueService.editClue(id, fullname, appellation, owner, company, job, email, phone, website, mphone, state, source, description, contactSummary, nextContactTime, address, editTime, editBy);
        Map<String, Boolean> map = new HashMap<>();
        if (result == 1) {
            map.put("success", true);
            return map;
        }
        map.put("success", false);
        return map;
    }

    @RequestMapping(value = "/deleteClue.do")
    @ResponseBody
    public Map<String, Boolean> deleteClue(HttpServletRequest request) {
        String[] ids = request.getParameterValues("id");
        System.out.println(ids);
        int sum = 0;
        for (String id : ids) {
            int result = clueService.deleteClue(id);
            int result2 = clueService.deleteClueRemark(id);
            int result3 = clueService.deleteClueActivityRelationWithCID(id);
            sum += result;
        }
        Map<String, Boolean> map = new HashMap<>();
        if (sum == ids.length) {
            map.put("success", true);
            return map;
        }
        map.put("success", false);
        return map;
    }

    @RequestMapping(value = "/clueDetail.do")
    public ModelAndView clueDetail(String id) {
        ModelAndView modelAndView = new ModelAndView();
        Clue clue = clueService.queryClueWithID(id);
        System.out.println(clue);
        modelAndView.addObject("id", clue.getId());
        modelAndView.addObject("fullname", clue.getFullname());
        modelAndView.addObject("appellation", clue.getAppellation());
        modelAndView.addObject("owner", clue.getOwner());
        modelAndView.addObject("company", clue.getCompany());
        modelAndView.addObject("job", clue.getJob());
        modelAndView.addObject("email", clue.getEmail());
        modelAndView.addObject("phone", clue.getPhone());
        modelAndView.addObject("website", clue.getWebsite());
        modelAndView.addObject("mphone", clue.getMphone());
        modelAndView.addObject("state", clue.getState());
        modelAndView.addObject("source", clue.getSource());
        modelAndView.addObject("createBy", clue.getCreateBy());
        modelAndView.addObject("createTime", clue.getCreateTime());
        modelAndView.addObject("editBy", clue.getEditBy());
        modelAndView.addObject("editTime", clue.getEditTime());
        modelAndView.addObject("contactSummary", clue.getContactSummary());
        modelAndView.addObject("description", clue.getDescription());
        modelAndView.addObject("nextContactTime", clue.getNextContactTime());
        modelAndView.addObject("address", clue.getAddress());
        modelAndView.setViewName("cluedetail");
        return modelAndView;
    }

    @RequestMapping(value = "/deleteClueInDetail.do")
    @ResponseBody
    public Map<String, Boolean> deleteClueInDetail(String id) {
        int result = clueService.deleteClueInDetail(id);
        int result2 = clueService.deleteClueRemark(id);
        Map<String, Boolean> map = new HashMap<>();
        if (result == 1) {
            map.put("success", true);
            return map;
        }
        map.put("success", false);
        return map;
    }

    @RequestMapping(value = "/queryClueRemarkWithClueID.do")
    @ResponseBody
    public List<ClueRemark> queryClueRemarkWithClueID(String id) {
        return clueService.queryClueRemarkWithClueID(id);
    }

    @RequestMapping(value = "/addClueRemark.do")
    @ResponseBody
    public Map<String, Object> addClueRemark(String noteContent, String clueId, HttpServletRequest request) {
        String id = UUIDUtil.getUUID();
        String createTime = DateTimeUtil.getSysTime();
        User user = (User) request.getSession().getAttribute("user");
        String createBy = user.getName();
        String editFlag = "0";
        int result = clueService.addClueRemark(id, noteContent, createTime, createBy, editFlag, clueId);
        Map<String, Object> map = new HashMap<>();
        if (result == 1) {
            List<ClueRemark> clueRemarkList = clueService.queryClueRemarkWithID(id);
            map.put("success", true);
            map.put("clueRemark", clueRemarkList);
            return map;
        }
        map.put("success", false);
        return map;
    }

    @RequestMapping(value = "/editClueRemark.do")
    @ResponseBody
    public Map<String, Boolean> editClueRemark(String id, String noteContent, HttpServletRequest request) {
        User user = (User) request.getSession().getAttribute("user");
        String editBy = user.getName();
        String editTime = DateTimeUtil.getSysTime();
        String editFlag = "1";
        int result = clueService.editClueRemark(id, noteContent, editBy, editTime, editFlag);
        Map<String, Boolean> map = new HashMap<>();
        if (result == 1) {
            map.put("success", true);
            return map;
        }
        map.put("success", false);
        return map;
    }

    @RequestMapping(value = "/deleteClueRemark.do")
    @ResponseBody
    public Map<String, Boolean> deleteClueRemark(String id) {
        int result = clueService.deleteClueRemarkWithID(id);
        Map<String, Boolean> map = new HashMap<>();
        if (result == 1) {
            map.put("success", true);
            return map;
        }
        map.put("success", false);
        return map;
    }

    @RequestMapping(value = "/queryActivityWithClueID.do")
    @ResponseBody
    public List<Activity> queryActivityWithClueID(String id) {
        return activityService.queryActivityWithClueID(id);
    }

    @RequestMapping(value = "/deleteRelationWithID.do")
    @ResponseBody
    public Map<String, Boolean> deleteRelationWithID(String id) {
        int result = clueService.deleteRelationWithID(id);
        Map<String, Boolean> map = new HashMap<>();
        if (result == 1) {
            map.put("success", true);
            return map;
        }
        map.put("success", false);
        return map;
    }
    @RequestMapping(value = "/queryActivityNotInRelation.do")
    @ResponseBody
    public PageVo<Activity> queryActivityNotInRelation(String id, String name, Integer pageNo, Integer pageSize){
        System.out.println("------------pageNo:" + pageNo + "----------------pageSize:" + pageSize);
        List<Activity> activityList = activityService.queryActivityNotInRelation(id,name,pageNo,pageSize);
        Integer pageList = activityService.queryActivityNotInRelationCount(id,name);
        return new PageVo<Activity>(pageList,activityList);
    }
    @RequestMapping(value = "/addRelation.do")
    @ResponseBody
    public Map<String,Boolean> addRelation(HttpServletRequest request){
        String clueId = request.getParameter("clueId");
        String[] activityIds = request.getParameterValues("activityId");
        System.out.println(Arrays.toString(activityIds) +"-----------------------------------------"+clueId);
        Map<String,Boolean> map = new HashMap<>();
        int sum = 0;
        for (String activityId:activityIds){
            String id = UUIDUtil.getUUID();
            int result = clueService.addRelation(clueId,activityId,id);
            sum += result;
        }
        if (sum == activityIds.length){
            map.put("success",true);
            return map;
        }
        map.put("success",false);
        return map;
    }
    @RequestMapping(value = "/queryActivityWithName.do")
    @ResponseBody
    public PageVo<Activity> queryActivityWithName(String name, Integer pageNo, Integer pageSize){
        List<Activity> activityList = activityService.queryActivityWithName(name,pageNo,pageSize);
        Integer count = activityService.queryActivityWithNameCount(name);
        return new PageVo<Activity>(count,activityList);
    }
    @RequestMapping(value = "/changeClue.do")
    public String changeClueWithNoTran(HttpServletRequest request, HttpServletResponse response) throws IOException, ConvertException {
        Tran tran = null;
        String flag = request.getParameter("flag");
        if ("a".equals(flag)){
            tran = new Tran();
            User user = (User) request.getSession().getAttribute("user");
            String clueId = request.getParameter("clueId");
            String money = request.getParameter("money");
            String name = request.getParameter("name");
            String expectedDate = request.getParameter("expectedDate");
            String stage = request.getParameter("stage");
            String activityId = request.getParameter("activityId");
            String createBy = user.getName();
            String creatTime = DateTimeUtil.getSysTime();
            System.out.println(clueId+"------"+money+"------"+name+"------"+expectedDate+"------"+stage+"------"+activityId+"------"+createBy+"------"+creatTime);
            tran.setId(UUIDUtil.getUUID());
            tran.setMoney(money);
            tran.setName(name);
            tran.setExpectedDate(expectedDate);
            tran.setStage(stage);
            tran.setActivityId(activityId);
            tran.setCreateBy(createBy);
            tran.setCreateTime(creatTime);
            boolean result = clueService.convert(clueId,tran,createBy);
            if (result){
                return "redirect:/static/workbench/clue/index.jsp";
            }
            return "redirect:/static/workbench/clue/ERROR.jsp";
        }else {
            String clueId = request.getParameter("clueId");
            User user = (User) request.getSession().getAttribute("user");
            String createBy = user.getName();
            boolean result = clueService.convert(clueId,tran,createBy);
            if (result){
                return "redirect:/static/workbench/clue/index.jsp";
            }
            return "redirect:/static/workbench/clue/ERROR.jsp";
        }
    }
}
