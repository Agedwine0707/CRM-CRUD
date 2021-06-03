package com.dlpower.crm.web.controller;

import com.dlpower.crm.constant.Result;
import com.dlpower.crm.pojo.Activity;
import com.dlpower.crm.service.ActivityService;
import com.dlpower.crm.util.DateTimeUtil;
import com.dlpower.crm.util.MyBeanUtils;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

/**
 * @author chenlanjiang
 * @date 2021/6/1
 */
@RestController
@RequestMapping("activity")
public class ActivityController {

    @Autowired
    private ActivityService activityService;

    @RequestMapping("list.json")
    public List<Activity> listActivity() {
        return activityService.getList();
    }

    @RequestMapping("searchList.json")
    public List search(@RequestParam Map searchMap) {
        return activityService.searchList(searchMap);
    }

    @RequestMapping("getById.json")
    public Activity getActivityById(String id) {
        return activityService.getById(id);
    }

    @RequestMapping("save.do")
    public Map save(Activity activity) {
        return activityService.save(activity);
    }

    @RequestMapping("update.do")
    public Map update(Activity activity) {
        return activityService.update(activity);
    }

    @RequestMapping("delete.do")
    public Map delete(@RequestParam List ids) {
        return activityService.delete(ids);
    }

    /**
     * 请求将市场活动数据导出excel
     *
     * @param resp 响应
     * @throws IOException
     */
    @RequestMapping("export.do")
    public void export(HttpServletResponse resp) throws IOException {
        // 创建一个excel文件
        HSSFWorkbook excel = new HSSFWorkbook();
        // 创建页签
        HSSFSheet sheet = excel.createSheet();
        // 创建行（标题行）
        int rowindex = 0;
        HSSFRow row = sheet.createRow(rowindex++);
        // 创建单元格
        int j = 0;
        row.createCell(j++).setCellValue("名称");
        row.createCell(j++).setCellValue("所有者");
        row.createCell(j++).setCellValue("开始日期");
        row.createCell(j++).setCellValue("结束日期");

        // 获取需要导出的数据
        List<Activity> list = activityService.getList();
        for (Activity activity : list) {
            row = sheet.createRow(rowindex++);
            // 创建单元格 写入导出相关数据
            j = 0;
            row.createCell(j++).setCellValue(activity.getName());
            row.createCell(j++).setCellValue(activity.getOwner());
            row.createCell(j++).setCellValue(activity.getStartDate());
            row.createCell(j++).setCellValue(activity.getEndDate());
        }

        // 设置请求头，让文件以附件的形式下载，指定文件的名称
        resp.setHeader("Content-Disposition", "attachment;filename=Activity-" + DateTimeUtil.getSysTime() + ".xls");

        ServletOutputStream outputStream = resp.getOutputStream();

        excel.write(outputStream);
        outputStream.close();
        excel.close();


    }

    /**
     * 导入excel到数据库
     *
     * @param upFile 上传文件
     * @return result
     * @throws IOException
     */
    @RequestMapping("import.do")
    public Map importExcel(MultipartFile upFile, HttpSession session) throws IOException {
        HSSFWorkbook excel = new HSSFWorkbook(upFile.getInputStream());

        HSSFSheet sheet = excel.getSheetAt(0);
        // 第一行是标题行，从第二行开始读取
        int index = 1;
        HSSFRow row;
        List<Activity> list = new ArrayList<>();
        while ((row = sheet.getRow(index++)) != null) {
            int j = 0;
            HSSFCell cell = row.getCell(j++);
            String name = cell.getStringCellValue();
            String owner = row.getCell(j++).getStringCellValue();
            String startDate = row.getCell(j++).getStringCellValue();
            String endDate = row.getCell(j++).getStringCellValue();

            Activity activity = new Activity();
            MyBeanUtils.initSave(activity, session);
            activity.setName(name);
            activity.setOwner(owner);
            activity.setStartDate(startDate);
            activity.setEndDate(endDate);

            list.add(activity);
        }

        activityService.saveList(list);

        return Result.SUCCESS;
    }

}
