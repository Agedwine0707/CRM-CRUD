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
    private DictionaryTypeService typeService;

    @RequestMapping("listType.do")
    public ModelAndView getTypeAll() {
        ModelAndView mv = new ModelAndView();

        List<DictionaryType> typeList = typeService.listType();

        mv.addObject("typeList", typeList);
        mv.setViewName("/settings/dictionary/type/index");
        return mv;
    }

    @RequestMapping("exist.json")
    public @ResponseBody Boolean typeExist(String code) {
        DictionaryType dictionaryType = typeService.getType(code);

            return dictionaryType != null;

    }

    @RequestMapping("save.do")
    public String saveType(DictionaryType type) {
        typeService.insertType(type);

        return "redirect:/type/listType.do";
    }

    @RequestMapping("edit.html")
    public ModelAndView editTypeView(String code) {
        ModelAndView mv = new ModelAndView();

        DictionaryType type = typeService.getType(code);

        mv.addObject("type", type);
        mv.setViewName("settings/dictionary/type/edit");

        return mv;
    }


    @RequestMapping("edit.do")
    public String editType(DictionaryType type) {
        typeService.updateType(type);

        return "redirect:/type/listType.do";
    }


    @RequestMapping("delete.do")
    public String deleteType(String ids) {
        typeService.deleteDictionaryType(ids);

        return "redirect:/type/listType.do";
    }

    @RequestMapping("getCode.do")
    public @ResponseBody List<DictionaryType> getCode() {
        return typeService.getCode();
    }




}
