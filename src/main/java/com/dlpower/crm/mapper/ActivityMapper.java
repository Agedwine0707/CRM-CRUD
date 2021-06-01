package com.dlpower.crm.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.dlpower.crm.pojo.Activity;

import java.util.List;
import java.util.Map;

/**
* @Entity com.dlpower.crm.pojo.Activity
*/
public interface ActivityMapper extends BaseMapper<Activity> {


    List searchByMap(Map searchMap);
}
