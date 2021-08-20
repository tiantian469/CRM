package ghostcat.crm.workbench.service.Impl;

import com.github.pagehelper.PageHelper;
import ghostcat.crm.settings.domain.User;
import ghostcat.crm.utils.DateTimeUtil;
import ghostcat.crm.utils.UUIDUtil;
import ghostcat.crm.workbench.dao.ActivityDao;
import ghostcat.crm.workbench.domain.Activity;
import ghostcat.crm.workbench.domain.ActivityRemark;
import ghostcat.crm.workbench.service.ActivityService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class ActivityServiceImpl implements ActivityService {
    @Resource
    private ActivityDao activityDao;

    @Override
    public Activity queryActivityWithIDForDetail(String id) {
        return activityDao.selectActivityWithIDForDetail(id);
    }

    @Override
    public List<User> queryAllUser() {
        return activityDao.selectAllUser();
    }

    @Override
    public int addActivity(String id,String owner, String name, String startDate, String endDate, String cost, String description, String createTime, String createBy){
        Map<String,String> map = new HashMap<>();
        map.put("id",id);
        map.put("owner",owner);
        map.put("name",name);
        map.put("startDate",startDate);
        map.put("endDate",endDate);
        map.put("cost",cost);
        map.put("description",description);
        map.put("createTime",createTime);
        map.put("createBy",createBy);
        return activityDao.insertActivity(map);
    }

    @Override
    public List<Activity> queryActivityWithPage(Integer pageNo, Integer pageSize, String name, String owner, String startTime, String endTime) {
        Map<String,String> map = new HashMap<>();
        map.put("name",name);
        map.put("owner",owner);
        map.put("startTime",startTime);
        map.put("endTime",endTime);
        PageHelper.startPage(pageNo,pageSize);
        List<Activity> activityList = activityDao.selectActivityWithPage(map);
        return activityList;
    }

    @Override
    public Integer queryActivityWithPageCount(String name, String owner, String startTime, String endTime) {
        Map<String,String> map = new HashMap<>();
        map.put("name",name);
        map.put("owner",owner);
        map.put("startTime",startTime);
        map.put("endTime",endTime);
        return activityDao.selectActivityWithPageCount(map);
    }

    @Override
    public int deleteActivity(String id) {
        return activityDao.deleteActivity(id);
    }

    @Override
    public List<Activity> queryActivityWithID(String id) {
        return activityDao.selectActivityWithID(id);
    }

    @Override
    public int editActivity(String id, String owner, String name, String startDate, String endDate, String cost, String description, String editBy, String nowTime) {
        Map<String,String> map = new HashMap<>();
        map.put("id",id);
        map.put("owner",owner);
        map.put("name",name);
        map.put("startDate",startDate);
        map.put("endDate",endDate);
        map.put("cost",cost);
        map.put("description",description);
        map.put("editBy",editBy);
        map.put("editTime",nowTime);
        return activityDao.updateActivity(map);
    }

    @Override
    public List<ActivityRemark> queryActivityRemarkWithActivityID(String activityId) {
        return activityDao.selectActivityRemarkWithActivityID(activityId);
    }

    @Override
    public int deleteActivityRemarkWithAID(String id) {
        return activityDao.deleteActivityRemarkWithAID(id);
    }

    @Override
    public int addActivityRemark(String noteContent, String activityId, String id, String createTime, String createBy, String editFlag) {
        Map<String,String> map = new HashMap<>();
        map.put("noteContent",noteContent);
        map.put("id",id);
        map.put("createTime",createTime);
        map.put("createBy",createBy);
        map.put("editFlag",editFlag);
        map.put("activityId",activityId);
        return activityDao.insertActivityRemark(map);
    }

    @Override
    public ActivityRemark queryActivityRemarkWithID(String id) {
        return activityDao.selectActivityRemarkWithID(id);
    }

    @Override
    public int editActivityRemarknoteContent(String id, String noteContent, HttpServletRequest request) {
        String editTime = DateTimeUtil.getSysTime();
        User user = (User) request.getSession().getAttribute("user");
        String editBy = user.getName();
        String editFlag = "1";
        Map<String,String> map = new HashMap<>();
        map.put("id",id);
        map.put("noteContent",noteContent);
        map.put("editTime",editTime);
        map.put("editBy",editBy);
        map.put("editFlag",editFlag);
        return activityDao.updateActivityRemarknoteContent(map);
    }

    @Override
    public int deleteActivityRemarkWithActivityID(String id) {
        return activityDao.deleteActivityRemarkWithActivityID(id);
    }

    @Override
    public List<Activity> queryActivityWithClueID(String id) {
        return activityDao.selectActivityWithClueID(id);
    }

    @Override
    public List<Activity> queryActivityNotInRelation(String id, String name, Integer pageNo, Integer pageSize) {
        Map<String,String> map = new HashMap<>();
        map.put("clueID",id);
        map.put("name",name);
        System.out.println("------------pageNo:" + pageNo + "----------------pageSize:" + pageSize);
        PageHelper.startPage(pageNo,pageSize);
        return activityDao.selectActivityNotInRelation(map);
    }

    @Override
    public Integer queryActivityNotInRelationCount(String id, String name) {
        Map<String,String> map = new HashMap<>();
        map.put("clueID",id);
        map.put("name",name);
        return activityDao.selectActivityNotInRelationCount(map);
    }

    @Override
    public List<Activity> queryActivityWithName(String name, Integer pageNo, Integer pageSize) {
        PageHelper.startPage(pageNo,pageSize);
        return activityDao.selectActivityWithName(name);
    }

    @Override
    public Integer queryActivityWithNameCount(String name) {
        return activityDao.selectActivityWithNameCount(name);
    }
}
