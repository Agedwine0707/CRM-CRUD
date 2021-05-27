package com.dlpower.crm.exception;

/**
 * 登录异常
 * @author chenlanjiang
 * @date 2021/5/24
 */
public class LoginException extends RuntimeException{
    public LoginException() {}


    public LoginException(String message) {
        super(message);
    }
}
