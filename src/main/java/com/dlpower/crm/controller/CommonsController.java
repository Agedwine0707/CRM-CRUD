package com.dlpower.crm.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;

/**
 * @author chenlanjiang
 * @date 2021/5/24
 */
@Controller
public class CommonsController {
    /*
     * 默认访问登录页
     */
    @RequestMapping("/")
    public String welcomePage() {
        return "login";
    }

    /*
     * 匹配页面中以不同路径结尾的html
     * 配合mvc视图解析器获取正确路径
     * 如/workbench/index.html
     * return /workbench/index
     * 最终路径 /WEB-INF/page/workbench/index.html
     */
    @RequestMapping("/*/*.html")
    public String index(HttpServletRequest request) {

        String uri = request.getRequestURI();
        // 将html后缀去掉，匹配视图解析器
        int index = uri.lastIndexOf(".");
        return uri.substring(1, index);
    }


}
