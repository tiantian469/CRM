package ghostcat.crm.workbench.controller;

import ghostcat.crm.exception.ConvertException;
import ghostcat.crm.exception.DeleteException;
import ghostcat.crm.settings.domain.User;
import ghostcat.crm.utils.DateTimeUtil;
import ghostcat.crm.utils.UUIDUtil;
import ghostcat.crm.vo.PageVo;
import ghostcat.crm.workbench.domain.Activity;
import ghostcat.crm.workbench.domain.Contacts;
import ghostcat.crm.workbench.domain.ContactsRemark;
import ghostcat.crm.workbench.domain.Customer;
import ghostcat.crm.workbench.service.ContactsService;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping(value = "/contacts")
public class ContactsController {
    @Resource
    private ContactsService contactsService;
    @RequestMapping(value = "/queryAllContacts.do")
    @ResponseBody
    public PageVo<Contacts> queryAllContacts(String owner, String fullname, String source, String birth, Integer pageNo, Integer pageSize) {
        List<Contacts> contactsList = contactsService.queryAllContacts(owner,fullname,source,birth,pageNo,pageSize);
        int count = contactsService.queryAllContactsCount(owner,fullname,source,birth);
        return new PageVo<>(count,contactsList);
    }
    @RequestMapping(value = "/addContacts.do")
    @ResponseBody
    public Map<String,Boolean> addContacts(String owner, String source, String fullname, String appellation, String job, String mphone, String email, String birth, String customerName, String description,
                                           String contactSummary, String nextContactTime, String address, HttpServletRequest request) throws Exception {
        String createTime = DateTimeUtil.getSysTime();
        User user = (User) request.getSession().getAttribute("user");
        String createBy = user.getName();
        String id = UUIDUtil.getUUID();
        Customer customer = contactsService.queryCustomerWithName(customerName);
        String customerId = "";
        if (customer == null){
            Map<String,String> stringMap = new HashMap<>();
            String ID = UUIDUtil.getUUID();
            stringMap.put("id",ID);
            stringMap.put("createTime",createTime);
            stringMap.put("createBy",createBy);
            stringMap.put("name",customerName);
            stringMap.put("owner",owner);
            if (contactsService.createCustomer(stringMap) != 1){
                throw new Exception("客户添加失败！");
            }
            customerId = ID;
        }else {customerId = customer.getId();}
        Contacts contacts = new Contacts();
        contacts.setId(id);contacts.setOwner(owner);contacts.setFullname(fullname);contacts.setAppellation(appellation);contacts.setSource(source);contacts.setJob(job);contacts.setMphone(mphone);
        contacts.setEmail(email);contacts.setBirth(birth);contacts.setDescription(description);contacts.setContactSummary(contactSummary);contacts.setNextContactTime(nextContactTime);
        contacts.setAddress(address);contacts.setCreateTime(createTime);contacts.setCreateBy(createBy);contacts.setCustomerId(customerId);
        Map<String,Boolean> map = new HashMap<>();
        if (contactsService.addContacts(contacts) == 1){
            map.put("success", true);
            return map;
        }
        map.put("success",false);
        return map;
    }
    @RequestMapping(value = "/queryUserAndContacts.do")
    @ResponseBody
    public Map<String,Object> queryUserAndContacts(String id, HttpServletRequest request){
        Map<String,Object> map = new HashMap<>();
        List<User> userList = contactsService.queryAllUser();
        List<Contacts> contactsList = contactsService.queryContactsWithID(id);
        map.put("user",userList);
        map.put("contacts",contactsList);
        return map;
    }
    @RequestMapping(value = "/editContacts.do")
    @ResponseBody
    @Transactional(propagation = Propagation.REQUIRED,isolation = Isolation.DEFAULT,readOnly = false,rollbackFor = {
            Exception.class
    })
    public Map<String,Boolean> editContacts(String id, String owner, String source, String fullname, String appellation, String job, String mphone, String email, String birth, String customerName, String description,
                                            String contactSummary, String nextContactTime, String address, HttpServletRequest request) {
        User user = (User) request.getSession().getAttribute("user");
        String editBy = user.getName();
        String editTime = DateTimeUtil.getSysTime();
        Customer customer = contactsService.queryCustomerWithName(customerName);
        String customerId = "";
        Map<String,Boolean> map = new HashMap<>();
        if (customer == null){
            Map<String,String> stringMap = new HashMap<>();
            String ID = UUIDUtil.getUUID();
            stringMap.put("id",ID);
            stringMap.put("createTime",editTime);
            stringMap.put("createBy",editBy);
            stringMap.put("name",customerName);
            stringMap.put("owner",owner);
            if (contactsService.createCustomer(stringMap) != 1){
                map.put("success",false);
                return map;
            }
            customerId = ID;
        }else {customerId = customer.getId();}
        Contacts contacts = new Contacts();
        contacts.setId(id);contacts.setOwner(owner);contacts.setFullname(fullname);contacts.setAppellation(appellation);contacts.setSource(source);contacts.setJob(job);contacts.setMphone(mphone);
        contacts.setEmail(email);contacts.setBirth(birth);contacts.setDescription(description);contacts.setContactSummary(contactSummary);contacts.setNextContactTime(nextContactTime);
        contacts.setAddress(address);contacts.setEditTime(editTime);contacts.setEditBy(editBy);contacts.setCustomerId(customerId);
        if (contactsService.editContacts(contacts) == 1){
            map.put("success", true);
            return map;
        }
        map.put("success",false);
        return map;
    }
    @RequestMapping(value = "/deleteContacts.do")
    @ResponseBody
    public Map<String,Boolean> deleteContacts(@RequestParam(value = "titles[]") String[] ids) {
        Map<String,Boolean> map = new HashMap<>();
        int result = contactsService.deleteContacts(ids);
        if (result != ids.length){
            map.put("success",false);
            return map;
        }
        map.put("success",true);
        return map;
    }

