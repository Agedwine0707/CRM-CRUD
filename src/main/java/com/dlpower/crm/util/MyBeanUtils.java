package com.dlpower.crm.util;


import com.dlpower.crm.constant.Constant;
import com.dlpower.crm.pojo.User;
import org.apache.commons.beanutils.BeanUtils;

import javax.servlet.http.HttpSession;
import java.lang.reflect.InvocationTargetException;

public class MyBeanUtils {
    public static void initSave(Object obj, HttpSession session) {
        User loginUser = (User)session.getAttribute(Constant.LOGIN_USER);
        String createBy = loginUser.getLoginact() + "(" + loginUser.getName() + ")";
        String createTime = DateTimeUtil.getSysTime();
        try {
            // 底层使用的是反射
            BeanUtils.setProperty(obj, "id", UUIDUtil.getUUID());
            BeanUtils.setProperty(obj, "createBy", createBy);
            BeanUtils.setProperty(obj, "createTime", createTime);
        } catch (IllegalAccessException | InvocationTargetException e) {
            e.printStackTrace();
        }
    }

    public static void initEdit(Object obj, HttpSession session) {
        User loginUser = (User)session.getAttribute(Constant.LOGIN_USER);
        String editBy = loginUser.getLoginact() + "(" + loginUser.getName() + ")";
        String editTime = DateTimeUtil.getSysTime();
        try {
            // 底层使用的是反射
            BeanUtils.setProperty(obj, "editBy", editBy);
            BeanUtils.setProperty(obj, "editTime", editTime);
        } catch (IllegalAccessException | InvocationTargetException e) {
            e.printStackTrace();
        }
    }
}
