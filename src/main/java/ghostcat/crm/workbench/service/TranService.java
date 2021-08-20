package ghostcat.crm.workbench.service;

import ghostcat.crm.settings.domain.User;
import ghostcat.crm.workbench.domain.*;

import java.util.List;
import java.util.Map;

public interface TranService {
    List<Tran> queryAllTranInPage(Integer pageNo, Integer pageSize, Map<String, Object> tranMap);

    Customer queryCustomerWithName(String customerName);

    List<Contacts> queryContactsWithName(String contactsName);

    List<String> queryAllContactsId(String contactsName);

    int queryAllTranInPageCount(Map<String, Object> tranMap);

    List<String> queryCustomerIDWithName(String customerName);

    List<Activity> queryAllActivityWithName(String name, Integer pageNo, Integer pageSize);

    int queryAllActivityWithNameCount(String name);

    List<Contacts> queryAllContactsWithName(String fullname, Integer pageNo, Integer pageSize);

    int queryAllContactsWithNameCount(String fullname);

    int insertTran(Map<String, String> stringMap);

    int insertTranHistory(TranHistory tranHistory);

    int createCustomer(Map<String, String> stringMap2);

    Tran queryTranWithId(String id);

    List<User> queryAllUser();

    Tran queryTranWithId2(String id);

    String queryActivityNameWithId(String activityId);

    String queryContactsNameWithId(String contactsId);

    int updateTran(Map<String, String> stringMap);

    int deleteInDetail(String id);

    int updateTranStage(Map<String, String> stringMap);

    int queryAllTranCount();

    List<Map<Integer,String>> selectGroupByStage();
}
