package ghostcat.crm.workbench.dao;

import ghostcat.crm.workbench.domain.ContactsActivityRelation;

import java.util.Map;

public interface ContactsActivityRelationDao {

    int insertContactsActivityRelation(ContactsActivityRelation contactsActivityRelation);

    int deleteContactsActivityRelationWithCID(String id);

    int deleteContactsActivityRelationWithCAID(Map<String, String> map);

    int insertCARelation(Map<String, String> map);
}