    /*@ExceptionHandler(value = DeleteException.class)
    public ModelAndView deleteException(Exception exception){
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.addObject("message",exception.getMessage());tbl_contacts
        modelAndView.setViewName("exception");
        return modelAndView;
    }*/
    @RequestMapping(value = "/contactsDetail.do")
    public ModelAndView contactsDetail(String id) throws Exception {
        ModelAndView modelAndView = new ModelAndView();
        Contacts contacts = contactsService.queryContactsWithID2(id);
        if (contacts == null){
            throw new Exception("未找到该记录！请联系幽灵猫！");
        }
        modelAndView.addObject("id",contacts.getId());
        modelAndView.addObject("owner",contacts.getOwner());
        modelAndView.addObject("source",contacts.getSource());
        modelAndView.addObject("customerId",contacts.getCustomerId());
        modelAndView.addObject("fullname",contacts.getFullname());
        modelAndView.addObject("appellation",contacts.getAppellation());
        modelAndView.addObject("email",contacts.getEmail());
        modelAndView.addObject("mphone",contacts.getMphone());
        modelAndView.addObject("job",contacts.getJob());
        modelAndView.addObject("birth",contacts.getBirth());
        modelAndView.addObject("createBy",contacts.getCreateBy());
        modelAndView.addObject("createTime",contacts.getCreateTime());
        modelAndView.addObject("editBy",contacts.getEditBy());
        modelAndView.addObject("editTime",contacts.getEditTime());
        modelAndView.addObject("description",contacts.getDescription());
        modelAndView.addObject("contactSummary",contacts.getContactSummary());
        modelAndView.addObject("nextContactTime",contacts.getNextContactTime());
        modelAndView.addObject("address",contacts.getAddress());
        modelAndView.setViewName("contactsdetail");
        return modelAndView;
    }
    @RequestMapping(value = "/deleteInDetail.do")
    @ResponseBody
    public Map<String,Boolean> deleteInDetail(String id){
        int result = contactsService.deleteContactsWithId(id);
        Map<String,Boolean> map = new HashMap<>();
        if (result == 1){
            map.put("success", true);
            return map;
        }
        map.put("success",false);
        return map;
    }
    @RequestMapping(value = "/queryContactsRemarkWithID.do")
    @ResponseBody
    public Map<String,Boolean> queryContactsRemarkWithID(String id, String noteContent){
        int result = contactsService.editContactsRemarkWithID(id,noteContent);
        Map<String,Boolean> map = new HashMap<>();
        if (result == 1){
            map.put("success", true);
            return map;
        }
        map.put("success",false);
        return map;
    }
    @RequestMapping(value = "/deleteContactsRemark.do")
    @ResponseBody
    public Map<String,Boolean> deleteContactsRemark(String id){
        int result = contactsService.deleteContactsRemarkWithID(id);
        Map<String,Boolean> map = new HashMap<>();
        if (result == 1){
            map.put("success", true);
            return map;
        }
        map.put("success",false);
        return map;
    }
    @RequestMapping(value = "/addContactsRemark.do")
    @ResponseBody
    public Map<String,Object> addContactsRemark(String noteContent, String contactsId, HttpServletRequest request){
        User user = (User) request.getSession().getAttribute("user");
        String createBy = user.getName();
        String createTime = DateTimeUtil.getSysTime();
        String editFlag = "0";
        String id = UUIDUtil.getUUID();
        Map<String,String> stringMap = new HashMap<>();
        stringMap.put("id",id);
        stringMap.put("noteContent",noteContent);
        stringMap.put("createBy",createBy);
        stringMap.put("createTime",createTime);
        stringMap.put("editFlag",editFlag);
        stringMap.put("contactsId",contactsId);
        int result = contactsService.addContactsRemark(stringMap);
        Map<String,Object> map = new HashMap<>();
        if (result == 1){
            map.put("success",true);
            List<ContactsRemark> contactsRemarkList = contactsService.queryContactsRemarkWithID(id);
            map.put("contactsRemarkList",contactsRemarkList);
            return map;
        }
        map.put("success",false);
        return map;

    }
    @RequestMapping(value = "/queryAllContactsRemarkWithID.do")
    @ResponseBody
    public List<ContactsRemark> queryAllContactsRemarkWithID(String contactsId){
        return contactsService.queryAllContactsRemark(contactsId);
    }
    @RequestMapping(value = "/queryAllContactsWithCustomerId.do")
    @ResponseBody
    public List<Contacts> queryAllContactsWithCustomerId(String customerId){
        return contactsService.queryAllContactsWithCoustomerId(customerId);
    }
    @RequestMapping(value = "/queryAllActivityWithContactsId.do")
    @ResponseBody
    public List<Activity> queryAllActivityWithContactsId(String contactsId){
        return contactsService.queryAllActivityWithContactsId(contactsId);
    }
    @RequestMapping(value = "/deleteCARelation.do")
    @ResponseBody
    public Map<String,Boolean> deleteCARelation(String contactsId, String activityId){
        Map<String,String> map = new HashMap<>();
        map.put("contactsId",contactsId);
        map.put("activityId",activityId);
        int result = contactsService.deleteCARelation(map);
        Map<String,Boolean> map1 = new HashMap<>();
        if (result == 1){
            map1.put("success", true);
            return map1;
        }
        map1.put("success",false);
        return map1;
    }
    @RequestMapping(value = "/queryActivityNotInRelation.do")
    @ResponseBody
    public PageVo<Activity> queryActivityNotInRelation(String contactsId, String name, Integer pageNo, Integer pageSize){
        List<Activity> activityList = contactsService.queryActivityNotInRelation(contactsId,name,pageNo,pageSize);
        int count = contactsService.queryActivityNotInRelationCount(contactsId,name);
        return new PageVo<>(count,activityList);
    }
    @RequestMapping(value = "/addCARelation.do")
    @ResponseBody
    public Map<String,Boolean> addCARelation(@RequestParam(value = "ids[]") String[] ids, String contactsId){
        int sum = 0;
        System.out.println(Arrays.toString(ids));
        for (String activityId:ids){
            String id = UUIDUtil.getUUID();
            int result = contactsService.addCARelation(activityId,id,contactsId);
            sum += result;
        }
        Map<String,Boolean> map = new HashMap<>();
        if (sum == ids.length){
            map.put("success",true);
            return map;
        }
        map.put("success",false);
        return map;
    }
}
