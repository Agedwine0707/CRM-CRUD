package com.dlpower.crm.pojo;

import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.io.Serializable;

/**
 * 字典值表
 * @TableName tbl_dictionary_value
 */
@TableName(value ="tbl_dictionary_value")
@Data
public class DictionaryValue implements Serializable {
    /**
     * 唯一标识
     */
    @TableId
    private String id;

    /**
     * 字典值
     */
    private String value;

    /**
     * 文本
     */
    private String text;

    /**
     * 排序号
     */
    private Long orderno;

    /**
     * 字典类型编码
     */
    private String typecode;


    @TableField(exist = false)
    private static final long serialVersionUID = 1L;
}