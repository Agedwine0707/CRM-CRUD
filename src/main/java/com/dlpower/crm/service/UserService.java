package com.dlpower.crm.service;

import com.dlpower.crm.pojo.User;

/**
 * @author chenlanjiang
 * @date 2021/5/24
 */
public interface UserService{
    User getUser(String loginAct, String loginPwd, String ip);

}
