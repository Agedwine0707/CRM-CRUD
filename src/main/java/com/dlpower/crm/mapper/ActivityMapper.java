package com.dlpower.crm.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.dlpower.crm.pojo.Activity;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

/**
* @Entity com.dlpower.crm.pojo.Activity
*/
public interface ActivityMapper extends BaseMapper<Activity> {


    List<Activity> searchByMap(Map searchMap);

    void saveList(@Param("list") List<Activity> list);
}
