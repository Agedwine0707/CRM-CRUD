package com.dlpower.crm.service;

import com.dlpower.crm.pojo.Dept;

import java.util.List;

/**
*
*/
public interface DeptService {

    List selectAll();

    Boolean saveDept(Dept dept);

    Boolean updateDept(Dept dept);

    Boolean deleteDept(String ids);

    boolean getExists(String no);

    Dept get(String id);
}
