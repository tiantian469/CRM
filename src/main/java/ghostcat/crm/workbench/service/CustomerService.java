package ghostcat.crm.workbench.service;

import ghostcat.crm.workbench.domain.Customer;
import ghostcat.crm.workbench.domain.CustomerRemark;

import java.util.List;
import java.util.Map;

public interface CustomerService {
    List<Customer> queryCustomer(String name, String owner, String phone, String website, Integer pageNo, Integer pageSize);

    Integer queryCustomerCount(String name, String owner, String phone, String website);

    int addCustomer(Customer customer);

    List<Customer> queryCustomerWithID(String id);

    int editCustomer(Customer customer);

    int deleteCustomerWithID(String id);

    Customer queryCustomerWithID2(String id);

    int deleteCustomerRemarkWithCID(String id);

    List<String> queryLikeCustomerName(String name);

    List<CustomerRemark> queryAllCustomerRemark(String id);

    int editCustomerRemark(Map<String, String> map);

    int addCustomerRemark(CustomerRemark customerRemark);

    List<CustomerRemark> queryCustomerRemark(String id);

    int deleteCustomerRemark(String id);
}
