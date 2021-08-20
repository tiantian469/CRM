package ghostcat.crm.workbench.dao;

import ghostcat.crm.workbench.domain.CustomerRemark;

import java.util.List;
import java.util.Map;

public interface CustomerRemarkDao {
    int addCustomerRemark(CustomerRemark customerRemark);

    int deleteCustomerRemarkWithCID(String id);

    List<CustomerRemark> selectAllCustomerRemark(String id);

    int updateCustomerRemark(Map<String, String> map);

    List<CustomerRemark> selectCustomerRemark(String id);

    int deleteCustomerRemarkWithID(String id);
}
