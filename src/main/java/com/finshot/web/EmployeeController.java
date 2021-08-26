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
	public String showList(Locale locale, Model model, @RequestParam Map<String, Object> param) {
		int totalCount = service.getTotalCount(param);
		int itemsCountInAPage = Util.getAsInt(param.get("search_num"), 10);
		
		int totalPage = (int) Math.ceil(totalCount / (double) itemsCountInAPage);

		int pageMenuArmSize = 5;
		int page = Util.getAsInt(param.get("page"), 1);

		int pageMenuStart = page - pageMenuArmSize;
		if (pageMenuStart < 1) {
			pageMenuStart = 1;
		}
		int pageMenuEnd = page + pageMenuArmSize;
		if (pageMenuEnd > totalPage) {
			pageMenuEnd = totalPage;
		}
		param.put("itemsCountInAPage", itemsCountInAPage);

		List<Employee> employees = service.getEmployees(param);
		String searchKeyword = (String) param.get("searchKeyword");
		String search_target = (String) param.get("search_target");
		model.addAttribute("search_target", search_target);
		model.addAttribute("searchKeyword", searchKeyword);
		model.addAttribute("search_num", itemsCountInAPage);
		model.addAttribute("totalCount", totalCount); 
		model.addAttribute("totalPage", totalPage); 
		model.addAttribute("pageMenuArmSize", pageMenuArmSize); 
		model.addAttribute("pageMenuStart", pageMenuStart); 
		model.addAttribute("pageMenuEnd", pageMenuEnd); 
		model.addAttribute("page", page); 
		model.addAttribute("employees", employees);
		return "list";
	}

	@RequestMapping(value = "/checkSignup", method = RequestMethod.POST)
	public @ResponseBody String AjaxView(@RequestParam("id") int id, @RequestParam("mainid") int mainid) {
		String str = "YES";
		int idcheck = service.idCheck(id);
		System.out.println("입력값:" + idcheck);
		if (idcheck == 0 || id == mainid) { // 사용 가능한 계정
			str = "YES";
		} else { // 이미 존재하는 계정
			str = "NO";
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
	
	@RequestMapping(value = "/doModify", method = RequestMethod.POST)
	public String doModify(Locale locale, Model model, @RequestParam Map<String, Object> param) {
		service.updateEmployee(param);
		model.addAttribute("msg", "등록되었습니다.");
		model.addAttribute("replaceUri", String.format("/list"));
		return "redirect";
	}

}
