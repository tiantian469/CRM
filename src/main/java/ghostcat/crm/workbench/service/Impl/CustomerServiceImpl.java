package ghostcat.crm.workbench.service.Impl;

import com.github.pagehelper.PageHelper;
import ghostcat.crm.workbench.dao.ContactsDao;
import ghostcat.crm.workbench.dao.CustomerDao;
import ghostcat.crm.workbench.dao.CustomerRemarkDao;
import ghostcat.crm.workbench.domain.Customer;
import ghostcat.crm.workbench.domain.CustomerRemark;
import ghostcat.crm.workbench.service.CustomerService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;
import java.util.Map;

@Service
public class CustomerServiceImpl implements CustomerService {
    @Resource
    private CustomerDao customerDao;
    @Resource
    private CustomerRemarkDao customerRemarkDao;
    @Resource
    private ContactsDao contactsDao;
    @Override
    public List<Customer> queryCustomer(String name, String owner, String phone, String website, Integer pageNo, Integer pageSize) {
        Customer customer = new Customer();
        customer.setName(name);
        customer.setOwner(owner);
        customer.setPhone(phone);
        customer.setWebsite(website);
        PageHelper.startPage(pageNo,pageSize);
        return customerDao.selectCustomer(customer);
    }

    @Override
    public Integer queryCustomerCount(String name, String owner, String phone, String website) {
        Customer customer = new Customer();
        customer.setName(name);
        customer.setOwner(owner);
        customer.setPhone(phone);
        customer.setWebsite(website);
        return customerDao.selectCustomerCount(customer);
    }

    @Override
    public int addCustomer(Customer customer) {
        return customerDao.addCustomer(customer);
    }

    @Override
    public List<Customer> queryCustomerWithID(String id) {
        return customerDao.selectCustomerWithID(id);
    }

    @Override
    public int editCustomer(Customer customer) {
        return customerDao.updateCustomer(customer);
    }

    @Override
    public int deleteCustomerWithID(String id) {
        return customerDao.deleteCustomerWithID(id);
    }

    @Override
    public Customer queryCustomerWithID2(String id) {
        return customerDao.selectCustomerWithID2(id);
    }

    @Override
    public int deleteCustomerRemarkWithCID(String id) {
        return customerRemarkDao.deleteCustomerRemarkWithCID(id);
    }

    @Override
    public List<String> queryLikeCustomerName(String name) {
        return customerDao.selectLikeCustomerName(name);
    }

    @Override
    public List<CustomerRemark> queryAllCustomerRemark(String id) {
        return customerRemarkDao.selectAllCustomerRemark(id);
    }

    @Override
    public int editCustomerRemark(Map<String, String> map) {
        return customerRemarkDao.updateCustomerRemark(map);
    }

    @Override
    public int addCustomerRemark(CustomerRemark customerRemark) {
        return customerRemarkDao.addCustomerRemark(customerRemark);
    }

    @Override
    public List<CustomerRemark> queryCustomerRemark(String id) {
        return customerRemarkDao.selectCustomerRemark(id);
    }

    @Override
    public int deleteCustomerRemark(String id) {
        return customerRemarkDao.deleteCustomerRemarkWithID(id);
    }
}
