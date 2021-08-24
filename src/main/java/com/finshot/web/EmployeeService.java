package com.finshot.web;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.finshot.web.mapper.EmployeeMapper;
import com.finshot.web.mapper.TestMapper;

@Service
public class EmployeeService {	
	@Autowired
	private EmployeeMapper employeeMapper;
	
	public List<Employee> getEmployees() {
		List<Employee> employees = employeeMapper.getEmployees();
		
		for (int i = 0; i < employees.size(); i++) {
			String number = String.format("%03d", employees.get(i).getId());
			employees.get(i).setIdt(number);
		}
		
		return employees;
	}
}
