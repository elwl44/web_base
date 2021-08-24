<!DOCTYPE html>
<html>
<head>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<meta charset="utf-8">
<script src="/resources/js/jquery-3.5.1.js"></script>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap-theme.min.css">

<!-- 합쳐지고 최소화된 최신 자바스크립트 -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"></script>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>직원 목록</title>
</head>
<body>
	<h1 class="text-center">직원 목록</h1>
	<div class="row">
		<div class="col-md-6">
			<button type="button" class="btn btn-outline-primary show">Link</button>
			<button type="button" class="btn btn-outline-primary show">Link</button>
			<button type="button" class="btn btn-outline-primary show">Link</button>
		</div>
		<div class="col-md-6">
			<form class="form-inline float-right">
				<div class="form-group">
					<select class="mb-3 form-control" name="search_num">
						<option value="5">5개씩보기</option>
						<option value="10">10개씩보기</option>
						<option value="15">15개씩보기</option>
						<option value="20">20개씩보기</option>
						<option value="50">50개씩보기</option>
					</select>
					<select class="mb-3 form-control" name="search_target">
						<option value="name">직원명</option>
						<option value="id">직원번호</option>
						<option value="job">직급</option>
						<option value="email">이메일</option>
						<option value="updateDate">수정일시</option>
					</select>
					<input type="text" class="form-control align-self-sm-baseline" name="searchKeyword" value="${searchKeyword }">
					<button type="submit" class="btn btn-primary align-self-sm-baseline">검색</button>
				</div>
			</form>
		</div>
	</div>
	<div class="row">
		<table class="table table-striped text-center" id="example-table-1">
			<thead>
				<tr>
					<th scope="col">선택</th>
					<th scope="col">직원번호</th>
					<th scope="col">직원명</th>
					<th scope="col">직급</th>
					<th scope="col">전화번호</th>
					<th scope="col">이메일</th>
					<th scope="col">수정일</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${employees}" var="article">
					<input type="hidden" name="userId" id="userId" value="${article.id}" class="" />
					<tr data-id="${article.id }">
						<th scope="row"><input type="checkbox" name="c1" id="c1" title="선택" class="check _checkMember" value="${article.id }" data-manager="true"
								data-staff="false"></th>
						<td>${article.idt }</td>
						<td>${article.name }</td>
						<td>${article.job }</td>
						<td>${article.phonenumber }</td>
						<td>${article.email }</td>
						<td>${article.updateDate}</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>
</body>
</html>