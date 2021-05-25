package com.dlpower.crm.util;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

public class DateTimeUtil {

	/**
	 * 返回指定格式的当前时间字符串
	 * @return yyyy-MM-dd HH:mm:ss
	 */
	public static String getSysTime(){
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		
		Date date = new Date();
		String dateStr = sdf.format(date);
		
		return dateStr;
		
	}

	/**
	 * 返回指定格式的当前时间字符串
	 * @return yyyyMMddHHmmss
	 */
	public static String getSysTimeForUpload(){

		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");

		Date date = new Date();
		String dateStr = sdf.format(date);

		return dateStr;

	}

	/**
	 * 将指定字符串转换成时间毫秒数
	 * yyyy-MM-dd HH:mm:ss
	 * @return Long
	 */
	public static Long stringToDate(String date) throws ParseException {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		Date parseDate = sdf.parse(date);
		return parseDate.getTime();

	}
}
