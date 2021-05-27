package com.dlpower.crm.web.advice;

import com.dlpower.crm.exception.LoginException;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.HashMap;
import java.util.Map;

/**
 * 对异常进行统一处理
 * @author chenlanjiang
 * @date 2021/5/24
 */
@ControllerAdvice // 对Controller进行增强，可以对异常进行集中处理
public class CRMExceptionHandler {

    // 当前方法可以捕获LoginException类型的异常
    @ExceptionHandler(LoginException.class)
    @ResponseBody
    public Map<String, Object> loginExceptionHandler(Exception e) {
        return new HashMap() {{
            put("success", false);
            put("message", e.getMessage());
        }};
    }
}
