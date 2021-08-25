package com.finshot.web;

import java.util.List;
import java.util.Locale;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

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
	
	@RequestMapping(value = "/checkSignup", method = RequestMethod.POST)
	public @ResponseBody String AjaxView(  
		        @RequestParam("id") int id){
		String str = "YES";
		int idcheck = service.idCheck(id);
		System.out.println("입력값:"+idcheck);
		if(idcheck==1){ //이미 존재하는 계정
			str = "NO";	
		}else{	//사용 가능한 계정
			str = "YES";	
		}
		return str;
	}
	
	@RequestMapping(value = "/doWrite", method = RequestMethod.POST)
	public String doWrite(Locale locale, Model model, @RequestParam Map<String, Object> param) {
		service.insertEmployee(param);
		model.addAttribute("msg", "등록되었습니다.");
		model.addAttribute("replaceUri", String.format("/list"));
		return "redirect";
	}
	
	
}
