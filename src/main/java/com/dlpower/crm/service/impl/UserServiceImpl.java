package com.dlpower.crm.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.dlpower.crm.exception.LoginException;
import com.dlpower.crm.mapper.UserMapper;
import com.dlpower.crm.pojo.User;
import com.dlpower.crm.service.UserService;
import com.dlpower.crm.util.DateTimeUtil;
import com.dlpower.crm.util.MD5Util;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.text.ParseException;
import java.util.Date;
import java.util.HashMap;

/**
 * @author chenlanjiang
 * @date 2021/5/24
 */
@Service
public class UserServiceImpl implements UserService {

    @Autowired
    UserMapper userMapper;


    @Override
    public User getUser(String loginAct, String loginPwd, String ip) {
        // 将密码转换为MD5密文字符串
        String md5Pwd = MD5Util.getMD5(loginPwd);
        QueryWrapper<User> qw = new QueryWrapper<>();
        // 根据用户名和密码查询相应用户
        qw.allEq(new HashMap<String, Object>() {{
            put("loginAct", loginAct);
            put("loginPwd", md5Pwd);
        }});

        User user = userMapper.selectOne(qw);

        // 用户名和密码是否正确
        if (user == null) {
            throw new LoginException("用户名或密码错误");
        }

        // 用户账户是否过期
        try {
            Long ExpireTime = DateTimeUtil.stringToDate(user.getExpiretime());
            long CurrentTime = new Date().getTime();
            if (ExpireTime < CurrentTime) {
                throw new LoginException("该用户账号已过期");
            }
        } catch (ParseException e) {
            e.printStackTrace();
        }

        // 用户账户是否为启动状态
        if ("0".equals(user.getLockstatus())) {
            throw new LoginException("您的账号已被锁定，请联系管理员");
        }

        // ip地址是否运行访问
        String allowips = user.getAllowips();
        if (!"".equals(allowips) && !allowips.contains(ip)) {
            throw new LoginException("当前ip不允许访问");
        }

        return user;

    }
}
