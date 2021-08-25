package com.finshot.web.mapper;

import java.util.List;
import java.util.Map;

import com.finshot.web.Employee;

public interface EmployeeMapper {

	List<Employee> getEmployees();

	int idCheck(int id);

	void insertEmployee(Map<String, Object> param);

}
