package ghostcat.crm.workbench.dao;

import ghostcat.crm.settings.domain.User;
import ghostcat.crm.workbench.domain.Activity;
import ghostcat.crm.workbench.domain.ActivityRemark;

import java.util.List;
import java.util.Map;

public interface ActivityDao {

    Activity selectActivityWithIDForDetail(String id);

    List<User> selectAllUser();

    int insertActivity(Map<String,String> map);

    List<Activity> selectActivityWithPage(Map<String, String> map);

    Integer selectActivityWithPageCount(Map<String, String> map);

    int deleteActivity(String id);

    List<Activity> selectActivityWithID(String id);

    int updateActivity(Map<String, String> map);

    List<ActivityRemark> selectActivityRemarkWithActivityID(String activityId);

    int deleteActivityRemarkWithAID(String id);

    int insertActivityRemark(Map<String,String> map);

    ActivityRemark selectActivityRemarkWithID(String id);

    int updateActivityRemarknoteContent(Map<String, String> map);

    int deleteActivityRemarkWithActivityID(String id);

    List<Activity> selectActivityWithClueID(String id);

    List<Activity> selectActivityNotInRelation(Map<String, String> map);

    Integer selectActivityNotInRelationCount(Map<String, String> map);

    List<Activity> selectActivityWithName(String name);

    Integer selectActivityWithNameCount(String name);

    List<Activity> selectAllActivityWithContactsId(String contactsId);

    List<Activity> selectActivityNotInCARelation(Map<String, String> contactsId);

    int selectActivityNotInCARelationCount(Map<String, String> map);

    String selectActivityNameWithId(String activityId);
}
