package ghostcat.crm.settings.service;

import ghostcat.crm.settings.domain.DicValue;

import java.util.List;
import java.util.Map;

public interface DicTypeService {
    Map<String, List<DicValue>> getDIC();
}
