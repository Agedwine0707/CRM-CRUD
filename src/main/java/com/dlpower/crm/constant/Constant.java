package com.dlpower.crm.constant;

/**
 * 对CRM_DEMO常量进行集中管理
 *
 * @author chenlanjiang
 * @date 2021/5/25
 */
public interface Constant {

    /**
     * 登录的用户信息
     */
    String LOGIN_USER = "USER";

    /**
     * 存储在客户端的用户名cookie
     */
    String COOKIE_USER_ACT = "UU_SER";

    /**
     * 存储在客户端的用户加密密码cookie
     */
    String COOKIE_USER_PWD = "UU_PWO";

    /**
     * 用户处于锁定状态
     */
    String USER_STATUS_LOCK = "0";
}
