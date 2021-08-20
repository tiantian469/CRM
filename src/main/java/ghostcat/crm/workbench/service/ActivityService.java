package ghostcat.crm.workbench.service;

import ghostcat.crm.settings.domain.User;
import ghostcat.crm.workbench.domain.Activity;
import ghostcat.crm.workbench.domain.ActivityRemark;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

public interface ActivityService {
    Activity queryActivityWithIDForDetail(String id);

    List<User> queryAllUser();

    int addActivity(String id,String owner, String name, String startDate, String endDate, String cost, String description, String createTime, String createBy);

    List<Activity> queryActivityWithPage(Integer pageNo, Integer pageSize, String name, String owner, String startTime, String endTime);

    Integer queryActivityWithPageCount(String name, String owner, String startTime, String endTime);

    int deleteActivity(String id);

    List<Activity> queryActivityWithID(String id);

    int editActivity(String id, String owner, String name, String startDate, String endDate, String cost, String description, String editBy, String nowTime);

    List<ActivityRemark> queryActivityRemarkWithActivityID(String activityId);

    int deleteActivityRemarkWithAID(String id);

    int addActivityRemark(String noteContent, String activityId, String id, String createTime, String createBy, String editFlag);

    ActivityRemark queryActivityRemarkWithID(String id);

    int editActivityRemarknoteContent(String id, String noteContent, HttpServletRequest request);

    int deleteActivityRemarkWithActivityID(String id);

    List<Activity> queryActivityWithClueID(String id);

    List<Activity> queryActivityNotInRelation(String id, String name, Integer pageNo, Integer pageSize);

    Integer queryActivityNotInRelationCount(String id, String name);

    List<Activity> queryActivityWithName(String name, Integer pageNo, Integer pageSize);

    Integer queryActivityWithNameCount(String name);
}
