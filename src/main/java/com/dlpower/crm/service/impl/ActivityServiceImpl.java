package com.dlpower.crm.service.impl;

import com.dlpower.crm.constant.Result;
import com.dlpower.crm.mapper.ActivityMapper;
import com.dlpower.crm.pojo.Activity;
import com.dlpower.crm.service.ActivityService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

/**
 *
 */
@Service
public class ActivityServiceImpl implements ActivityService {

    @Autowired
    private ActivityMapper activityMapper;

    @Override
    public List<Activity> getList() {
        return activityMapper.selectList(null);
    }

    @Override
    public Activity getById(String id) {
        return activityMapper.selectById(id);
    }

    @Override
    public Map update(Activity activity) {
        int i = activityMapper.updateById(activity);
        if (i >= 1) {
            return Result.SUCCESS;
        }
        throw new RuntimeException("修改失败");
    }

    @Override
    public Map delete(List ids) {
        int i = activityMapper.deleteBatchIds(ids);
        if (i >= 1) {
            return Result.SUCCESS;
        }
        throw new RuntimeException("操作失败");
    }

    @Override
    public List searchList(Map searchMap) {
        return activityMapper.searchByMap(searchMap);
    }

    @Override
    public Map save(Activity activity) {
        int insert = activityMapper.insert(activity);
        if (insert >= 1){
            return Result.SUCCESS;
        }
        throw new RuntimeException("添加用户失败");
    }

    @Override
    public void saveList(List<Activity> list) {
        activityMapper.saveList(list);
    }
}
