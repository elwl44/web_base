package com.finshot.web.mapper;

import java.util.List;
import java.util.Map;

import com.finshot.web.Empfile;
import com.finshot.web.Employee;

public interface EmployeeMapper {

	List<Employee> getEmployees(Map<String, Object> param);

	int idCheck(int id);

	void insertEmployee(Map<String, Object> param);

	int getTotalCount(Map<String, Object> param);

	void updateEmployee(Map<String, Object> param);

	List<Employee> getEmployee(int id);

	void deleteEmployee(int id);

	void insertFile(Map<String, Object> param);

	List<Empfile> getEmpfile(int id);

	Empfile getEmpfilebyFileid(Map<String, Object> param);

	void deleteEmpfile(int id);

}
