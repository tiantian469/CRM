package ghostcat.crm.workbench.service.Impl;

import com.github.pagehelper.PageHelper;
import ghostcat.crm.exception.ConvertException;
import ghostcat.crm.utils.DateTimeUtil;
import ghostcat.crm.utils.UUIDUtil;
import ghostcat.crm.workbench.dao.*;
import ghostcat.crm.workbench.domain.*;
import ghostcat.crm.workbench.service.ClueService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import javax.sql.rowset.spi.SyncResolver;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class ClueServiceImpl implements ClueService {
    @Resource
    private ClueDao clueDao;
    @Resource
    private ClueRemarkDao clueRemarkDao;
    @Resource
    private ClueActivityRelationDao clueActivityRelationDao;
    @Resource
    private ContactsDao contactsDao;
    @Resource
    private ContactsRemarkDao contactsRemarkDao;
    @Resource
    private ContactsActivityRelationDao contactsActivityRelationDao;
    @Resource
    private TranDao tranDao;
    @Resource
    private TranHistoryDao tranHistoryDao;
    @Resource
    private CustomerDao customerDao;
    @Resource
    private CustomerRemarkDao customerRemarkDao;

    @Override
    public int addClue(String fullname, String appellation, String owner, String company, String job, String email, String phone, String website, String mphone, String state, String source, String description, String contactSummary, String nextContactTime, String address, String createTime, String createBy, String id) {
        Clue clue = new Clue(id,fullname,appellation,owner,company,job,email,phone,website,mphone,state,source,createBy,createTime,description,contactSummary,nextContactTime,address);
        return clueDao.insertClue(clue);
    }

    @Override
    public List<Clue> queryClue(Integer pageNo, Integer pageSize, String fullname, String company, String phone, String source, String owner, String mphone, String state) {
        Clue clue = new Clue();
        clue.setFullname(fullname);
        clue.setCompany(company);
        clue.setPhone(phone);
        clue.setMphone(mphone);
        clue.setSource(source);
        clue.setOwner(owner);
        clue.setState(state);
        PageHelper.startPage(pageNo,pageSize);
        return clueDao.selectClue(clue);
    }

    @Override
    public Integer queryClueCount(String fullname, String company, String phone, String source, String owner, String mphone, String state) {
        Clue clue = new Clue();
        clue.setFullname(fullname);
        clue.setCompany(company);
        clue.setPhone(phone);
        clue.setMphone(mphone);
        clue.setSource(source);
        clue.setOwner(owner);
        clue.setState(state);
        return clueDao.selectClueCount(clue);
    }

    @Override
    public List<Clue> queryAllClue(String id) {
        return clueDao.selectAllClue(id);
    }

    @Override
    public int editClue(String id, String fullname, String appellation, String owner, String company, String job, String email, String phone, String website, String mphone, String state, String source, String description, String contactSummary, String nextContactTime, String address, String editTime, String editBy) {
        Clue clue = new Clue();
        clue.setId(id);
        clue.setFullname(fullname);
        clue.setCompany(company);
        clue.setPhone(phone);
        clue.setMphone(mphone);
        clue.setSource(source);
        clue.setOwner(owner);
        clue.setState(state);
        clue.setAppellation(appellation);
        clue.setJob(job);
        clue.setEmail(email);
        clue.setWebsite(website);
        clue.setDescription(description);
        clue.setContactSummary(contactSummary);
        clue.setNextContactTime(nextContactTime);
        clue.setAddress(address);
        clue.setEditBy(editBy);
        clue.setEditTime(editTime);
        return clueDao.updateClue(clue);
    }

    @Override
    public int deleteClue(String id) {
        return clueDao.deleteClue(id);
    }

    @Override
    public int deleteClueRemark(String id) {
        return clueDao.deleteClueRemark(id);
    }

    @Override
    public Clue queryClueWithID(String id) {
        return clueDao.selectClueWithID(id);
    }

    @Override
    public List<ClueRemark> queryClueRemarkWithClueID(String id) {
        return clueDao.selectClueRemarkWithClueID(id);
    }

    @Override
    public int deleteClueInDetail(String id) {
        return clueDao.deleteClueInDetail(id);
    }

    @Override
    public int addClueRemark(String id, String noteContent, String createTime, String createBy, String editFlag, String clueId) {
        Map<String,String> map = new HashMap<>();
        map.put("id",id);
        map.put("noteContent",noteContent);
        map.put("createTime",createTime);
        map.put("createBy",createBy);
        map.put("editFlag",editFlag);
        map.put("clueId",clueId);
        return clueDao.insertClueRemark(map);
    }

    @Override
    public List<ClueRemark> queryClueRemarkWithID(String id) {
        return clueDao.selectClueRemarkWithID(id);
    }

    @Override
    public int editClueRemark(String id, String noteContent, String editBy, String editTime, String editFlag) {
        Map<String,String> map = new HashMap<>();
        map.put("noteContent",noteContent);
        map.put("editBy",editBy);
        map.put("editTime",editTime);
        map.put("editFlag",editFlag);
        map.put("id",id);
        return clueDao.updateClueRemark(map);
    }

    @Override
    public int deleteClueRemarkWithID(String id) {
        return clueDao.deleteClueRemarkWithID(id);
    }

    @Override
    public int deleteRelationWithID(String id) {
        return clueDao.deleteRelationWithID(id);
    }

    @Override
    public int addRelation(String clueId, String activityId, String id) {
        Map<String,String> map = new HashMap<>();
        map.put("id",id);
        map.put("clueId",clueId);
        map.put("activityId",activityId);
        return clueDao.insertRelation(map);
    }
    @Transactional(propagation = Propagation.REQUIRED,isolation = Isolation.DEFAULT,readOnly = false,rollbackFor = {
            Exception.class
    })
    @Override
    public boolean convert(String clueId, Tran tran, String createBy) throws ConvertException {
        String createTime = DateTimeUtil.getSysTime();
        Clue clue = clueDao.selectClueWithID2(clueId);
        Customer customer = customerDao.queryCustomerWithName(clue.getCompany());
        if (customer == null){
            customer = new Customer();
            customer.setId(UUIDUtil.getUUID());
            customer.setOwner(clue.getOwner());
            customer.setName(clue.getCompany());
            customer.setWebsite(clue.getWebsite());
            customer.setPhone(clue.getPhone());
            customer.setCreateBy(createBy);
            customer.setCreateTime(createTime);
            customer.setContactSummary(clue.getContactSummary());
            customer.setNextContactTime(clue.getNextContactTime());
            customer.setDescription(clue.getDescription());
            customer.setAddress(clue.getAddress());
            int result = customerDao.addCustomer(customer);
            if (result != 1){
                throw new ConvertException("result1发生异常！");
            }
        }
        Contacts contacts = new Contacts();
        contacts.setId(UUIDUtil.getUUID());
        contacts.setOwner(clue.getOwner());
        contacts.setSource(clue.getSource());
        contacts.setCustomerId(customer.getId());
        contacts.setFullname(clue.getFullname());
        contacts.setAppellation(clue.getAppellation());
        contacts.setEmail(clue.getEmail());
        contacts.setMphone(clue.getMphone());
        contacts.setJob(clue.getJob());
        contacts.setCreateBy(createBy);
        contacts.setCreateTime(createTime);
        contacts.setDescription(clue.getDescription());
        contacts.setContactSummary(clue.getContactSummary());
        contacts.setNextContactTime(clue.getNextContactTime());
        contacts.setAddress(clue.getAddress());
        int result2 = contactsDao.addContacts(contacts);
        if (result2 != 1){
            throw new ConvertException("result2发生异常！");
        }
        List<ClueRemark> clueRemarkList = clueDao.selectClueRemarkWithClueID(clueId);
        if (clueRemarkList != null){
            for (ClueRemark clueRemark:clueRemarkList){
                String noteContent = clueRemark.getNoteContent();
                CustomerRemark customerRemark = new CustomerRemark();
                customerRemark.setId(UUIDUtil.getUUID());
                customerRemark.setNoteContent(noteContent);
                customerRemark.setCreateBy(createBy);
                customerRemark.setCreateTime(createTime);
                customerRemark.setEditFlag("0");
                customerRemark.setCustomerId(customer.getId());
                int result3 = customerRemarkDao.addCustomerRemark(customerRemark);
                if (result3 != 1){
                    throw new ConvertException("result3发生异常！");
                }
                ContactsRemark contactsRemark = new ContactsRemark();
                contactsRemark.setId(UUIDUtil.getUUID());
                contactsRemark.setNoteContent(noteContent);
                contactsRemark.setCreateBy(createBy);
                contactsRemark.setCreateTime(createTime);
                contactsRemark.setEditFlag("0");
                contactsRemark.setContactsId(contacts.getId());
                int result4 = contactsRemarkDao.addContactsRemark(contactsRemark);
                if (result4 != 1){
                    throw new ConvertException("result4发生异常！");
                }
            }
        }
        List<ClueActivityRelation> clueActivityRelationList = clueActivityRelationDao.selectACRelationWithClueID(clueId);
        if (clueActivityRelationList != null){
            for (ClueActivityRelation clueActivityRelation:clueActivityRelationList){
                String activityId = clueActivityRelation.getActivityId();
                ContactsActivityRelation contactsActivityRelation = new ContactsActivityRelation();
                contactsActivityRelation.setId(UUIDUtil.getUUID());
                contactsActivityRelation.setContactsId(contacts.getId());
                contactsActivityRelation.setActivityId(activityId);
                int result5 = contactsActivityRelationDao.insertContactsActivityRelation(contactsActivityRelation);
                if (result5 != 1){
                    throw new ConvertException("result5发生异常！");
                }
            }
        }
        if (tran != null){
            tran.setSource(clue.getSource());
            tran.setOwner(clue.getOwner());
            tran.setContactsId(contacts.getId());
            tran.setDescription(clue.getDescription());
            tran.setContactSummary(clue.getContactSummary());
            tran.setNextContactTime(clue.getNextContactTime());
            tran.setCustomerId(customer.getId());
            int result6 = tranDao.insertTran(tran);
            if (result6 != 1){
                throw new ConvertException("result6发生异常！");
            }
            TranHistory tranHistory = new TranHistory();
            tranHistory.setId(UUIDUtil.getUUID());
            tranHistory.setStage(tran.getStage());
            tranHistory.setMoney(tran.getMoney());
            tranHistory.setExpectedDate(tran.getExpectedDate());
            tranHistory.setCreateBy(createBy);
            tranHistory.setCreateTime(createTime);
            tranHistory.setTranId(tran.getId());
            int result7 = tranHistoryDao.insertTranHistory(tranHistory);
            if (result7 != 1){
                throw new ConvertException("result7发生异常！添加历史交易记录时因未知原因导致失败，已进行回滚...");
            }
        }
        assert clueRemarkList != null;
        for (ClueRemark clueRemark:clueRemarkList){
            int result8 = clueRemarkDao.deleteClueRemark(clueRemark);
            if (result8 != 1){
                throw new ConvertException("result8发生异常！");
            }
        }
        assert clueActivityRelationList != null;
        for (ClueActivityRelation clueActivityRelation:clueActivityRelationList){
            int result9 = clueActivityRelationDao.deleteClueActivityRelation(clueActivityRelation);
            if (result9 != 1){
                throw new ConvertException("result9发生异常！");
            }
        }
        String id = clueId;
        int result10 = clueDao.deleteClue(id);
        if (result10 != 1){
            throw new ConvertException("result10发生异常！");
        }
        return true;
    }

    @Override
    public int deleteClueActivityRelationWithCID(String id) {
        return clueDao.deleteClueActivityRelationWithCID(id);
    }
}
