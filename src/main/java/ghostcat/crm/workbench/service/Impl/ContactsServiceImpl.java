package ghostcat.crm.workbench.service.Impl;

import com.github.pagehelper.PageHelper;
import ghostcat.crm.exception.ConvertException;
import ghostcat.crm.exception.DeleteException;
import ghostcat.crm.settings.dao.UserDao;
import ghostcat.crm.settings.domain.User;
import ghostcat.crm.workbench.dao.*;
import ghostcat.crm.workbench.domain.Activity;
import ghostcat.crm.workbench.domain.Contacts;
import ghostcat.crm.workbench.domain.ContactsRemark;
import ghostcat.crm.workbench.domain.Customer;
import ghostcat.crm.workbench.service.ContactsService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class ContactsServiceImpl implements ContactsService {
    @Resource
    private ContactsDao contactsDao;
    @Resource
    private ContactsRemarkDao contactsRemarkDao;
    @Resource
    private ContactsActivityRelationDao contactsActivityRelationDao;
    @Resource
    private CustomerDao customerDao;
    @Resource
    private UserDao userDao;
    @Resource
    private ActivityDao activityDao;

    @Override
    public List<Contacts> queryAllContacts(String owner, String fullname, String source, String birth, Integer pageNo, Integer pageSize) {
        Map<String,String> map = new HashMap<>();
        map.put("owner",owner);
        map.put("fullname",fullname);
        map.put("source",source);
        map.put("birth",birth);
        PageHelper.startPage(pageNo,pageSize);
        return contactsDao.selectContacts(map);
    }

    @Override
    public int queryAllContactsCount(String owner, String fullname, String source, String birth) {
        Map<String,String> map = new HashMap<>();
        map.put("owner",owner);
        map.put("fullname",fullname);
        map.put("source",source);
        map.put("birth",birth);
        return contactsDao.selectContactsCount(map);
    }

    @Override
    public Customer queryCustomerWithName(String customerName) {
        return customerDao.selectCustomerWithCName(customerName);
    }

    @Override
    public int createCustomer(Map<String, String> stringMap) {
        return customerDao.insertCustomerWithName(stringMap);
    }

    @Override
    public int addContacts(Contacts contacts) {
        return contactsDao.addContacts(contacts);
    }

    @Override
    public List<User> queryAllUser() {
        return userDao.selectAllUser();
    }

    @Override
    public List<Contacts> queryContactsWithID(String id) {
        return contactsDao.selectContactsWithID(id);
    }

    @Override
    public int editContacts(Contacts contacts) {
        return contactsDao.updateContacts(contacts);
    }

    @Override
    public int deleteContactsRemark(String id) {
        return contactsRemarkDao.deleteContactsRemarkWithCID(id);
    }

    @Override
    public int deleteContactsActivityRelation(String id) {
        return contactsActivityRelationDao.deleteContactsActivityRelationWithCID(id);
    }
    @Transactional(propagation = Propagation.REQUIRED,isolation = Isolation.DEFAULT,readOnly = false,rollbackFor = {
            Exception.class
    })
    @Override
    public int deleteContacts(String[] ids) {
        return contactsDao.deleteContactsWithID(ids);
    }

    @Override
    public Contacts queryContactsWithID2(String id) {
        return contactsDao.selectContactsWithID2(id);
    }

    @Override
    public int deleteContactsWithId(String id) {
        return contactsDao.deleteContactsWithID2(id);
    }

    @Override
    public int editContactsRemarkWithID(String id, String noteContent) {
        Map<String,String> map = new HashMap<>();
        map.put("id",id);
        map.put("noteContent",noteContent);
        return contactsRemarkDao.updateContent(map);
    }

    @Override
    public int deleteContactsRemarkWithID(String id) {
        return contactsRemarkDao.deleteContactsRemarkWithID(id);
    }

    @Override
    public int addContactsRemark(Map<String, String> stringMap) {
        return contactsRemarkDao.insertContactsRemark(stringMap);
    }

    @Override
    public List<ContactsRemark> queryContactsRemarkWithID(String id) {
        return contactsRemarkDao.selectContactsRemarkWithID(id);
    }

    @Override
    public List<ContactsRemark> queryAllContactsRemark(String contactsId) {
        return contactsRemarkDao.selectAllContactsRemark(contactsId);
    }

    @Override
    public List<Contacts> queryAllContactsWithCoustomerId(String customerId) {
        return contactsDao.selectContactsWithCustomerID(customerId);
    }

    @Override
    public List<Activity> queryAllActivityWithContactsId(String contactsId) {
        return activityDao.selectAllActivityWithContactsId(contactsId);
    }

    @Override
    public int deleteCARelation(Map<String, String> map) {
        return contactsActivityRelationDao.deleteContactsActivityRelationWithCAID(map);
    }

    @Override
    public List<Activity> queryActivityNotInRelation(String contactsId, String name, Integer pageNo, Integer pageSize) {
        Map<String,String> map = new HashMap<>();
        map.put("contactsId",contactsId);
        map.put("name",name);
        PageHelper.startPage(pageNo,pageSize);
        return activityDao.selectActivityNotInCARelation(map);
    }

    @Override
    public int queryActivityNotInRelationCount(String contactsId, String name) {
        Map<String,String> map = new HashMap<>();
        map.put("contactsId",contactsId);
        map.put("name",name);
        return activityDao.selectActivityNotInCARelationCount(map);
    }

    @Override
    public int addCARelation(String activityId,String id, String contactsId) {
        Map<String, String> map = new HashMap<>();
        map.put("activityId",activityId);
        map.put("id",id);
        map.put("contactsId",contactsId);
        return contactsActivityRelationDao.insertCARelation(map);
    }
}
