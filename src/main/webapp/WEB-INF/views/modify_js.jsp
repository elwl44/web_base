<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<script type="text/javascript">
	$(document).ready(function() {
		// 모달 열기
		$("#modifyBtn").click(function() {
			console.log("수정");
			var rowData = new Array();
			var totaldata = new Array();
			var checkbox = $("input[name=c1]:checked");
			// 체크된 체크박스 값을 가져온다
			/*
			checkbox.each(function(i) {
				var tdArr = new Array();
			
				// checkbox.parent() : checkbox의 부모는 <td>이다.
				// checkbox.parent().parent() : <td>의 부모이므로 <tr>이다.
				var tr = checkbox.parent().parent().eq(i);
				var td = tr.children();
				
				// 체크된 row의 모든 값을 배열에 담는다.
				rowData.push(tr.text());
				
				// td.eq(0)은 체크박스 이므로  td.eq(1)의 값부터 가져온다.
				var id = td.eq(1).text();
				var name = td.eq(2).text();
				var job = td.eq(3).text();
				var phonenumber = td.eq(4).text();
				var email = td.eq(5).text();
				var updateDate = td.eq(6).text();
				// 가져온 값을 배열에 담는다.
				tdArr.push(id);
				tdArr.push(name);
				tdArr.push(job);
				tdArr.push(phonenumber);
				tdArr.push(email);
				tdArr.push(updateDate);
				totaldata.push(tdArr);
			});
			 */
			var idx = $("input:checkbox[name=c1]:checked").length - 1
			var tr = checkbox.parent().parent().eq(idx);
			var td = tr.children();
			var id = td.eq(1).text();
			var name = td.eq(2).text();
			var job = td.eq(3).text();
			var phonenumber = td.eq(4).text();
			var email = td.eq(5).text();
			var updateDate = td.eq(6).text();
			name = name.trim();
			$("#modify_main_id").val(id);
			$("#modifyid").val(id);
			$("#modifyname").val(name);
			$("#modifyjob").val(job);
			$("#modifyphonenumber").val(phonenumber);
			$("#modifyemail").val(email);
			//test
			action = 'modify';
			type = 'POST'
			$("#modifyModal").modal();
		});

		// 중복체크 클릭
		$("#modifyidcheck").click(function() {
			$("#id").val($("#id").val().trim());
			if ($("#modifyid").val().length == 0) {
				alert('직원번호를 입력해주세요.');
				$("modify#id").focus();
				return;
			}

			$.ajax({
				type : "POST",
				url : "checkSignup",
				data : {
					"id" : $("#modifyid").val(),
					"mainid" : $("#modify_main_id").val()
				},
				success : function(data) { //data : checkSignup에서 넘겨준 결과값
					if ($.trim(data) == "YES") {
						if ($('#modifyid').val() != '') {
							var message = "사용가능한 직원번호 입니다. 사용하시겠습니까?";
							result = window.confirm(message);
							if (result) { //수락버튼
								$("#modifyid").attr('disabled', true);
								$("#modifyidcheck").removeClass("act");
								$("#modifyidcheck").attr('disabled', true);
							} else { //취소버튼
								$("#modifyid").focus();
								return;
							}
						}
					} else {
						if ($('#modifyid').val() != '') {
							alert("중복된 직원번호입니다.");
							$('#modifyid').focus();
						}
					}
				},
				error : function(error) {
					alert("숫자를 입력해주세요.");
					$('#modifyid').val('');
					$('#modifyid').focus();
				}
			})
		});

		// 등록모달 입력
		$("#modifySubmit").click(function() {
			if ($("#modifyidcheck").is(".act")) {
				alert('직원번호를 중복체크 해주세요.');
				$("#modifyid").focus();
				return;
			}
			$("#modifyid").val($("#modifyid").val().trim());
			if ($("#modifyid").val().length == 0) {
				alert('직원번호를 입력해주세요.');
				$("#modifyid").focus();
				return;
			}

			$("#modifyname").val($("#modifyname").val().trim());
			if ($("#modifyname").val().length == 0) {
				alert('이름을 입력해주세요.');
				$("#modifyname").focus();
				return;
			}

			if (!isName($("#modifyname").val())) {
				alert("형식에 맞지 않는 이름입니다.");
				$("#modifyname").focus();
				return;
			}

			$("#modifyjob").val($("#modifyjob").val().trim());
			if ($("#modifyjob").val().length == 0) {
				alert('직급을 입력해주세요.');
				$("#modifyjob").focus();
				return;
			}

			$("#modifyphonenumber").val($("#modifyphonenumber").val().trim());
			if ($("#modifyphonenumber").val().length == 0) {
				alert('전화번호를 입력해주세요.');
				$("#modifyphonenumber").focus();
				return;
			}

			if (!isCelluar($("#modifyphonenumber").val())) {
				alert("형식에 맞지 않는 번호입니다.");
				$("#modifyphonenumber").focus();
				return;
			}

			$("#modifyemail").val($("#modifyemail").val().trim());
			if ($("#modifyemail").val().length == 0) {
				alert('이메일을 입력해주세요.');
				$("#modifyemail").focus();
				return;
			}

			if (!isEmail($("#modifyemail").val())) {
				alert("형식에 맞지 않는 이메일입니다.");
				$("#modifyemail").focus();
				return;
			}

			url = '/doModify';

			var data = {
				"id" : $("#modifyid").val(),
				"mainid" : $("#modify_main_id").val(),
				"name" : $("#modifyname").val(),
				"job" : $("#modifyjob").val(),
				"phonenumber" : $("#modifyphonenumber").val(),
				"email" : $("#modifyemail").val()
			};

			$.ajax({
				url : url,
				type : type,
				data : data,
				success : function(data) {
					$("#modify").modal('toggle');
					location.replace("/list");
				}
			})
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