<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<script type="text/javascript">
	$(document).ready(function() {
		// 모달 열기
		$("#deleteBtn").click(function() {
			if ($('input[name=c1]:checked').length == 0) {
				alert('직원을 선택해주세요.');
				return;
			}

			$("#deleteModal").modal();
		});
		// 등록모달 입력
		$("#deleteSubmit").click(function() {
			var id;
			var arr = [];
			var obj_length = document.getElementsByName("userId").length;
			for (var i = 0; i < obj_length; i++) {
				if (document.getElementsByName("c1")[i].checked == true) {
					arr.push(document.getElementsByName("userId")[i].value);
				}
			}
			console.log(arr.length);
			
			$.ajax({
				type : "POST",
				url : "/doDelete",
				data : {
					"id" : arr
				},
				success : function(data) {
					$("#deleteModal").modal('toggle');
					
				}, complete : function() {		   		
					$("#check-title").text(arr.length+"명의 직원이 삭제되었습니다.");
					$("#checkModal").modal();
		       }
			})
		});

		// 등록모달 입력
		$("#checkSubmit").click(function() {
			location.replace("/list");
		});
	});
</script>
</head>
</html>