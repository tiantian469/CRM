package ghostcat.crm.workbench.dao;

import ghostcat.crm.workbench.domain.ContactsRemark;

import java.util.List;
import java.util.Map;

public interface ContactsRemarkDao {

    int addContactsRemark(ContactsRemark contactsRemark);

    int deleteContactsRemarkWithCID(String id);

    int updateContent(Map<String, String> map);

    int deleteContactsRemarkWithID(String id);

    int insertContactsRemark(Map<String, String> stringMap);

    List<ContactsRemark> selectContactsRemarkWithID(String id);

    List<ContactsRemark> selectAllContactsRemark(String contactsId);
}
