package com.dlpower.crm.service;

import com.dlpower.crm.pojo.DictionaryType;

import java.util.List;

/**
*
*/
public interface DictionaryTypeService  {

    List<DictionaryType> listType();

    void updateType(DictionaryType type);

    void deleteDictionaryType(String ids);

    DictionaryType getType(String code);

    void insertType(DictionaryType type);

    List<DictionaryType> getCode();
}
