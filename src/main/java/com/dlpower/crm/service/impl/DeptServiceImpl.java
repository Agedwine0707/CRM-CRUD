package com.dlpower.crm.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.dlpower.crm.mapper.DeptMapper;
import com.dlpower.crm.pojo.Dept;
import com.dlpower.crm.service.DeptService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 *
 */
@Service
public class DeptServiceImpl implements DeptService {
    @Autowired
    private DeptMapper deptMapper;

    @Override
    public List selectAll() {
        return deptMapper.selectList(new QueryWrapper<>());
    }

    @Override
    @Transactional
    public Boolean saveDept(Dept dept) {
        int insert = deptMapper.insert(dept);
        return insert >= 1;
    }

    @Override
    @Transactional
    public Boolean updateDept(Dept dept) {
        int update = deptMapper.updateById(dept);
        return update >= 1;
    }

    @Override
    @Transactional
    public Boolean deleteDept(String ids) {
        String[] split = ids.split(",");
        try {
            for (String s : split) {
                deptMapper.deleteById(s);
            }
        } catch (Exception e) {
            return false;
        }
        return true;

    }

    @Override
    public boolean getExists(String no) {
        Dept dept = deptMapper.selectOne(new QueryWrapper<Dept>().eq("no", no));
        return dept == null;

    }

    @Override
    public Dept get(String id) {
        return  deptMapper.selectById(id);

    }
}
