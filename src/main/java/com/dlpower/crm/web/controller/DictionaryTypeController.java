package com.dlpower.crm.web.controller;

import com.dlpower.crm.pojo.DictionaryType;
import com.dlpower.crm.service.DictionaryTypeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import java.util.List;

/**
 * @author chenlanjiang
 * @date 2021/5/27
 */
@Controller
@RequestMapping("type")
public class DictionaryTypeController {

    @Autowired
    private DictionaryTypeService dictionaryTypeService;

    @RequestMapping("listType.do")
    public ModelAndView getDictionaryTypeAll() {
        ModelAndView mv = new ModelAndView();

        List<DictionaryType> typeList = dictionaryTypeService.listDictionaryType();

        mv.addObject("typeList", typeList);
        mv.setViewName("/settings/dictionary/type/index");
        return mv;
    }

    @RequestMapping("exist.json")
    public @ResponseBody Boolean typeExist(String code) {
        DictionaryType dictionaryType = dictionaryTypeService.getDictionaryType(code);

            return dictionaryType != null;

    }

    @RequestMapping("save.do")
    public String saveDictionaryType(DictionaryType type) {
        dictionaryTypeService.insertDictionaryType(type);

        return "redirect:/type/listType.do";
    }

    @RequestMapping("edit.html")
    public ModelAndView editDictionaryTypeView(String code) {
        ModelAndView mv = new ModelAndView();

        DictionaryType dictionaryType = dictionaryTypeService.getDictionaryType(code);

        mv.addObject("dictionaryType", dictionaryType);
        mv.setViewName("settings/dictionary/type/edit");

        return mv;
    }


    @RequestMapping("edit.do")
    public String editDictionaryType(DictionaryType type) {
        dictionaryTypeService.updateDictionaryType(type);

        return "redirect:/type/index.html";
    }


    @RequestMapping("delete.do")
    public String deleteDictionaryType(String[] ids) {
        dictionaryTypeService.deleteDictionaryType(ids);

        return "redirect:/type/index.html";
    }

}
