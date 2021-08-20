package ghostcat.crm.workbench;

import ghostcat.crm.utils.UUIDUtil;
import ghostcat.crm.workbench.service.ActivityService;
import org.junit.Assert;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;

import javax.annotation.Resource;
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations={"classpath*:config/applicationContext.xml"})
@WebAppConfiguration
public class ActivityTest {
    @Resource
    ActivityService activityService;
    @Test
    public void testA(){
        String id = UUIDUtil.getUUID();
        int result = activityService.addActivity(id,"06f5fc056eac41558a964f96daa7f27c","123456","2021-05-20","2021-05-29","-4750$","123456789","2021-05-20 05:21:10","幽灵猫");
        Assert.assertEquals(result,1);
    }
}
