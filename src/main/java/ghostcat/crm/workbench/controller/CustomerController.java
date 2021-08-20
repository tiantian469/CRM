package ghostcat.crm.workbench.controller;

import ghostcat.crm.settings.domain.User;
import ghostcat.crm.settings.service.UserService;
import ghostcat.crm.utils.DateTimeUtil;
import ghostcat.crm.utils.UUIDUtil;
import ghostcat.crm.vo.PageVo;
import ghostcat.crm.workbench.domain.Customer;
import ghostcat.crm.workbench.domain.CustomerRemark;
import ghostcat.crm.workbench.service.CustomerService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping(value = "/customer")
public class CustomerController {
    @Resource
    private CustomerService customerService;
    @Resource
    private UserService userService;

    @RequestMapping(value = "/queryCustomer.do")
    @ResponseBody
    public PageVo<Customer> queryCustomer(String name, String owner, String phone, String website, Integer pageNo, Integer pageSize){
        List<Customer> customerList = customerService.queryCustomer(name,owner,phone,website,pageNo,pageSize);
        Integer count = customerService.queryCustomerCount(name,owner,phone,website);
        return new PageVo<Customer>(count,customerList);
    }
    @RequestMapping(value = "/addCustomer.do")
    @ResponseBody
    public Map<String,Boolean> addCustomer(String owner, String name, String website, String phone, String description, String contactSummary, String nextContactTime, String address, HttpServletRequest request){
        String id = UUIDUtil.getUUID();
        User user = (User) request.getSession().getAttribute("user");
        String createBy = user.getName();
        String createTime = DateTimeUtil.getSysTime();
        Customer customer = new Customer();
        customer.setId(id);
        customer.setOwner(owner);
        customer.setName(name);
        customer.setWebsite(website);
        customer.setPhone(phone);
        customer.setCreateBy(createBy);
        customer.setCreateTime(createTime);
        customer.setContactSummary(contactSummary);
        customer.setNextContactTime(nextContactTime);
        customer.setDescription(description);
        customer.setAddress(address);
        int result = customerService.addCustomer(customer);
        Map<String,Boolean> map = new HashMap<>();
        if (result == 1){
            map.put("success",true);
            return map;
        }
        map.put("success",false);
        return map;
    }
    @RequestMapping(value = "/queryUserAndCustomer.do")
    @ResponseBody
    public Map<String,Object> queryUserAndCustomer(String id){
        Map<String,Object> map = new HashMap<>();
        List<User> userList = userService.queryAllUser();
        List<Customer> customerList = customerService.queryCustomerWithID(id);
        map.put("user",userList);
        map.put("customer",customerList);
        return map;
    }
    @RequestMapping(value = "/editCustomer.do")
    @ResponseBody
    public Map<String,Boolean> editCustomer(String id, String owner, String name, String website, String phone, String contactSummary, String nextContactTime, String description, String address, HttpServletRequest request){
        User user = (User) request.getSession().getAttribute("user");
        String editBy = user.getName();
        String editTime = DateTimeUtil.getSysTime();
        Customer customer = new Customer();
        customer.setId(id);
        customer.setOwner(owner);
        customer.setName(name);
        customer.setWebsite(website);
        customer.setPhone(phone);
        customer.setCreateBy(editBy);
        customer.setCreateTime(editTime);
        customer.setContactSummary(contactSummary);
        customer.setNextContactTime(nextContactTime);
        customer.setDescription(description);
        customer.setAddress(address);
        int result = customerService.editCustomer(customer);
        Map<String,Boolean> map = new HashMap<>();
        if (result == 1){
            map.put("success",true);
            return map;
        }
        map.put("success",false);
        return map;
    }
    @RequestMapping(value = "/deleteCustomerWithID.do")
    @ResponseBody
    public Map<String,Boolean> deleteCustomerWithID(HttpServletRequest request){
        String[] ids = request.getParameterValues("id");
        Map<String,Boolean> map = new HashMap<>();
        int sum = 0;
        for (String id:ids){
            int result = customerService.deleteCustomerWithID(id);
            int result2 = customerService.deleteCustomerRemarkWithCID(id);
            sum += result;
        }
        if (sum == ids.length){
            map.put("success",true);
            return map;
        }
        map.put("success",false);
        return map;
    }
    @RequestMapping(value = "/customerDetail.do")
    public ModelAndView customerDetail(String id){
        System.out.println("--------id="+id);
        ModelAndView modelAndView = new ModelAndView();
        Customer customer = customerService.queryCustomerWithID2(id);
        modelAndView.addObject("id",customer.getId());
        modelAndView.addObject("owner",customer.getOwner());
        modelAndView.addObject("name",customer.getName());
        modelAndView.addObject("website",customer.getWebsite());
        modelAndView.addObject("phone",customer.getPhone());
        modelAndView.addObject("createBy",customer.getCreateBy());
        modelAndView.addObject("createTime",customer.getCreateTime());
        modelAndView.addObject("editBy",customer.getEditBy());
        modelAndView.addObject("editTime",customer.getEditTime());
        modelAndView.addObject("contactSummary",customer.getContactSummary());
        modelAndView.addObject("nextContactTime",customer.getNextContactTime());
        modelAndView.addObject("description",customer.getDescription());
        modelAndView.addObject("address",customer.getAddress());
        modelAndView.setViewName("customerdetail");
        return modelAndView;
    }
    @RequestMapping(value = "/editCustomerInDetail.do")
    @ResponseBody
    public Map<String,Boolean> editCustomerInDetail(String id, String owner, String name, String website, String phone, String contactSummary, String nextContactTime, String description, String address, HttpServletRequest request){
        User user = (User) request.getSession().getAttribute("user");
        String editBy = user.getName();
        String editTime = DateTimeUtil.getSysTime();
        Customer customer = new Customer();
        customer.setAddress(address);
        customer.setDescription(description);
        customer.setContactSummary(contactSummary);
        customer.setNextContactTime(nextContactTime);
        customer.setId(id);
        customer.setOwner(owner);
        customer.setName(name);
        customer.setWebsite(website);
        customer.setPhone(phone);
        customer.setEditBy(editBy);
        customer.setEditTime(editTime);
        int result = customerService.editCustomer(customer);
        Map<String,Boolean> map = new HashMap<>();
        if (result == 1){
            map.put("success",true);
            return map;
        }
        map.put("success",false);
        return map;
    }
    @RequestMapping(value = "/deleteCustomerInDetail.do")
    @ResponseBody
    public Map<String,Boolean> deleteCustomerInDetail(String id){
        int result = customerService.deleteCustomerWithID(id);
        int result2 = customerService.deleteCustomerRemarkWithCID(id);
        Map<String,Boolean> map = new HashMap<>();
        if (result == 1){
            map.put("success",true);
            return map;
        }
        map.put("success",false);
        return map;
    }
    @RequestMapping(value = "/queryLikeCustomerName.do")
    @ResponseBody
    public List<String> queryLikeCustomerName(String name){
        return customerService.queryLikeCustomerName(name);
    }
    //只返回模型，不会走web.xml中的UTF-8转换，需要在@RequestMapping中添加produces进行配置。
    /*@RequestMapping(value = "/getstringtoajax.do",produces = "text/plain;charset=utf-8")
    @ResponseBody
    public String getStringtoAJAX(){
        return "wwwwwww凉辰今年15岁啦！wwwwwwww";
    }*/
    @RequestMapping(value = "/queryAllCustomerRemark.do")
    @ResponseBody
    public List<CustomerRemark> queryAllCustomerRemark(String id){
        return customerService.queryAllCustomerRemark(id);
    }
    @RequestMapping(value = "/editCustomerRemark.do")
    @ResponseBody
    public Map<String,Boolean> editCustomerRemark(String id, String noteContent, HttpServletRequest request){
        User user = (User) request.getSession().getAttribute("user");
        String editBy = user.getName();
        String editTime = DateTimeUtil.getSysTime();
        String editFlag = "1";
        Map<String,String> map = new HashMap<>();
        map.put("id",id);
        map.put("noteContent",noteContent);
        map.put("editBy",editBy);
        map.put("editTime",editTime);
        map.put("editFlag",editFlag);
        int result = customerService.editCustomerRemark(map);
        Map<String,Boolean> map1 = new HashMap<>();
        if (result == 1){
            map1.put("success",true);
            return map1;
        }
        map1.put("success",false);
        return map1;
    }
    @RequestMapping(value = "/addCustomerRemark.do")
    @ResponseBody
    public List<CustomerRemark> addCustomerRemark(String customerId, String noteContent, HttpServletRequest request){
        CustomerRemark customerRemark = new CustomerRemark();
        String id = UUIDUtil.getUUID();
        User user = (User) request.getSession().getAttribute("user");
        String createBy = user.getName();
        String createTime = DateTimeUtil.getSysTime();
        String editFlag = "0";
        customerRemark.setCustomerId(customerId);
        customerRemark.setCreateTime(createTime);
        customerRemark.setCreateBy(createBy);
        customerRemark.setId(id);
        customerRemark.setEditFlag(editFlag);
        customerRemark.setNoteContent(noteContent);
        int result = customerService.addCustomerRemark(customerRemark);
        return customerService.queryCustomerRemark(id);
    }
    @RequestMapping(value = "/deleteCustomerRemark.do")
    @ResponseBody
    public Map<String,Boolean> deleteCustomerRemark(String id){
        int result = customerService.deleteCustomerRemark(id);
        Map<String,Boolean> map = new HashMap<>();
        if (result == 1){
            map.put("success",true);
            return map;
        }
        map.put("success",false);
        return map;
    }
}
