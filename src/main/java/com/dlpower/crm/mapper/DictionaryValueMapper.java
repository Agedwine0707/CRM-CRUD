package com.dlpower.crm.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.dlpower.crm.pojo.DictionaryValue;

import java.util.List;

/**
* @Entity com.dlpower.crm.pojo.DictionaryValue
*/
public interface DictionaryValueMapper extends BaseMapper<DictionaryValue> {

    /**
     * 查询所有的字典值
     * @return list
     */
    List<DictionaryValue> selectAll();

}
