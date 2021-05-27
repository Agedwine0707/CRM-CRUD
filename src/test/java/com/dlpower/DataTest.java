package com.dlpower;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.dlpower.crm.mapper.DictionaryTypeMapper;
import com.dlpower.crm.pojo.DictionaryType;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.List;

/**
 * @author chenlanjiang
 * @date 2021/5/27
 */
@ContextConfiguration("classpath:spring-conf.xml")
@RunWith(SpringJUnit4ClassRunner.class)
public class DataTest {
    @Autowired
    DictionaryTypeMapper typeMapper;

    @Test
    public void dateTest() {
        QueryWrapper<DictionaryType> qw = new QueryWrapper<>();
        qw.isNotNull("code");
        List<DictionaryType> typeList = typeMapper.selectList(qw);
        typeList.forEach(System.out::println);
    }
}
