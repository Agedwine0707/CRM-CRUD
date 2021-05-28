package com.dlpower.crm.service;

import com.dlpower.crm.pojo.DictionaryValue;

import java.util.List;

/**
*
*/
public interface DictionaryValueService  {

    List<DictionaryValue> getDictionaryValueAll();

    void saveValue(DictionaryValue value);

    DictionaryValue getValueById(String id);

    void delectByids(String ids);

    void updateValueById(DictionaryValue value);
}
