package com.finshot.web;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.experimental.PackagePrivate;

@Data
@NoArgsConstructor
@AllArgsConstructor
@PackagePrivate
public class Employee {
	int id;
	String idt;
	String regDate;
	String updateDate;
	String name;
	String job;
	String phonenumber;
	String email;
}
