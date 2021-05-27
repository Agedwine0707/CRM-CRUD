package com.dlpower.crm.web.controller;

import com.baomidou.mybatisplus.core.toolkit.StringUtils;
import com.dlpower.crm.constant.Constant;
import com.dlpower.crm.pojo.User;
import com.dlpower.crm.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;

/**
 * @author chenlanjiang
 * @date 2021/5/24
 */
@Controller
public class CommonsController {

    @Autowired
    private UserService userService;

    /*
     * 默认访问登录页
     */
    @RequestMapping("/")
    public String welcomePage(@CookieValue(value = Constant.COOKIE_USER_ACT, required = false) String userAct,
                              @CookieValue(value = Constant.COOKIE_USER_PWD, required = false) String userPwd,
                              HttpServletRequest req) {
        if (StringUtils.isNotBlank(userAct) && StringUtils.isNotBlank(userPwd)) {
            String remoteAddr = req.getRemoteAddr();
            User user = userService.automaticLogIn(userAct, userPwd, remoteAddr);
            // 用户信息不为空，将用户信息存到session中，重定向到工作目录
            if (user != null) {
                req.getSession().setAttribute(Constant.LOGIN_USER, user);
                return "redirect:/workbench/index.html";
            }
        }
        return "login";
    }


    /**
     * 匹配所有点html结尾的请求
     *
     * @param request /workbench/index.html
     * @return /WEB-INF/page/workbench/index.jsp
     */
    @RequestMapping("/**/*.html")
    public String index(HttpServletRequest request) {

        String uri = request.getRequestURI();

        // 将html后缀去掉，匹配视图解析器
        int index = uri.lastIndexOf(".");
        return uri.substring(1, index);
    }


}
