package com.finshot.web;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.apache.commons.io.FileUtils;
import org.codehaus.jackson.JsonParseException;
import org.codehaus.jackson.map.JsonMappingException;
import org.codehaus.jackson.map.ObjectMapper;
import org.codehaus.jackson.type.TypeReference;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

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
		deleteFileByEmpid(id);
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

	public void deleteFileByEmpid(int empid) {

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
	
	public void deleteFileByFileid(int fileid) {
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("fileid", fileid);
		Empfile empfile = employeeMapper.getEmpfilebyFileid(param);
		// 파일 경로 지정
		String path = "C://upload";
		File file = new File(path + "//" + empfile.stored_file_name);

		if (file.exists()) { // 파일이 존재하면
			file.delete(); // 파일 삭제
		}
	}

	public void modifyFile(Map<String, Object> param, List<MultipartFile> multipartFile, List<Integer> delfiles) {
		//삭제된 파일 폴더, DB에서 삭제
		for (int i = 0; i < delfiles.size(); i++) {
			deleteFileByFileid(delfiles.get(i));
			employeeMapper.deleteEmpfileByFileid(delfiles.get(i));
		}
		
		//추가된 파일 업로드
		fileUpload(multipartFile, param);
		
		int empid = Util.getAsInt(param.get("empid"));
		param.replace("empid", empid);
		int mainid = Util.getAsInt(param.get("mainid"));
		param.replace("mainid", mainid);
		if(empid != mainid) {
			employeeMapper.updateEmpfile(param);			
		}
	}
	
	public void fileUpload(List<MultipartFile> multipartFile, Map<String, Object> param) {
		String fileRoot;
		try {
			// 파일이 있을때 탄다.
			if (multipartFile.size() > 0 && !multipartFile.get(0).getOriginalFilename().equals("")) {
				int empid = Util.getAsInt(param.get("empid"));
				param.replace("empid", empid);
				for (MultipartFile file : multipartFile) {
					fileRoot = "C://upload/";
					String originalFileName = file.getOriginalFilename(); // 오리지날 파일명
					String savedFileName = UUID.randomUUID().toString();// 저장될 파일 명

					File targetFile = new File(fileRoot + savedFileName);
					try {
						InputStream fileStream = file.getInputStream();
						FileUtils.copyInputStreamToFile(fileStream, targetFile); // 파일 저장
						param.put("originalFileName", originalFileName);
						param.put("savedFileName", savedFileName);
						insertFile(param);
					} catch (Exception e) {
						// 파일삭제
						FileUtils.deleteQuietly(targetFile); // 저장된 현재 파일 삭제
						e.printStackTrace();
						break;
					}
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
