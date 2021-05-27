package com.dlpower.crm.service;

import com.dlpower.crm.pojo.DictionaryType;

import java.util.List;

/**
*
*/
public interface DictionaryTypeService  {

    List<DictionaryType> listDictionaryType();

    void updateDictionaryType(DictionaryType type);

    void deleteDictionaryType(String[] ids);

    DictionaryType getDictionaryType(String code);

    void insertDictionaryType(DictionaryType type);
}
