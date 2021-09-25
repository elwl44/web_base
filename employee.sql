CREATE TABLE employee (
    id int NOT NULL PRIMARY KEY,
    regDate timestamp  NOT NULL,
    updateDate timestamp  NOT NULL,
    name TEXT NOT NULL,
    job TEXT NOT NULL,
	phonenumber TEXT not null,
    email text NOT NULL
    sendMail int NOT NULL DEFAULT 0
);

insert into employee(id, regDate, updateDate, name, job, phonenumber, email)values(2, now(), now(), '박범규2', '대리', '010-5229-5022', 'pbk119082@gmail.com');
