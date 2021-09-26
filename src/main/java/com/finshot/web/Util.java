package com.finshot.web;

import java.io.File;
import java.lang.management.ManagementFactory;
import java.math.BigInteger;
import java.net.InetAddress;
import java.net.NetworkInterface;
import java.net.UnknownHostException;
import java.sql.Date;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.List;
import java.util.Locale;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.FileSystemResource;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;

import com.sun.management.OperatingSystemMXBean;

public class Util {
	
	private static OperatingSystemMXBean osBean = (OperatingSystemMXBean) ManagementFactory.getOperatingSystemMXBean();
	
	public static int getAsInt(Object object) {
		return getAsInt(object, -1);
	}

	public static int getAsInt(Object object, int defaultValue) {
		if (object instanceof BigInteger) {
			return ((BigInteger) object).intValue();
		} else if (object instanceof String) {
			return Integer.parseInt((String) object);
		}

		return defaultValue;
	}

	public static void parsDateTime(List<Employee> employees) {
		for (int i = 0; i < employees.size(); i++) {
			String strdate = employees.get(i).getUpdateDate();
			Timestamp timestamp = Timestamp.valueOf(strdate);
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd", Locale.KOREA);
			String datetime = sdf.format(new Date(timestamp.getTime()));
			employees.get(i).setUpdateDate(datetime);
		}
	}

	@SuppressWarnings("deprecation")
	public static String getServerstatus() {
		String status = null;
		String newline = System.getProperty("line.separator");
		try {
			String os ="os: " + System.getProperty("os.name");
			//
			InetAddress local = null;
			try {
				local = InetAddress.getLocalHost();
			}
			catch ( UnknownHostException e ) {
				e.printStackTrace();
			}
			String ip ="ip: " + local.getHostAddress();
			//
			InetAddress ipaddress = InetAddress.getLocalHost();
			NetworkInterface network = NetworkInterface.getByInetAddress(ipaddress);
			byte[] mac = network.getHardwareAddress();
			StringBuilder sb = new StringBuilder();
			for (int i = 0; i < mac.length; i++) {
				sb.append(String.format("%02X%s", mac[i], (i < mac.length - 1) ? "-" : ""));
			}
			String macadress = "macAdress: " + sb.toString();
			//
			
			String cpu = "CPU Usage : " + String.format("%.2f", osBean.getSystemCpuLoad() * 100) + "%";
			String totalMemory = "Memory Total Space : " + String.format("%.2f", (double)osBean.getTotalPhysicalMemorySize()/1024/1024/1024) + "GB";
			String freeMemory = "Memory Free Space : " + String.format("%.2f", (double)osBean.getFreePhysicalMemorySize()/1024/1024/1024) + "GB";
			System.out.println("***********************************************************");
			System.out.println("os : " + os);
			System.out.println("ip : " + ip);
			System.out.println("macAdress : " + macadress);
            System.out.println("CPU Usage : " + String.format("%.2f", osBean.getSystemCpuLoad() * 100) + "%");
            System.out.println("Memory Total Space : " + String.format("%.2f", (double)osBean.getTotalPhysicalMemorySize()/1024/1024/1024) + "GB");
            System.out.println("Memory Free Space : " + String.format("%.2f", (double)osBean.getFreePhysicalMemorySize()/1024/1024/1024) + "GB");
			System.out.println("***********************************************************");
			
			status = os + newline + ip + newline + macadress + newline + cpu + newline + totalMemory + newline + freeMemory;
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return status;
	}
}
