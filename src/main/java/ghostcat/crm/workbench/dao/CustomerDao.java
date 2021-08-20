package ghostcat.crm.workbench.dao;

import ghostcat.crm.workbench.domain.Customer;

import java.util.List;
import java.util.Map;

public interface CustomerDao {

    Customer queryCustomerWithName(String company);

    int addCustomer(Customer customer);

    List<Customer> selectCustomer(Customer customer);

    Integer selectCustomerCount(Customer customer);

    List<Customer> selectCustomerWithID(String id);

    int updateCustomer(Customer customer);

    int deleteCustomerWithID(String id);

    Customer selectCustomerWithID2(String id);

    Customer selectCustomerWithCName(String customerName);

    int insertCustomerWithName(Map<String, String> stringMap);

    List<String> selectLikeCustomerName(String name);

    List<String> selectAllIdCustomerIdWithCName(String customerName);
}
