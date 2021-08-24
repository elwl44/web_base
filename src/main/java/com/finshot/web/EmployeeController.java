package com.finshot.web;

import java.util.List;
import java.util.Locale;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class EmployeeController {

	@Autowired
	private EmployeeService service;

	@RequestMapping(value = "/list", method = RequestMethod.GET)
	public String showList(Locale locale, Model model) {
		List<Employee> employees = service.getEmployees();
		
		model.addAttribute("employees", employees);
		return "list";
	}
}
