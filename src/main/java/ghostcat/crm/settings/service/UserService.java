package ghostcat.crm.settings.service;

import ghostcat.crm.exception.LoginException;
import ghostcat.crm.settings.domain.User;

import java.util.List;

public interface UserService {
    User loginjudge(String loginAct, String loginPwd, String ip) throws LoginException;

    List<User> queryAllUser();
}
