package com.finshot.web;

import java.io.File;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.finshot.web.mapper.EmployeeMapper;

@Service
public class EmployeeService {
	@Autowired
	private EmployeeMapper employeeMapper;

	public List<Employee> getEmployees(Map<String, Object> param) {
		int page = Util.getAsInt(param.get("page"), 1);

		int itemsCountInAPage = (Integer) param.get("itemsCountInAPage");
		if (itemsCountInAPage > 100) {
			itemsCountInAPage = 100;
		} else if (itemsCountInAPage < 1) {
			itemsCountInAPage = 1;
		}

		int limitFrom = (page - 1) * itemsCountInAPage;
		int limitTake = itemsCountInAPage;

		param.put("limitFrom", limitFrom);
		param.put("limitTake", limitTake);

		List<Employee> employees = employeeMapper.getEmployees(param);

		for (int i = 0; i < employees.size(); i++) {
			String number = String.format("%03d", employees.get(i).getId());
			employees.get(i).setIdt(number);
		}

		return employees;
	}

	public int idCheck(int id) {
		return employeeMapper.idCheck(id);
	}

	public void insertEmployee(Map<String, Object> param) {
		int id = Util.getAsInt(param.get("id"));
		param.replace("id", id);
		employeeMapper.insertEmployee(param);
	}

	public int getTotalCount(Map<String, Object> param) {
		return employeeMapper.getTotalCount(param);
	}

	public void updateEmployee(Map<String, Object> param) {
		int id = Util.getAsInt(param.get("id"));
		param.replace("id", id);
		int mainid = Util.getAsInt(param.get("mainid"));
		param.replace("mainid", mainid);
		employeeMapper.updateEmployee(param);
	}

	public List<Employee> getEmployee(int id) {
		return employeeMapper.getEmployee(id);
	}

	public void deleteEmployee(int id) {
		employeeMapper.deleteEmployee(id);
		deleteFile(id);
		employeeMapper.deleteEmpfile(id);
	}

	public void insertFile(Map<String, Object> param) {
		employeeMapper.insertFile(param);
	}

	public List<Empfile> getEmpfile(int id) {
		return employeeMapper.getEmpfile(id);
	}

	public Empfile getEmpfilebyFileid(Map<String, Object> param) {
		return employeeMapper.getEmpfilebyFileid(param);
	}

	public void deleteFile(int empid) {

		List<Empfile> empfiles = employeeMapper.getEmpfile(empid);
		// 파일 경로 지정
		String path = "C://upload";
		for (Empfile empfile : empfiles) {
			File file = new File(path + "//" + empfile.stored_file_name);

			if (file.exists()) { // 파일이 존재하면
				file.delete(); // 파일 삭제
			}
		}
	}
}
