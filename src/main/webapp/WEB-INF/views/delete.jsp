<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!-- Modal -->
<div class="modal fade" id="deleteModal" role="dialog">
	<div class="modal-dialog" role="document">
		<form class="modal-content">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalLabel">선택한 직원을 삭제하시겠습니까?</h5>
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">선택직원을 정말 삭제하시겠습니까?</div>
				<div class="modal-footer">
					<button type="button" id="deleteSubmit" class="btn btn-success">예</button>
					<button type="button" class="btn btn-danger" data-dismiss="modal">아니오</button>
				</div>
			</div>
		</form>
	</div>
</div>

<!-- Modal -->
<div class="modal fade" id="checkModal" role="dialog">
	<div class="modal-dialog" role="document">
		<form class="modal-content">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="check-title" id="check-title"></h5>
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-footer">
					<button type="button" id="checkSubmit" class="btn btn-primary">OK</button>
				</div>
			</div>
		</form>
	</div>
</div>