package ghostcat.crm.settings.dao;

import ghostcat.crm.settings.domain.User;

import java.util.List;
import java.util.Map;

public interface UserDao {

    User selectActandPwd(Map<String, String> map);

    List<User> selectAllUser();
}
