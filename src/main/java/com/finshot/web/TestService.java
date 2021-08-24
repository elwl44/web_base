package com.finshot.web;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.finshot.web.mapper.TestMapper;

@Service
public class TestService {
	
	@Autowired
	private TestMapper mapper;
	
	public int test() {
		return mapper.test();
	}

}
