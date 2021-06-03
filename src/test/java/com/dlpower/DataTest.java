package com.dlpower;

import com.dlpower.crm.mapper.ActivityMapper;
import com.dlpower.crm.mapper.DictionaryValueMapper;
import com.dlpower.crm.pojo.Activity;
import com.dlpower.crm.pojo.DictionaryValue;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.ArrayList;
import java.util.List;

/**
 * @author chenlanjiang
 * @date 2021/5/27
 */
@ContextConfiguration("classpath:spring-conf.xml")
@RunWith(SpringJUnit4ClassRunner.class)
public class DataTest {
    @Autowired
    DictionaryValueMapper typeMapper;

    @Autowired
    private ActivityMapper activityMapper;

    @Test
    public void dateTest() {

        List<DictionaryValue> typeList = typeMapper.selectAll();
        System.out.println(typeList);
    }

    @Test
    public void activityTest(){
        List<Activity> list = new ArrayList<>();
        Activity activity = new Activity();
        activity.setId("11111");
        activity.setName("sdjfsk");
        list.add(activity);
        activityMapper.saveList(list);
    }

}
