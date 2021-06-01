package com.dlpower.crm.pojo;

import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.io.Serializable;

/**
 * 
 * @TableName tbl_activity
 */
@TableName(value ="tbl_activity")
@Data
public class Activity implements Serializable {
    /**
     * 
     */
    @TableId
    private String id;

    /**
     * 
     */
    private String owner;

    /**
     * 
     */
    private String name;

    /**
     * 
     */
    private String startDate;

    /**
     * 
     */
    private String endDate;

    /**
     * 
     */
    private String cost;

    /**
     * 
     */
    private String description;

    /**
     * 
     */
    private String createTime;

    /**
     * 
     */
    private String createBy;

    /**
     * 
     */
    private String editTime;

    /**
     * 
     */
    private String editBy;

    @TableField(exist = false)
    private static final long serialVersionUID = 1L;
}