<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!-- Modal -->
<div class="modal fade" id="myModal" role="dialog">
	<div class="modal-dialog modal-lg">
		<!-- Modal content-->
		<form class="modal-content">
			<div class="modal-header">
				<h4 id="modal-title" class="modal-title">직원 등록</h4>
				<button type="button" class="close" data-dismiss="modal">&times;</button>
			</div>
			<div class="modal-body">
				<div class="row col-md-12 form-group">
					<label for="id" class="col-md-2">
						<span class="labeltext">직원번호</span>
					</label>
					<div class="col-md-8" style="padding: 0; padding-right: 10px;">
						<input class="form-control" id="id" type="text">
					</div>
					<div class="col-md-2" style="padding: 0; padding-right: 10px;">
						<button type="button" class="btn btn-outline-primary act" id="idcheck">중복체크</button>
					</div>
				</div>

				<div class="row col-md-12 form-group">
					<label for="name" class="col-md-2">
						<span class="labeltext">직원명</span>
					</label>
					<div class="col-md-10" style="padding: 0; padding-right: 10px;">
						<input class="form-control" id="name" type="text">
					</div>
				</div>

				<div class="row col-md-12 form-group">
					<label for="job" class="col-md-2">
						<span class="labeltext">직급</span>
					</label>
					<div class="col-md-10" style="padding: 0; padding-right: 10px;">
						<input class="form-control" id="job" type="text">
					</div>
				</div>

				<div class="row col-md-12 form-group">
					<label for="phonenumber" class="col-md-2">
						<span class="labeltext">전화번호</span>
					</label>
					<div class="col-md-10" style="padding: 0; padding-right: 10px;">
						<input class="form-control" id="phonenumber" type="text">
					</div>
				</div>

				<div class="row col-md-12 form-group">
					<label for="job" class="col-md-2">
						<span class="labeltext">email</span>
					</label>
					<div class="col-md-10" style="padding: 0; padding-right: 10px;">
						<input class="form-control" id="email" type="email">
					</div>
				</div>
				<div class="row col-md-12 form-group">
					<div class="col-md-2">
						<span class="labeltext">파일 업로드</span>
					</div>
					<div class="col-md-10" style="padding: 0; padding-right: 10px;">
						<button id="btn-upload" type="button" style="border: 1px solid #ddd; outline: none;">파일 추가</button>
						<input id="input_file" multiple="multiple" type="file" style="display: none;">
						<span style="font-size: 10px; color: gray;">※첨부파일은 최대 10개까지 등록이 가능합니다.</span>
					</div>
				</div>
				<div class="row col-md-12 form-group">
					<div class="col-md-2">
						<span class="labeltext">첨부 파일</span>
					</div>
					<div id="articlefileChange" class="col-md-8" style="padding: 0; padding-right: 10px;">
						
					</div>
				</div>
			</div>
			<div class="modal-footer">
				<button id="modalSubmit" type="button" class="btn btn-success">등록</button>
				<button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
			</div>
		</form>
	</div>
</div>