package ghostcat.crm.settings.service.impl;

import ghostcat.crm.settings.dao.DicValueDao;
import ghostcat.crm.settings.service.DicValueService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;

@Service
public class DicValueServiceImpl implements DicValueService {
    @Resource
    private DicValueDao dicValueDao;
}
