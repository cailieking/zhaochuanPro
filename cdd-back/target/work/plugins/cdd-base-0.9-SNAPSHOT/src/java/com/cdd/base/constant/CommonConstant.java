package com.cdd.base.constant;

import java.util.Calendar;
import java.util.Date;
import java.util.regex.Pattern;


public class CommonConstant {
	public final static String DATE_FORMAT = "yyyy-MM-dd";
	public final static String TIME_FORMAT = "HH:mm:ss";
	public final static String DATE_TIME_FORMAT = "yyyy-MM-dd HH:mm:ss";
	public final static String DATE_TIME_MILLI_FORMAT = "yyyy-MM-dd'T'HH:mm:ss.SSSZ";
	public final static String ENVIRONMENT_UAT = "uat";
	public final static String ENVIRONMENT_DEV = "dev";
	public final static String ENVIRONMENT_PROD = "prod";
	public final static Pattern MOBILE_PATTERN = Pattern.compile("\\d{11}");
	
	public static Date getMaxDate() {
		Calendar now = Calendar.getInstance();
		now.add(Calendar.DATE, 1);
		return now.getTime();
	}
}
