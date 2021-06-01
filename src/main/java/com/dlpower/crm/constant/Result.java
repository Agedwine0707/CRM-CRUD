package com.dlpower.crm.constant;

import java.util.HashMap;

/**
 * 公共的返回结果
 *
 * @author chenlanjiang
 * @date 2021/5/31
 */
public class Result {

    public static HashMap SUCCESS= new HashMap() {{
            put("success", true);
            put("msg", "操作成功！");
        }};


}
