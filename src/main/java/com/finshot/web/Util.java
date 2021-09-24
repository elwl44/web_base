package com.finshot.web;

import java.math.BigInteger;
import java.sql.Date;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.List;
import java.util.Locale;

public class Util {
	public static int getAsInt(Object object) {
		return getAsInt(object, -1);
	}

	public static int getAsInt(Object object, int defaultValue) {
		if (object instanceof BigInteger) {
			return ((BigInteger) object).intValue();
		}
		else if (object instanceof String) {
			return Integer.parseInt((String) object);
		}

		return defaultValue;
	}

	public static void parsDateTime(List<Employee> employees) {
		for (int i=0; i<employees.size(); i++) {
			String strdate = employees.get(i).getUpdateDate();
			Timestamp timestamp = Timestamp.valueOf(strdate);
	        SimpleDateFormat sdf = new SimpleDateFormat( "yyyy-MM-dd" , Locale.KOREA );
	        String datetime = sdf.format( new Date( timestamp.getTime( ) ) );
	        employees.get(i).setUpdateDate(datetime);
		}
	}
}
