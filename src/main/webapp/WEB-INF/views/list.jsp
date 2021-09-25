<!DOCTYPE html>
<html>
<head>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<meta charset="utf-8">
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<!-- 합쳐지고 최소화된 최신 자바스크립트 -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"></script>
<jsp:include page="modal.jsp" />
<jsp:include page="modify.jsp" />
<jsp:include page="delete.jsp" />
<jsp:include page="detail.jsp" />
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>직원 목록</title>
<script type="text/javascript">
	$(document).ready(function() {
		//페이징 개수 selected
		if(${search_num} == 5){
			$('#search_num option[value=${search_num}]').attr('selected','selected');
		}else if(${search_num} == 10){
			$('#search_num option[value=${search_num}]').attr('selected','selected');
		}else if(${search_num} == 15){
			$('#search_num option[value=${search_num}]').attr('selected','selected');
		}else if(${search_num} == 20){
			$('#search_num option[value=${search_num}]').attr('selected','selected');
		}else if(${search_num} == 50){
			$('#search_num option[value=${search_num}]').attr('selected','selected');
		}
		var target= '${search_target}';
		//직업 selected
		if(target == "name"){
			$('#search_target option[value=name]').attr('selected','selected');
		}else if(target == "id"){
			$('#search_target option[value=id]').attr('selected','selected');
		}else if(target == "job"){
			$('#search_target option[value=job]').attr('selected','selected');
		}else if(target == "email"){
			$('#search_target option[value=email]').attr('selected','selected');
		}else if(target == "updateDate"){
			$('#search_target option[value=updateDate]').attr('selected','selected');
		}
		$('#update input').on('click', function() {
			var currentRow=$(this).closest('tr');
			var col1 = currentRow.find('td:eq(0)').text();
			$.ajax({
				type : "POST",
				url : "sendMail",
				data : {
					"id" : col1
				},
				success : function(data) { //data : checkSignup에서 넘겨준 결과값
					if ($.trim(data) == "YES") {
						alert("발송이 완료되었습니다.")
					}
					else{
						alert("발송이 실패했습니다.")						
					}
				}
			})
		});
	});
</script>
<%@include file="write_js.jsp"%>
<%@include file="delete_js.jsp"%>
<%@include file="detail_js.jsp"%>
<%@include file="modify_js.jsp"%>
</head>
<body>

	<h1 class="text-center">직원 목록</h1>
	<div class="row">
		<div class="col-md-6">
			<button type="button" class="btn btn-outline-primary show" id="createBtn" data-toggle="modal">등록</button>
			<button type="button" class="btn btn-outline-primary show" id="modifyBtn" data-toggle="modify">수정</button>
			<button type="button" class="btn btn-outline-primary show" id="deleteBtn" data-toggle="delete">삭제</button>
		</div>
		<div class="col-md-6">
			<form class="form-inline float-right">
				<div class="form-group">
					<select class="mb-3 form-control" name="search_num" id="search_num">
						<option value="5">5개씩보기</option>
						<option value="10" selected="selected">10개씩보기</option>
						<option value="15">15개씩보기</option>
						<option value="20">20개씩보기</option>
						<option value="50">50개씩보기</option>
					</select>
					<select class="mb-3 form-control" name="search_target" id="search_target">
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
					<th scope="col">직원정보 메일발송</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${employees}" var="article">
					<input type="hidden" name="userId" id="userId" value="${article.id}" class="" />
					<tr data-id="${article.id }">
						<th scope="row">
							<input type="checkbox" name="c1" id="c1" title="선택" class="check _checkMember" value="${article.id }" data-manager="true" data-staff="false">
						</th>
						<td>${article.idt }</td>
						<td>
							<a href="javascript:void(0);" onclick="callFunction(${article.id});">${article.name }</a>
						</td>
						<td>${article.job }</td>
						<td>${article.phonenumber }</td>
						<td>${article.email }</td>
						<td>${article.updateDate}</td>						
						<td id="update"><input type="button" class="btn btn-outline-primary show" name="mailBtn" id = "mailBtn" value="메일발송하기"></td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>
	<div class="row">
		<div class="col-md-1">
			<span class="float-sm-left">총 ${totalCount } 건</span>
		</div>
		<div class="col-md-10">
			<nav aria-label="Page navigation example">
				<ul class="pagination" style="justify-content: center;">
					<li class="page-item">
						<a class="page-link" href="?page=1&search_num=${search_num }&search_target=${search_target}&searchKeyword=${param.searchKeyword}" aria-label="Previous">
							<span aria-hidden="true">&laquo;</span>
							<span class="sr-only">Previous</span>
						</a>
					</li>

					<c:forEach var="i" begin="${pageMenuStart}" end="${pageMenuEnd}">
						<li class="page-item <c:out value="${page == i ? 'active' : ''}"/> ">
							<a class="page-link" href="?page=${i}&search_num=${search_num }&search_target=${search_target}&searchKeyword=${param.searchKeyword}">${i}</a>
						</li>
					</c:forEach>

					<li class="page-item">
						<a class="page-link" href="?page=${totalPage}&search_num=${search_num }&search_target=${search_target}&searchKeyword=${param.searchKeyword}" aria-label="Next">
							<span aria-hidden="true">&raquo;</span>
							<span class="sr-only">Next</span>
						</a>
					</li>
				</ul>
			</nav>
		</div>
		<div class="col-md-1 float-right">
			<span class="float-sm-right">${page }/${totalPage }페이지</span>
		</div>
	</div>
</body>
</html>