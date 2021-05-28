package com.dlpower.crm.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.dlpower.crm.mapper.DictionaryValueMapper;
import com.dlpower.crm.pojo.DictionaryValue;
import com.dlpower.crm.service.DictionaryValueService;
import com.dlpower.crm.util.UUIDUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
*
*/
@Service
@Transactional
public class DictionaryValueServiceImpl implements DictionaryValueService{

    @Autowired
    private DictionaryValueMapper typeValueMapper;

    @Override
    public List<DictionaryValue> getDictionaryValueAll() {
        return typeValueMapper.selectList(new QueryWrapper<>());

    }

    @Override
    public void saveValue(DictionaryValue value) {
        value.setId(UUIDUtil.getUUID());
        typeValueMapper.insert(value);
    }

    @Override
    public DictionaryValue getValueById(String id) {
        return typeValueMapper.selectById(id);
    }

    @Override
    public void delectByids(String ids) {
        String[] split = ids.split(",");
        for (String s : split) {
            typeValueMapper.deleteById(s);
        }
    }

    @Override
    public void updateValueById(DictionaryValue value) {
        typeValueMapper.updateById(value);
    }
}
