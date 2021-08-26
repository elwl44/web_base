<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<script type="text/javascript">
	var action = '';
	var url = '';
	var type = '';

	$(document).ready(function() {
		// 모달 열기
		$("#createBtn").click(function() {
			action = 'create';
			type = 'POST'
			$("#myModal").modal();
		});

		// 중복체크 클릭
		$("#idcheck").click(function() {
			$("#id").val($("#id").val().trim());
			if ($("#id").val().length == 0) {
				alert('직원번호를 입력해주세요.');
				$("#id").focus();
				return;
			}

			$.ajax({
				type : "POST",
				url : "checkSignup",
				data : {
					"id" : $("#id").val()
				},
				success : function(data) { //data : checkSignup에서 넘겨준 결과값
					if ($.trim(data) == "YES") {
						if ($('#id').val() != '') {
							var message = "사용가능한 직원번호 입니다. 사용하시겠습니까?";
							result = window.confirm(message);
							if (result) { //수락버튼
								$("#id").attr('disabled', true);
								$("#idcheck").removeClass("act");
								$("#idcheck").attr('disabled', true);
							} else { //취소버튼
								$("#id").focus();
								return;
							}
						}
					} else {
						if ($('#id').val() != '') {
							alert("중복된 직원번호입니다.");
							$('#id').val('');
							$('#id').focus();
						}
					}
				},
				error : function(error) {
					alert("숫자를 입력해주세요.");
					$('#id').val('');
					$('#id').focus();
				}
			})
		});

		// 등록모달 입력
		$("#modalSubmit").click(function() {
			if ($("#idcheck").is(".act")) {
				alert('직원번호를 중복체크 해주세요.');
				$("#id").focus();
				return;
			}
			$("#id").val($("#id").val().trim());
			if ($("#id").val().length == 0) {
				alert('직원번호를 입력해주세요.');
				$("#id").focus();
				return;
			}

			$("#name").val($("#name").val().trim());
			if ($("#name").val().length == 0) {
				alert('이름을 입력해주세요.');
				$("#name").focus();
				return;
			}

			if (!isName($("#name").val())) {
				alert("형식에 맞지 않는 이름입니다.");
				$("#name").focus();
				return;
			}

			$("#job").val($("#job").val().trim());
			if ($("#job").val().length == 0) {
				alert('직급을 입력해주세요.');
				$("#job").focus();
				return;
			}

			$("#phonenumber").val($("#phonenumber").val().trim());
			if ($("#phonenumber").val().length == 0) {
				alert('전화번호를 입력해주세요.');
				$("#phonenumber").focus();
				return;
			}

			if (!isCelluar($("#phonenumber").val())) {
				alert("형식에 맞지 않는 번호입니다.");
				$("#phonenumber").focus();
				return;
			}

			$("#email").val($("#email").val().trim());
			if ($("#email").val().length == 0) {
				alert('이메일을 입력해주세요.');
				$("#email").focus();
				return;
			}

			if (!isEmail($("#email").val())) {
				alert("형식에 맞지 않는 이메일입니다.");
				$("#email").focus();
				return;
			}

			if (action == 'create') {
				url = '/doWrite';
			}

			var data = {
				"id" : $("#id").val(),
				"name" : $("#name").val(),
				"job" : $("#job").val(),
				"phonenumber" : $("#phonenumber").val(),
				"email" : $("#email").val()
			};
			$.ajax({
				url : url,
				type : type,
				data : data,
				success : function(data) {
					$("#myModal").modal('toggle');
					location.replace("/list");
				}
			})
		});

		//등록 모달 종료 이벤트
		$('.modal').on('hidden.bs.modal', function(e) {
			console.log('modal close');
			$("#id").val("");
			$("#name").val("");
			$("#job").val("");
			$("#phonenumber").val("");
			$("#email").val("");
			$("#id").attr('disabled', false);
			$("#idcheck").addClass("act");
			$("#idcheck").attr('disabled', false);
			$("#modifyid").attr('disabled', false);
			$("#modifyidcheck").addClass("act");
			$("#modifyidcheck").attr('disabled', false);
		});

		// 핸드폰 번호 체크 정규식

		function isCelluar(asValue) {
			var regExp = /^01(?:0|1|[6-9])-(?:\d{3}|\d{4})-\d{4}$/;
			return regExp.test(asValue); // 형식에 맞는 경우 true 리턴
		}

		function isEmail(asValue) {
			var regExp = /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$/;
			return regExp.test(asValue); // 형식에 맞는 경우 true 리턴	
		}

		function isName(asValue) {
			var regExp = /[a-zA-Zㄱ-힣]{1,10}/;
			return regExp.test(asValue); // 형식에 맞는 경우 true 리턴	
		}
	});
</script>
</head>
</html>