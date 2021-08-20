package ghostcat.crm.workbench.dao;

import ghostcat.crm.workbench.domain.Contacts;

import java.util.List;
import java.util.Map;

public interface ContactsDao {

    int addContacts(Contacts contacts);

    List<String> selectLikeContactsName(String name);

    List<Contacts> selectContacts(Map<String, String> map);

    int selectContactsCount(Map<String, String> map);

    List<Contacts> selectContactsWithID(String id);

    int updateContacts(Contacts contacts);

    int deleteContactsWithID(String[] ids);

    Contacts selectContactsWithID2(String id);

    int deleteContactsWithID2(String id);

    List<Contacts> selectContactsWithCustomerID(String customerId);

    List<Contacts> selectContactsWithName(String contactsName);

    List<String> selectAllIdContactsIdWithCName(String contactsName);

    List<Contacts> selectContactsWithLikeName(String fullname);

    int selectContactsWithLikeNameCount(String fullname);

    String selectContactsNameWithId(String contactsId);
}
