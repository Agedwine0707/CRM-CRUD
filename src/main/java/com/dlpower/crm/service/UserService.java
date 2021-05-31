package com.dlpower.crm.service;

import com.dlpower.crm.pojo.User;

import java.util.List;
import java.util.Map;

/**
 * @author chenlanjiang
 * @date 2021/5/24
 */
public interface UserService{
    User getUser(String loginAct, String loginPwd, String ip);

    User automaticLogIn(String userAct, String userPwd, String remoteAddr);

    Boolean updatePwd(String id, String confirmPwd);

    List<User> getAllUser();

    Map saveUser(User user);

    Boolean getUserByAct(String act);

    Map deleteByids(String ids);
}
