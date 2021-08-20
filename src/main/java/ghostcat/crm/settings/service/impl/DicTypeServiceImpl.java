package ghostcat.crm.settings.service.impl;

import ghostcat.crm.settings.dao.DicTypeDao;
import ghostcat.crm.settings.dao.DicValueDao;
import ghostcat.crm.settings.domain.DicType;
import ghostcat.crm.settings.domain.DicValue;
import ghostcat.crm.settings.service.DicTypeService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class DicTypeServiceImpl implements DicTypeService {
    @Resource
    private DicTypeDao dicTypeDao;
    @Resource
    private DicValueDao dicValueDao;

    @Override
    public Map<String, List<DicValue>> getDIC() {
        List<DicType> list = dicTypeDao.getAllType();
        Map<String,List<DicValue>> map = new HashMap<>();
        for (DicType dicType:list){
            String code = dicType.getCode();
            List<DicValue> dicValueList = dicValueDao.getValueWithCode(code);
            map.put(code,dicValueList);
        }
        return map;
    }
}
