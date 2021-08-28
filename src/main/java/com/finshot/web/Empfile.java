package com.finshot.web;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.experimental.PackagePrivate;

@Data
@NoArgsConstructor
@AllArgsConstructor
@PackagePrivate
public class Empfile {
	int fileid;
	int empid;
	String org_file_name;
	String stored_file_name;
	String regDate;
}
