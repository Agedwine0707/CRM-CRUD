package com.dlpower.crm.web.controller;

import com.dlpower.crm.pojo.Dept;
import com.dlpower.crm.service.DeptService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @author chenlanjiang
 * @date 2021/5/29
 */
@RestController
@RequestMapping("dept")
public class DeptController {

    @Autowired
    private DeptService deptService;

    @GetMapping("list.json")
    public List listDept() {
        return deptService.selectAll();
    }

    @PostMapping
    public Map saveDept(Dept dept) {
        Boolean result = deptService.saveDept(dept);
        return new HashMap() {{
            put("success", result);
        }};
    }
    @GetMapping("{no}") // {no}是路径变量
    public boolean checkExists(@PathVariable String no) {
        return deptService.getExists(no);
    }

    @GetMapping("one/{id}") // {id}是路径变量
    public Dept get(@PathVariable String id) {
        return deptService.get(id);
    }

    @PutMapping
    public Map updateDept(Dept dept) {
        Boolean result = deptService.updateDept(dept);
        return new HashMap() {{
            put("success", result);
        }};
    }

    @DeleteMapping("{ids}")
    public Map deleteDept(@PathVariable("ids") String ids) {
        Boolean result = deptService.deleteDept(ids);
        return new HashMap() {{
            put("success", result);
        }};
    }
}


