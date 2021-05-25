package com.dlpower.crm.pojo;

import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.io.Serializable;

/**
 * 
 * @TableName tbl_user
 */
@TableName(value ="tbl_user")
@Data
public class User implements Serializable {
    /**
     * 主键id
     */
    @TableId
    private String id;

    /**
     * 部门id
     */
    private String deptid;

    /**
     * 登录账户
     */
    private String loginact;

    /**
     * 用户名
     */
    private String name;

    /**
     * 登录密码
     */
    private String loginpwd;

    /**
     * 用户邮箱
     */
    private String email;

    /**
     * 失效时间为空表示永不失效
     */
    private String expiretime;

    /**
     * 0表示锁定1表示启用
     */
    private String lockstatus;

    /**
     * 为空时表示不限制IP，多个IP地址之间使用半角逗号隔开
     */
    private String allowips;

    /**
     * 
     */
    private String createby;

    /**
     * 创建时间
     */
    private String createtime;

    /**
     * 
     */
    private String editby;

    /**
     * 
     */
    private String edittime;

    @TableField(exist = false)
    private static final long serialVersionUID = 1L;
}