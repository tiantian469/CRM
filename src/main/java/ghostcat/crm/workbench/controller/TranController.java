package ghostcat.crm.workbench.controller;

import ghostcat.crm.settings.domain.User;
import ghostcat.crm.utils.DateTimeUtil;
import ghostcat.crm.utils.PrintJson;
import ghostcat.crm.utils.UUIDUtil;
import ghostcat.crm.vo.PageVo;
import ghostcat.crm.workbench.domain.*;
import ghostcat.crm.workbench.service.TranService;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping(value = "/tran")
public class TranController {
    @Resource
    private TranService tranService;

    @RequestMapping(value = "/queryAllTranInPage.do")
    @ResponseBody
    public PageVo<Tran> queryAllTranInPage(Integer pageNo, Integer pageSize, String owner, String name, String customerName, String stage, String type, String source, String contactsName){
        /*Customer customer = tranService.queryCustomerWithName(customerName);
        String customerId;
        if (customer != null){
            customerId = customer.getId();
        }else {
            customerId = "";
        }*/
        /*List<Contacts> contactsList = tranService.queryContactsWithName(contactsName);
        String[] contactsId;
        int i = 1;
        if (contactsList != null){
            for (Contacts contacts:contactsList){
                contactsId = new String[contactsList.size()];
                contactsId[i++] = contacts.getId();
            }
        }*/
        List<String> customerIdList = tranService.queryCustomerIDWithName(customerName);
        List<String> contactsIdList = tranService.queryAllContactsId(contactsName);
        Map<String,Object> tranMap = new HashMap<>();
        tranMap.put("owner",owner);
        tranMap.put("fullname",name);
        tranMap.put("customerIds",customerIdList);
        tranMap.put("stage",stage);
        tranMap.put("type",type);
        tranMap.put("source",source);
        tranMap.put("contactsIds",contactsIdList);
        List<Tran> tranList = tranService.queryAllTranInPage(pageNo,pageSize,tranMap);
        System.out.println("TranList的数组长度为：" + tranList.size());
        int count = tranService.queryAllTranInPageCount(tranMap);
        return new PageVo<>(count,tranList);
    }
    @RequestMapping(value = "/queryAllActivityWithName.do")
    @ResponseBody
    public PageVo<Activity> queryAllActivityWithName(String name, Integer pageNo, Integer pageSize){
        List<Activity> activityList = tranService.queryAllActivityWithName(name,pageNo,pageSize);
        int count = tranService.queryAllActivityWithNameCount(name);
        return new PageVo<>(count,activityList);
    }
    @RequestMapping(value = "/queryAllContactsWithName.do")
    @ResponseBody
    public PageVo<Contacts> queryAllContactsWithName(String fullname, Integer pageNo, Integer pageSize){
        List<Contacts> contactsList = tranService.queryAllContactsWithName(fullname,pageNo,pageSize);
        int count = tranService.queryAllContactsWithNameCount(fullname);
        return new PageVo<>(count,contactsList);
    }
    @RequestMapping(value = "/insertTran.do")
    @ResponseBody
    @Transactional(propagation = Propagation.REQUIRED,isolation = Isolation.DEFAULT,readOnly = false,rollbackFor = {
            Exception.class
    })
    public Map<String,Boolean> insertTran(String owner, String money, String name, String expectedDate, String customerName, String stage, String type, String source, String activityId, String contactsId,
                                          String description, String contactSummary, String nextContactTime, HttpServletRequest request) throws Exception {
        Customer customer = tranService.queryCustomerWithName(customerName);
        String customerId = "";
        User user = (User) request.getSession().getAttribute("user");
        String createBy = user.getName();
        String createTime = DateTimeUtil.getSysTime();
        if (customer != null){
            customerId = customer.getId();
        }else {
            Map<String,String> stringMap2 = new HashMap<>();
            String ID = UUIDUtil.getUUID();
            stringMap2.put("id",ID);
            stringMap2.put("createTime",createTime);
            stringMap2.put("createBy",createBy);
            stringMap2.put("name",customerName);
            stringMap2.put("owner",owner);
            if (tranService.createCustomer(stringMap2) != 1){
                throw new Exception("创建客户时发生异常！");
            }
            customerId = ID;
        }
        String id = UUIDUtil.getUUID();
        Map<String,String> stringMap = new HashMap<>();
        stringMap.put("id",id);
        stringMap.put("owner",owner);
        stringMap.put("money",money);
        stringMap.put("name",name);
        stringMap.put("expectedDate",expectedDate);
        stringMap.put("customerId",customerId);
        stringMap.put("stage",stage);
        stringMap.put("type",type);
        stringMap.put("source",source);
        stringMap.put("activityId",activityId);
        stringMap.put("contactsId",contactsId);
        stringMap.put("description",description);
        stringMap.put("contactSummary",contactSummary);
        stringMap.put("nextContactTime",nextContactTime);
        stringMap.put("createBy",createBy);
        stringMap.put("createTime",createTime);
        int result = tranService.insertTran(stringMap);
        Map<String,Boolean> map = new HashMap<>();
        if (result == 1){
            TranHistory tranHistory = new TranHistory();
            tranHistory.setTranId(id);
            tranHistory.setId(UUIDUtil.getUUID());
            tranHistory.setStage(stage);
            tranHistory.setMoney(money);
            tranHistory.setCreateTime(createTime);
            tranHistory.setCreateBy(createBy);
            tranHistory.setExpectedDate(expectedDate);
            int result2 = tranService.insertTranHistory(tranHistory);
            if (result2 != 1){
                throw new Exception("添加交易历史时发生异常！");
            }
            map.put("success",true);
            return map;
        }
        map.put("success",false);
        return map;
    }
    @RequestMapping(value = "/gotoEdit.do")
    public ModelAndView gotoEdit(String id){
        Tran tran = tranService.queryTranWithId2(id);
        List<User> userList = tranService.queryAllUser();
        String activityName;
        if (tran.getActivityId() == null){
            activityName = "";
        }else {
            activityName = tranService.queryActivityNameWithId(tran.getActivityId());
        }
        String contactsName;
        if (tran.getContactsId() == null){
            contactsName = "";
        }else {
            contactsName = tranService.queryContactsNameWithId(tran.getContactsId());
        }
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.addObject("id",tran.getId());
        modelAndView.addObject("owner",tran.getOwner());
        modelAndView.addObject("money",tran.getMoney());
        modelAndView.addObject("name",tran.getName());
        modelAndView.addObject("expectedDate",tran.getExpectedDate());
        modelAndView.addObject("customerId",tran.getCustomerId());
        modelAndView.addObject("stage",tran.getStage());
        modelAndView.addObject("type",tran.getType());
        modelAndView.addObject("source",tran.getSource());
        modelAndView.addObject("activityId",tran.getActivityId());
        modelAndView.addObject("contactsId",tran.getContactsId());
        modelAndView.addObject("createBy",tran.getCreateBy());
        modelAndView.addObject("createTime",tran.getCreateTime());
        modelAndView.addObject("editBy",tran.getEditBy());
        modelAndView.addObject("editTime",tran.getEditTime());
        modelAndView.addObject("description",tran.getDescription());
        modelAndView.addObject("contactSummary",tran.getContactSummary());
        modelAndView.addObject("nextContactTime",tran.getNextContactTime());
        modelAndView.addObject("activityName",activityName);
        modelAndView.addObject("contactsName",contactsName);
        modelAndView.addObject("userList",userList);
        modelAndView.setViewName("edit");
        return modelAndView;
    }
    @RequestMapping(value = "/tranDetail.do")
    public ModelAndView gotoDetail(String id){
        Tran tran = tranService.queryTranWithId(id);
        List<User> userList = tranService.queryAllUser();
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.addObject("id",tran.getId());
        modelAndView.addObject("owner",tran.getOwner());
        modelAndView.addObject("money",tran.getMoney());
        modelAndView.addObject("name",tran.getName());
        modelAndView.addObject("expectedDate",tran.getExpectedDate());
        modelAndView.addObject("customerId",tran.getCustomerId());
        modelAndView.addObject("stage",tran.getStage());
        modelAndView.addObject("type",tran.getType());
        modelAndView.addObject("source",tran.getSource());
        modelAndView.addObject("activityId",tran.getActivityId());
        modelAndView.addObject("contactsId",tran.getContactsId());
        modelAndView.addObject("createBy",tran.getCreateBy());
        modelAndView.addObject("createTime",tran.getCreateTime());
        modelAndView.addObject("editBy",tran.getEditBy());
        modelAndView.addObject("editTime",tran.getEditTime());
        modelAndView.addObject("description",tran.getDescription());
        modelAndView.addObject("contactSummary",tran.getContactSummary());
        modelAndView.addObject("nextContactTime",tran.getNextContactTime());
        modelAndView.addObject("userList",userList);
        modelAndView.setViewName("transactiondetail");
        return modelAndView;
    }
    @RequestMapping(value = "/updateTran.do")
    @ResponseBody
    @Transactional(propagation = Propagation.REQUIRED,isolation = Isolation.DEFAULT,readOnly = false,rollbackFor = {
            Exception.class
    })
    public Map<String,Boolean> updateTran(String id, String owner, String money, String name, String expectedDate, String customerName, String stage, String type, String source, String activityId, String contactsId,
                                          String description, String contactSummary, String nextContactTime, HttpServletRequest request) throws Exception {
        Customer customer = tranService.queryCustomerWithName(customerName);
        String customerId = "";
        User user = (User) request.getSession().getAttribute("user");
        String editBy = user.getName();
        String editTime = DateTimeUtil.getSysTime();
        if (customer != null){
            customerId = customer.getId();
        }else {
            Map<String,String> stringMap2 = new HashMap<>();
            String ID = UUIDUtil.getUUID();
            stringMap2.put("id",ID);
            stringMap2.put("createTime",editTime);
            stringMap2.put("createBy",editBy);
            stringMap2.put("name",customerName);
            stringMap2.put("owner",owner);
            if (tranService.createCustomer(stringMap2) != 1){
                throw new Exception("创建客户时发生异常！");
            }
            customerId = ID;
        }
        Map<String,String> stringMap = new HashMap<>();
        stringMap.put("id",id);
        stringMap.put("owner",owner);
        stringMap.put("money",money);
        stringMap.put("name",name);
        stringMap.put("expectedDate",expectedDate);
        stringMap.put("customerId",customerId);
        stringMap.put("stage",stage);
        stringMap.put("type",type);
        stringMap.put("source",source);
        stringMap.put("activityId",activityId);
        stringMap.put("contactsId",contactsId);
        stringMap.put("description",description);
        stringMap.put("contactSummary",contactSummary);
        stringMap.put("nextContactTime",nextContactTime);
        stringMap.put("editBy",editBy);
        stringMap.put("editTime",editTime);
        int result = tranService.updateTran(stringMap);
        Map<String,Boolean> map = new HashMap<>();
        if (result == 1){
            map.put("success",true);
            return map;
        }
        map.put("success",false);
        return map;
    }
    @RequestMapping(value = "/deleteInDetail.do")
    @ResponseBody
    public Map<String,Boolean> deleteInDetail(String id){
        int result = tranService.deleteInDetail(id);
        Map<String,Boolean> map = new HashMap<>();
        if (result == 1){
            map.put("success",true);
            return map;
        }
        map.put("success",false);
        return map;
    }
    @RequestMapping(value = "/updateStage.do")
    @ResponseBody
    @Transactional(propagation = Propagation.REQUIRED,isolation = Isolation.DEFAULT,readOnly = false,rollbackFor = {
            Exception.class
    })
    public Map<String,Object> updateStage(String id, String stage, String money, String expectedDate, HttpServletRequest request) throws Exception {
        Map<String,String> stringMap = new HashMap<>();
        TranHistory tranHistory = new TranHistory();
        User user = (User) request.getSession().getAttribute("user");
        String editBy = user.getName();
        String editTime = DateTimeUtil.getSysTime();
        stringMap.put("id",id);
        stringMap.put("stage",stage);
        stringMap.put("editBy",editBy);
        stringMap.put("editTime",editTime);
        int result = tranService.updateTranStage(stringMap);
        Map<String,Object> resultMap = new HashMap<>();
        if (result != 1) {
            resultMap.put("success",false);
            return resultMap;
        }
        Tran tran = tranService.queryTranWithId(id);
        resultMap.put("success",true);
        resultMap.put("stage",tran.getStage());
        resultMap.put("editBy",tran.getEditBy());
        resultMap.put("editTime",tran.getEditTime());
        ServletContext application = request.getServletContext();
        Map<String,String> s2pMap = (Map<String, String>) application.getAttribute("s2pMap");
        String possibility = s2pMap.get(tran.getStage());
        System.out.println(s2pMap);
        System.out.println(possibility);
        resultMap.put("possibility",possibility);
        tranHistory.setExpectedDate(expectedDate);
        tranHistory.setTranId(id);
        tranHistory.setStage(stage);
        tranHistory.setCreateBy(editBy);
        tranHistory.setMoney(money);
        tranHistory.setCreateTime(editTime);
        tranHistory.setId(UUIDUtil.getUUID());
        int result2 = tranService.insertTranHistory(tranHistory);
        if (result2 != 1){
            throw new Exception("创建交易历史失败！进行回滚！");
        }
        return resultMap;
    }
    @RequestMapping(value = "/selectNumAndName.do")
    @ResponseBody
    public Map<String, Object> selectNumAndName(){
        int count = tranService.queryAllTranCount();
        List<Map<Integer,String>> mapList = tranService.selectGroupByStage();
        Map<String,Object> map = new HashMap<>();
        map.put("total",count);
        map.put("mapList",mapList);
        return map;
    }
}
