package ghostcat.crm.settings.service.impl;

import ghostcat.crm.exception.*;
import ghostcat.crm.settings.dao.UserDao;
import ghostcat.crm.settings.domain.User;
import ghostcat.crm.settings.service.UserService;
import ghostcat.crm.utils.DateTimeUtil;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class UserServiceImpl implements UserService {
    @Resource
    private UserDao userDao;

    @Override
    public User loginjudge(String loginAct, String loginPwd, String ip) throws LoginException{
        Map<String,String> map = new HashMap<>();
        map.put("loginAct",loginAct);
        map.put("loginPwd",loginPwd);
        User user = userDao.selectActandPwd(map);
        if (user == null){
            throw new ActOrPwdNotFoundException("用户名或密码错误！");
        }
        String expireTime = user.getExpireTime();
        String nowTime = DateTimeUtil.getSysTime();
        if(expireTime.compareTo(nowTime) < 0){
            throw new ExpireTimeOutOfDateException("您的账户日期已失效！");
        }
        String lockState = user.getLockState();
        if ("0".equals(lockState)){
            throw new LockStateException("您的账户已被锁定，请联系幽灵猫...");
        }
        String allowIps = user.getAllowIps();
        if (!allowIps.contains(ip)){
            throw new IpNotInAllowIpsException("您的IP地址未在授权范围内，给爷爬！！！");
        }
        return user;
    }

    @Override
    public List<User> queryAllUser() {
        return userDao.selectAllUser();
    }
}
