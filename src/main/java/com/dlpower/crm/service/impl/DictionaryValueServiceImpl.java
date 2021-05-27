package com.dlpower.crm.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.dlpower.crm.mapper.DictionaryValueMapper;
import com.dlpower.crm.pojo.DictionaryValue;
import com.dlpower.crm.service.DictionaryValueService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
*
*/
@Service
public class DictionaryValueServiceImpl implements DictionaryValueService{

    @Autowired
    private DictionaryValueMapper typeValueMapper;

    @Override
    public List<DictionaryValue> getDictionaryValueAll() {
        return typeValueMapper.selectList(new QueryWrapper<>());

    }
}
