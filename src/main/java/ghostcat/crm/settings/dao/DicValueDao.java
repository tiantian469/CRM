package ghostcat.crm.settings.dao;

import ghostcat.crm.settings.domain.DicValue;

import java.util.List;

public interface DicValueDao {
    List<DicValue> getValueWithCode(String code);
}
