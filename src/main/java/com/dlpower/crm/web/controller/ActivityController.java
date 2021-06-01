package com.dlpower.crm.web.controller;

import com.dlpower.crm.pojo.Activity;
import com.dlpower.crm.service.ActivityService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;
import java.util.Map;

/**
 * @author chenlanjiang
 * @date 2021/6/1
 */
@RestController
@RequestMapping("activity")
public class ActivityController {

    @Autowired
    private ActivityService activityService;

    @RequestMapping("list.json")
    public List<Activity> listActivity() {
        return activityService.getList();
    }

    @RequestMapping("searchList.json")
    public List search(@RequestParam Map searchMap) {
        return activityService.searchList(searchMap);
    }

    @RequestMapping("getById.json")
    public Activity getActivityById(String id) {
        return activityService.getById(id);
    }

    @RequestMapping("save.do")
    public Map save(Activity activity) {
        return activityService.save(activity);
    }

    @RequestMapping("update.do")
    public Map update(Activity activity) {
        return activityService.update(activity);
    }

    @RequestMapping("delete.do")
    public Map delete(@RequestParam List ids) {
        System.out.println(ids);
        return activityService.delete(ids);
    }
}
