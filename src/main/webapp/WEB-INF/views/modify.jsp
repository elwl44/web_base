<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!-- Modal -->
<div class="modal fade" id="modifyModal" role="dialog" >
	<div class="modal-dialog modal-lg">
		<!-- Modal content-->
		<form class="modal-content">
			<input class="form-control" id="modify_main_id" type="hidden">
			<div class="modal-header">
				<h4 id="modify-title" class="modal-title">직원 수정</h4>
				<button type="button" class="close" data-dismiss="modal">&times;</button>
			</div>
			<div class="modal-body">
				<div class="row col-md-12 form-group">
					<label for="id" class="col-md-2">
						<span class="labeltext">직원번호</span>
					</label>
					<div class="col-md-8" style="padding: 0; padding-right: 10px;">
						<input class="form-control" id="modifyid" type="text">
					</div>
					<div class="col-md-2" style="padding: 0; padding-right: 10px;">
						<button type="button" class="btn btn-outline-primary act" id="modifyidcheck">중복체크</button>
					</div>
				</div>

				<div class="row col-md-12 form-group">
					<label for="name" class="col-md-2">
						<span class="labeltext">직원명</span>
					</label>
					<div class="col-md-10" style="padding: 0; padding-right: 10px;">
						<input class="form-control" id="modifyname" type="text">
					</div>
				</div>

				<div class="row col-md-12 form-group">
					<label for="job" class="col-md-2">
						<span class="labeltext">직급</span>
					</label>
					<div class="col-md-10" style="padding: 0; padding-right: 10px;">
						<input class="form-control" id="modifyjob" type="text">
					</div>
				</div>
				
				<div class="row col-md-12 form-group">
					<label for="phonenumber" class="col-md-2">
						<span class="labeltext">전화번호</span>
					</label>
					<div class="col-md-10" style="padding: 0; padding-right: 10px;">
						<input class="form-control" id="modifyphonenumber" type="text">
					</div>
				</div>
				
				<div class="row col-md-12 form-group">
					<label for="job" class="col-md-2">
						<span class="labeltext">email</span>
					</label>
					<div class="col-md-10" style="padding: 0; padding-right: 10px;">
						<input class="form-control" id="modifyemail" type="email">
					</div>
				</div>
			</div>
			<div class="modal-footer">
				<button id="modifySubmit" type="button" class="btn btn-success">등록</button>
				<button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
			</div>
		</form>
	</div>
</div>