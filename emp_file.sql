CREATE SEQUENCE file_sequence START 1;
create table emp_file(
	fileid int NOT NULL PRIMARY KEY default nextval('file_sequence'),
	empid int not null,
	org_file_name  text not null,
	stored_file_name text not null,
    regDate timestamp  NOT NULL
	
);