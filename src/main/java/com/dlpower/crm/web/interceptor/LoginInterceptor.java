package com.dlpower.crm.web.interceptor;

import com.dlpower.crm.constant.Constant;
import org.springframework.web.servlet.HandlerInterceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * 权限拦截器，未登录的用户不允许访问除登录以外的页面
 * @author chenlanjiang
 * @date 2021/5/25
 */
public class LoginInterceptor implements HandlerInterceptor {

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        if (request.getSession().getAttribute(Constant.LOGIN_USER) == null) {
            response.sendRedirect("/");
            return false;
        }
        return true;
    }
}
