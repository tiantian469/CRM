package ghostcat.crm.workbench.service;

import ghostcat.crm.settings.domain.User;
import ghostcat.crm.workbench.domain.Activity;
import ghostcat.crm.workbench.domain.Contacts;
import ghostcat.crm.workbench.domain.ContactsRemark;
import ghostcat.crm.workbench.domain.Customer;

import java.util.List;
import java.util.Map;

public interface ContactsService {
    List<Contacts> queryAllContacts(String owner, String fullname, String source, String birth, Integer pageNo, Integer pageSize);

    int queryAllContactsCount(String owner, String fullname, String source, String birth);

    Customer queryCustomerWithName(String customerName);

    int createCustomer(Map<String, String> stringMap);

    int addContacts(Contacts contacts);

    List<User> queryAllUser();

    List<Contacts> queryContactsWithID(String id);

    int editContacts(Contacts contacts);

    int deleteContactsRemark(String id);

    int deleteContactsActivityRelation(String id);

    int deleteContacts(String[] ids);

    Contacts queryContactsWithID2(String id);

    int deleteContactsWithId(String id);

    int editContactsRemarkWithID(String id, String noteContent);

    int deleteContactsRemarkWithID(String id);

    int addContactsRemark(Map<String, String> stringMap);

    List<ContactsRemark> queryContactsRemarkWithID(String id);

    List<ContactsRemark> queryAllContactsRemark(String contactsId);

    List<Contacts> queryAllContactsWithCoustomerId(String customerId);

    List<Activity> queryAllActivityWithContactsId(String contactsId);

    int deleteCARelation(Map<String, String> map);

    List<Activity> queryActivityNotInRelation(String contactsId, String name, Integer pageNo, Integer pageSize);

    int queryActivityNotInRelationCount(String contactsId, String name);

    int addCARelation(String activityId,String id, String contactsId);
}
