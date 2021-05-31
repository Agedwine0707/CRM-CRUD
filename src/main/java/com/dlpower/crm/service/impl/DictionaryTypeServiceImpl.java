package com.dlpower.crm.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.conditions.update.UpdateWrapper;
import com.dlpower.crm.mapper.DictionaryTypeMapper;
import com.dlpower.crm.pojo.DictionaryType;
import com.dlpower.crm.service.DictionaryTypeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 *
 */
@Service
@Transactional
public class DictionaryTypeServiceImpl implements DictionaryTypeService {

    @Autowired
    DictionaryTypeMapper typeMapper;

    @Override
    public List<DictionaryType> listType() {

        return typeMapper.selectList(new QueryWrapper<>());
    }

    @Override
    @Transactional
    public void updateType(DictionaryType type) {
        typeMapper.updateById(type);

    }

    @Override
    @Transactional
    public void deleteDictionaryType(String ids) {
        UpdateWrapper<DictionaryType> wq = new UpdateWrapper<>();
        String[] split = ids.split(",");
        for (String s : split) {
            typeMapper.deleteById(s);
        }
    }

    @Override
    public DictionaryType getType(String code) {
        return typeMapper.selectById(code);
    }

    @Override
    @Transactional
    public void insertType(DictionaryType type) {
        typeMapper.insert(type);
    }

    @Override
    public List<DictionaryType> getCode() {
        return typeMapper.selectList(new QueryWrapper<>());
    }
}
