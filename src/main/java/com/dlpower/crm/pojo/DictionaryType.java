package com.dlpower.crm.pojo;

import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.io.Serializable;

/**
 * 字典类型表
 * @TableName tbl_dictionary_type
 */
@TableName(value ="tbl_dictionary_type")
@Data
public class DictionaryType implements Serializable {
    /**
     * 例如：sex、orgType
     */
    @TableId
    private String code;

    /**
     * 例如：性别、机构类型
     */
    private String name;

    /**
     * 对该字典类型的一个描述
     */
    private String description;

    @TableField(exist = false)
    private static final long serialVersionUID = 1L;
}