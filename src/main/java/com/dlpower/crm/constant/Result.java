package com.dlpower.crm.constant;

import java.util.HashMap;
import java.util.Map;

/**
 * 公共的返回结果
 *
 * @author chenlanjiang
 * @date 2021/5/31
 */
public class Result {

    public static Map<String, Object> returnTrue() {
        return new HashMap() {{
            put("success", true);
            put("msg", "添加成功");
        }};
    }

}
