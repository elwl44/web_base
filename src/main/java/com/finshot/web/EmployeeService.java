package com.finshot.web;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.finshot.web.mapper.EmployeeMapper;
import com.finshot.web.mapper.TestMapper;

@Service
public class EmployeeService {	
	@Autowired
	private EmployeeMapper employeeMapper;
	
	public List<Employee> getEmployees(Map<String, Object> param) {
		int page = Util.getAsInt(param.get("page"), 1);
		
		int itemsCountInAPage = (Integer) param.get("itemsCountInAPage");
		if ( itemsCountInAPage > 100 ) {
			itemsCountInAPage = 100;
		}
		else if ( itemsCountInAPage < 1 ) {
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
}
