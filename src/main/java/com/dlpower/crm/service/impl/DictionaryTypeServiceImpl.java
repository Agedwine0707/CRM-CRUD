package com.dlpower.crm.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.dlpower.crm.mapper.DictionaryTypeMapper;
import com.dlpower.crm.pojo.DictionaryType;
import com.dlpower.crm.service.DictionaryTypeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Arrays;
import java.util.List;

/**
 *
 */
@Service
public class DictionaryTypeServiceImpl implements DictionaryTypeService {

    @Autowired
    DictionaryTypeMapper typeMapper;

    @Override
    public List<DictionaryType> listDictionaryType() {

        return typeMapper.selectList(new QueryWrapper<>());
    }

    @Override
    public void updateDictionaryType(DictionaryType type) {
        typeMapper.insert(type);

    }

    @Override
    public void deleteDictionaryType(String[] ids) {
        typeMapper.delete(new QueryWrapper<DictionaryType>().in(Arrays.toString(ids)));
    }

    @Override
    public DictionaryType getDictionaryType(String code) {
        return typeMapper.selectById(code);
    }

    @Override
    public void insertDictionaryType(DictionaryType type) {
        typeMapper.insert(type);
    }
}
