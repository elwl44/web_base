<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!-- Modal -->
<div class="modal fade" id="detailModal" role="dialog" >
	<div class="modal-dialog modal-lg">
		<!-- Modal content-->
		<form class="modal-content">
			<input class="form-control" id="detail_main_id" type="hidden">
			<div class="modal-header">
				<h4 id="detail-title" class="modal-title">직원 상세 정보</h4>
				<button type="button" class="close" data-dismiss="modal">&times;</button>
			</div>
			<div class="modal-body">
				<div class="row col-md-12 form-group">
					<label for="id" class="col-md-2">
						<span class="labeltext">직원번호</span>
					</label>
					<div class="col-md-8" style="padding: 0; padding-right: 10px;">
						<span class="" id="detailid"></span>
					</div>
				</div>

				<div class="row col-md-12 form-group">
					<label for="name" class="col-md-2">
						<span class="labeltext">직원명</span>
					</label>
					<div class="col-md-10" style="padding: 0; padding-right: 10px;">
						<span class="" id="detailname"></span>
					</div>
				</div>

				<div class="row col-md-12 form-group">
					<label for="job" class="col-md-2">
						<span class="labeltext">직급</span>
					</label>
					<div class="col-md-10" style="padding: 0; padding-right: 10px;">
						<span class="" id="detailjob"></span>
					</div>
				</div>
				
				<div class="row col-md-12 form-group">
					<label for="phonenumber" class="col-md-2">
						<span class="labeltext">전화번호</span>
					</label>
					<div class="col-md-10" style="padding: 0; padding-right: 10px;">
						<span class="" id="detailphonenumber"></span>
					</div>
				</div>
				
				<div class="row col-md-12 form-group">
					<label for="job" class="col-md-2">
						<span class="labeltext">email</span>
					</label>
					<div class="col-md-10" style="padding: 0; padding-right: 10px;">
						<span class="" id="detailemail"></span>
					</div>
				</div>
				<div class="row col-md-12 form-group">
					<label for="job" class="col-md-2">
						<span class="labeltext">수정일</span>
					</label>
					<div class="col-md-10" style="padding: 0; padding-right: 10px;">
						<span class="" id="detailupdateDate"></span>
					</div>
				</div>
				
				<div class="row col-md-12 form-group">
					<div class="col-md-2">
						<span class="labeltext">첨부 파일</span>
					</div>
					<div id="detailfileChange" class="col-md-8" style="padding: 0; padding-right: 10px;">
					</div>
				</div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
			</div>
		</form>
	</div>
</div>