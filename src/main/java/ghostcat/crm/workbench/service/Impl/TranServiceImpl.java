package ghostcat.crm.workbench.service.Impl;

import com.github.pagehelper.PageHelper;
import ghostcat.crm.settings.dao.UserDao;
import ghostcat.crm.settings.domain.User;
import ghostcat.crm.workbench.dao.*;
import ghostcat.crm.workbench.domain.*;
import ghostcat.crm.workbench.service.TranService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;
import java.util.Map;

@Service
public class TranServiceImpl implements TranService {
    @Resource
    private TranDao tranDao;
    @Resource
    private TranHistoryDao tranHistoryDao;
    @Resource
    private ContactsDao contactsDao;
    @Resource
    private CustomerDao customerDao;
    @Resource
    private ActivityDao activityDao;
    @Resource
    private UserDao userDao;

    @Override
    public List<Tran> queryAllTranInPage(Integer pageNo, Integer pageSize, Map<String, Object> tranMap) {
        PageHelper.startPage(pageNo,pageSize);
        return tranDao.selectAllTran(tranMap);
    }

    @Override
    public Customer queryCustomerWithName(String customerName) {
        return customerDao.selectCustomerWithCName(customerName);
    }

    @Override
    public List<Contacts> queryContactsWithName(String contactsName) {
        return contactsDao.selectContactsWithName(contactsName);
    }

    @Override
    public List<String> queryAllContactsId(String contactsName) {
        return contactsDao.selectAllIdContactsIdWithCName(contactsName);
    }

    @Override
    public int queryAllTranInPageCount(Map<String, Object> tranMap) {
        return tranDao.selectAllTranCount(tranMap);
    }

    @Override
    public List<String> queryCustomerIDWithName(String customerName) {
        return customerDao.selectAllIdCustomerIdWithCName(customerName);
    }

    @Override
    public List<Activity> queryAllActivityWithName(String name, Integer pageNo, Integer pageSize) {
        PageHelper.startPage(pageNo,pageSize);
        return activityDao.selectActivityWithName(name);
    }

    @Override
    public int queryAllActivityWithNameCount(String name) {
        return activityDao.selectActivityWithNameCount(name);
    }

    @Override
    public List<Contacts> queryAllContactsWithName(String fullname, Integer pageNo, Integer pageSize) {
        PageHelper.startPage(pageNo,pageSize);
        return contactsDao.selectContactsWithLikeName(fullname);
    }

    @Override
    public int queryAllContactsWithNameCount(String fullname) {
        return contactsDao.selectContactsWithLikeNameCount(fullname);
    }

    @Override
    public int insertTran(Map<String, String> stringMap) {
        return tranDao.insertTran2(stringMap);
    }

    @Override
    public int insertTranHistory(TranHistory tranHistory) {
        return tranHistoryDao.insertTranHistory(tranHistory);
    }

    @Override
    public int createCustomer(Map<String, String> stringMap2) {
        return customerDao.insertCustomerWithName(stringMap2);
    }

    @Override
    public Tran queryTranWithId(String id) {
        return tranDao.selectTranWithId(id);
    }

    @Override
    public List<User> queryAllUser() {
        return userDao.selectAllUser();
    }

    @Override
    public Tran queryTranWithId2(String id) {
        return tranDao.selectTranWithId2(id);
    }

    @Override
    public String queryActivityNameWithId(String activityId) {
        return activityDao.selectActivityNameWithId(activityId);
    }

    @Override
    public String queryContactsNameWithId(String contactsId) {
        return contactsDao.selectContactsNameWithId(contactsId);
    }

    @Override
    public int updateTran(Map<String, String> stringMap) {
        return tranDao.updateTran(stringMap);
    }

    @Override
    public int deleteInDetail(String id) {
        return tranDao.deleteInDetail(id);
    }

    @Override
    public int updateTranStage(Map<String, String> stringMap) {
        return tranDao.updateTranStage(stringMap);
    }

    @Override
    public int queryAllTranCount() {
        return tranDao.selectAllTranCount2();
    }

    @Override
    public List<Map<Integer,String>> selectGroupByStage() {
        return tranDao.selectGroupByStage();
    }
}
