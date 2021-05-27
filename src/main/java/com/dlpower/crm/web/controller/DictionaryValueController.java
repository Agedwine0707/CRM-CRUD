package com.dlpower.crm.web.controller;

import com.dlpower.crm.pojo.DictionaryValue;
import com.dlpower.crm.service.DictionaryValueService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import java.util.List;

/**
 * 字典值请求控制器
 *
 * @author chenlanjiang
 * @date 2021/5/27
 */
@Controller
@RequestMapping("value")
public class DictionaryValueController {

    @Autowired
    private DictionaryValueService typeValue;

    @RequestMapping("listValue.do")
    public ModelAndView listDictionaryValue() {
        ModelAndView mv = new ModelAndView();

        List<DictionaryValue> valueAll = typeValue.getDictionaryValueAll();

        mv.addObject("listTypeValue", valueAll);
        mv.setViewName("/settings/dictionary/value/index");

        return mv;

    }

}
