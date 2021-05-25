package com.dlpower.crm.controller;

import com.dlpower.crm.pojo.User;
import com.dlpower.crm.service.UserService;
import com.dlpower.crm.util.MD5Util;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.Map;

/**
 * @author chenlanjiang
 * @date 2021/5/24
 */
@RestController
@RequestMapping("user")
public class UserController {

    @Autowired
    UserService userService;

    @RequestMapping("/login")
    public Map userLogin(String loginAct, String loginPwd,Boolean exemptLogin, HttpServletRequest req, HttpServletResponse resp) {
        User user = userService.getUser(loginAct, loginPwd, req.getRemoteAddr());

        // 将用户信息保存到session中
        HttpSession session = req.getSession();
        // 十天免登录
        if (exemptLogin){
            Cookie c1 = new Cookie("userid",user.getId());
            c1.setMaxAge(60 * 60 * 24 * 10);
            c1.setPath("/");
            Cookie c2 = new Cookie("password", MD5Util.getMD5(user.getLoginpwd()));
            c2.setMaxAge(60 * 60 * 24 * 10);
            c2.setPath("/");

            resp.addCookie(c1);
            resp.addCookie(c2);
        }
        session.setAttribute("user",user);

        return new HashMap(){{
            put("success", true);
        }};

    }

}
