package com.finshot.web;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStreamWriter;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.UUID;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.FileSystemResource;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import java.lang.management.ManagementFactory;

@Controller
public class EmployeeController {
	@Autowired
	private JavaMailSender mailSender;
	@Autowired
	private EmployeeService service;
	
	private String sendMail = "parkbk1908@gmail.com";
	
	private String subjectMail = "pbk11908@naver.com";

	@RequestMapping(value = "/list", method = RequestMethod.GET)
	public String showList(Locale locale, Model model, @RequestParam Map<String, Object> param)
			throws MessagingException {
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
		Util.parsDateTime(employees);

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
	public @ResponseBody String AjaxView(@RequestParam("id") int id, @RequestParam Map<String, Object> param) {
		int mainid = Util.getAsInt(param.get("mainid"));
		String str = "YES";
		int idcheck = service.idCheck(id);
		System.out.println("?????????:" + idcheck);
		if (idcheck == 0 || id == mainid) { // ?????? ????????? ??????
			str = "YES";
		} else { // ?????? ???????????? ??????
			str = "NO";
		}
		return str;
	}

	@RequestMapping(value = "/doWrite", method = RequestMethod.POST)
	public String doWrite(Locale locale, Model model, @RequestParam Map<String, Object> param) {
		service.insertEmployee(param);
		model.addAttribute("msg", "?????????????????????.");
		model.addAttribute("replaceUri", String.format("/list"));
		return "redirect";
	}

	@RequestMapping(value = "/doModify", method = RequestMethod.POST)
	public String doModify(Locale locale, Model model, @RequestParam Map<String, Object> param) {
		service.updateEmployee(param);
		model.addAttribute("msg", "?????????????????????.");
		model.addAttribute("replaceUri", String.format("/list"));
		return "redirect";
	}

	@RequestMapping(value = "/doModifyFile")
	public String doModifyFile(Model model, @RequestParam Map<String, Object> param,
			@RequestParam("modify_file") List<MultipartFile> multipartFile,
			@RequestParam(value = "delfile") List<Integer> delfiles) {
		service.modifyFile(param, multipartFile, delfiles);
		model.addAttribute("msg", "????????????s?????????.");
		model.addAttribute("replaceUri", String.format("/list"));
		return "redirect";
	}

	@RequestMapping(value = "/showDetail")
	@ResponseBody
	public Map<String, Object> showDetail(HttpServletResponse response, @RequestParam("id") int id) {
		List<Employee> employee = service.getEmployee(id);
		List<Empfile> empfiles = service.getEmpfile(id);
		Map<String, Object> list = new HashMap<String, Object>();
		list.put("employee", employee);
		list.put("empfiles", empfiles);
		return list;
	}

	@RequestMapping(value = "/doDelete", method = RequestMethod.POST)
	@ResponseBody
	public String doDelete(Locale locale, Model model, @RequestParam Map<String, Object> param,
			@RequestParam(value = "id[]") List<Integer> vals) {
		for (int i = 0; i < vals.size(); i++) {
			service.deleteEmployee(vals.get(i));
		}
		model.addAttribute("msg", "?????????????????????.");
		model.addAttribute("replaceUri", String.format("/list"));
		return "redirect";
	}

	@ResponseBody
	@RequestMapping(value = "/file-upload", method = RequestMethod.POST)
	public String fileUpload(@RequestParam("article_file") List<MultipartFile> multipartFile,
			@RequestParam Map<String, Object> param) {
		String strResult = "{ \"result\":\"FAIL\" }";
		String fileRoot;
		try {
			// ????????? ????????? ??????.
			if (multipartFile.size() > 0 && !multipartFile.get(0).getOriginalFilename().equals("")) {
				int empid = Util.getAsInt(param.get("empid"));
				param.replace("empid", empid);
				for (MultipartFile file : multipartFile) {
					fileRoot = "C://upload/";
					String originalFileName = file.getOriginalFilename(); // ???????????? ?????????
					String savedFileName = UUID.randomUUID().toString();// ????????? ?????? ???

					File targetFile = new File(fileRoot + savedFileName);
					try {
						InputStream fileStream = file.getInputStream();
						FileUtils.copyInputStreamToFile(fileStream, targetFile); // ?????? ??????
						param.put("originalFileName", originalFileName);
						param.put("savedFileName", savedFileName);
						service.insertFile(param);
					} catch (Exception e) {
						// ????????????
						FileUtils.deleteQuietly(targetFile); // ????????? ?????? ?????? ??????
						e.printStackTrace();
						break;
					}
				}
				strResult = "{ \"result\":\"OK\" }";
			}
			// ?????? ???????????? ?????? ???????????? ??????.(???????????????, ????????? ?????? ?????? ??????????????????)
			else
				strResult = "{ \"result\":\"OK\" }";
		} catch (Exception e) {
			e.printStackTrace();
		}
		return strResult;
	}

	@ResponseBody
	@RequestMapping(value = "/fileDownload")
	public void fileDownload(@RequestParam Map<String, Object> param, HttpServletResponse response,
			HttpServletRequest request) throws Exception {
		int fileid = Util.getAsInt(param.get("fileid"));
		param.replace("fileid", fileid);

		Empfile empfile = service.getEmpfilebyFileid(param);

		String storedFileName = empfile.getStored_file_name();
		String originalFileName = empfile.getOrg_file_name();
		byte fileByte[] = FileUtils.readFileToByteArray(new File("C:\\upload\\" + storedFileName));
		response.setContentType("application/octet-stream");
		response.setContentLength(fileByte.length);
		response.setHeader("Content-Disposition",
				"attachment; fileName=\"" + URLEncoder.encode(originalFileName, "UTF-8") + "\";");
		response.setHeader("Content-Transfer-Encoding", "binary");
		response.getOutputStream().write(fileByte);
		response.getOutputStream().flush();
		response.getOutputStream().close();
	}

	@ResponseBody
	@RequestMapping(value = "/sendMail", method = RequestMethod.POST)
	public String sendMail(@RequestParam("id") int id, @RequestParam Map<String, Object> param) {
		String Name = "";
		BufferedWriter bw = null;
		String filePath = "C:/upload";
		String empName = "emp.csv";
		String makePath = filePath + File.separator + empName;
		String NEWLINE = System.lineSeparator(); // ?????????(\n)
		File folder = new File(filePath);
		List<Employee> employee = service.getEmployee(id);

		List<Empfile> empfiles = service.getEmpfile(id);
		MimeMessage message = mailSender.createMimeMessage();
		MimeMessageHelper messageHelper;
		if (!folder.exists()) {
			folder.mkdirs(); // ????????? ???????????? ?????? ??????
		}
		try {
			bw = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(makePath), "MS949"));
			bw.write("????????????, ?????????, ??????, ????????????, ?????????, ?????????");
			bw.write(NEWLINE);
			for (int i = 0; i < employee.size(); i++) {
				Name = employee.get(i).getName();
				bw.write(employee.get(i).getId() + "," + employee.get(i).getName() + "," + 
				employee.get(i).getJob() + "," + employee.get(i).getPhonenumber() + "," + employee.get(i).getEmail() + "," + employee.get(i).getUpdateDate());
				bw.write("\n");
			}
			bw.close();
			messageHelper = new MimeMessageHelper(message, true, "UTF-8");
			messageHelper.setFrom(sendMail); // ??????????????? ??????????????? ?????? ??????????????? ??????
			messageHelper.setTo(subjectMail); // ???????????? ?????????
			messageHelper.setSubject(Name + "???????????? ???????????????."); // ??????????????? ????????? ????????????
			messageHelper.setText(Name + "?????? ????????????, ???????????????."); // ?????? ??????
			File empFile = new File(makePath);
			FileSystemResource efile = new FileSystemResource(empFile);
			messageHelper.addAttachment(empName, efile);
			for(int i=0; i <empfiles.size(); i++) {
				String fileName = empfiles.get(i).getOrg_file_name();
				makePath = filePath + File.separator + empfiles.get(i).getStored_file_name();
				File file = new File(makePath);
				FileSystemResource fileresource = new FileSystemResource(file);
				messageHelper.addAttachment(fileName, fileresource);
			}
			mailSender.send(message);
			empFile.delete();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return "NO";
		}catch (MessagingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return "NO";
		}
		service.addSendnumber(id);
		return "YES";
	}
	
	@Scheduled(cron= "0 0 14 * * ?")
	public void ScheduleMail() {
		String serverstatus = Util.getServerstatus();
		MimeMessage message = mailSender.createMimeMessage();
		MimeMessageHelper messageHelper;
		try {
			messageHelper = new MimeMessageHelper(message, true, "UTF-8");
			messageHelper.setFrom(sendMail);
			messageHelper.setTo(subjectMail); // ???????????? ?????????
			messageHelper.setSubject("?????? ??????"); // ??????????????? ????????? ????????????
			messageHelper.setText(serverstatus); // ?????? ??????
			mailSender.send(message);
		} catch (MessagingException e) {
			e.printStackTrace();
		} // ??????????????? ??????????????? ?????? ??????????????? ??????
	}
}
