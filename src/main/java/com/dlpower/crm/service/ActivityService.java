package com.dlpower.crm.service;

import com.dlpower.crm.pojo.Activity;

import java.util.List;
import java.util.Map;

/**
*
*/
public interface ActivityService{

    List<Activity> getList();

    Activity getById(String id);


    Map update(Activity activity);

    Map delete(List ids);

    List searchList(Map searchMap);

    Map save(Activity activity);
}
