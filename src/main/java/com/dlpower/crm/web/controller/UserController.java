package com.dlpower.crm.web.controller;

import com.dlpower.crm.constant.Constant;
import com.dlpower.crm.pojo.User;
import com.dlpower.crm.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

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
@Controller
@RequestMapping("user")
public class UserController {

    @Autowired
    UserService userService;

    @RequestMapping("login")
    public @ResponseBody Map userLogin(String loginAct, String loginPwd, Boolean exemptLogin, HttpServletRequest req, HttpServletResponse resp) {

        User user = userService.getUser(loginAct, loginPwd, req.getRemoteAddr());

        // 十天免登录,将用户信息放到cookie
        if (exemptLogin){
            Cookie c1 = new Cookie(Constant.COOKIE_USER_ACT,user.getId());
            c1.setMaxAge(60 * 60 * 24 * 10);
            c1.setPath("/");
            Cookie c2 = new Cookie(Constant.COOKIE_USER_PWD, user.getLoginpwd());
            c2.setMaxAge(60 * 60 * 24 * 10);
            c2.setPath("/");

            resp.addCookie(c1);
            resp.addCookie(c2);
        }

        // 将用户信息保存到session中
        HttpSession session = req.getSession();
        session.setAttribute(Constant.LOGIN_USER,user);

        return new HashMap(){{
            put("success", true);
        }};

    }

    @RequestMapping("signOut")
    public String signOut(HttpServletRequest req, HttpServletResponse resp) {
        // 移除session中的用户信息
        req.getSession().removeAttribute(Constant.LOGIN_USER);
        // 将免登录cookie信息置空
        Cookie cookie = new Cookie(Constant.COOKIE_USER_PWD, null);
        cookie.setMaxAge(0);
        cookie.setPath("/");
        resp.addCookie(cookie);


        return "redirect:/";

    }

    @RequestMapping("updatePwd")
    public @ResponseBody Map updatePwd(String id, String confirmPwd) {
        Boolean result = userService.updatePwd(id, confirmPwd);

        return new HashMap() {{
            put("success", true);
        }};
    }


}
