package com.dlpower.crm.pojo;

import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.io.Serializable;

/**
 * 部门表
 * @TableName tbl_dept
 */
@TableName(value ="tbl_dept")
@Data
public class Dept implements Serializable {
    /**
     * 
     */
    @TableId
    private String id;

    /**
     * 四位数字，具有唯一性，不能为空，可以0开始
     */
    private String no;

    /**
     * 部门名称
     */
    private String name;

    /**
     * 负责人
     */
    private String manager;

    /**
     * 描述
     */
    private String description;

    /**
     * 电话
     */
    private String phone;

    @TableField(exist = false)
    private static final long serialVersionUID = 1L;
}