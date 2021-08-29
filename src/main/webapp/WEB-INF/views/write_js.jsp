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
		$("#input_file").on("change", fileCheck);
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
		var checked = false;
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
			var empid = $("#id").val();
			var form = $("form")[0];        
		 	var formData = new FormData(form);
			var fileSize = 0;
			for (var x = 0; x < content_files.length; x++) {
				// 삭제 안한것만 담아 준다. 
				if(!content_files[x].is_delete){
					formData.append("article_file", content_files[x]);
					formData.append("empid", empid);
					fileSize++;
				}
			}
			if (fileSize == 0) {
				alert("1개이상의 파일을 등록해 주세요.");
				return;
			}
		   /*
		   * 파일업로드 multiple ajax처리
		   */
		  
			$.ajax({
		   	      type: "POST",
		   	   	  enctype: "multipart/form-data",
		   	      url: "/file-upload",
		       	  data : formData,
		       	  processData: false,
		   	      contentType: false,
		   	      success: function (data) {
		   	    	if(JSON.parse(data)['result'] == "OK"){
					} else
						alert("서버내 오류로 처리가 지연되고있습니다. 잠시 후 다시 시도해주세요");
		   	      },
		   	      error: function (xhr, status, error) {
		   	    	alert("서버오류로 지연되고있습니다. 잠시 후 다시 시도해주시기 바랍니다.");
		   	     	return false;
		   	      }, complete : function() {		   
		   	    	  
		       	  }
		   	    });
		   
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
			$("#detailfileChange").empty();
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
	$(function() {
		$('#btn-upload').click(function(e) {
			e.preventDefault();
			$('#input_file').click();
		});
	});
	
	// 파일 현재 필드 숫자 totalCount랑 비교값
	var fileCount = 0;
	// 해당 숫자를 수정하여 전체 업로드 갯수를 정한다.
	var totalCount = 10;
	// 파일 고유넘버
	var fileNum = 0;
	// 첨부파일 배열
	var content_files = new Array();

	function fileCheck(e) {
	    var files = e.target.files;
	    
	    // 파일 배열 담기
	    var filesArr = Array.prototype.slice.call(files);
	    
	    // 파일 개수 확인 및 제한
	    if (fileCount + filesArr.length > totalCount) {
	      alert('파일은 최대 '+totalCount+'개까지 업로드 할 수 있습니다.');
	      return;
	    } else {
	    	 fileCount = fileCount + filesArr.length;
	    }
	    
	    // 각각의 파일 배열담기 및 기타
	    filesArr.forEach(function (f) {
	      var reader = new FileReader();
	      reader.onload = function (e) {
	        content_files.push(f);
	        $('#articlefileChange').append(
	       		'<div id="file' + fileNum + '" >'
	       		+ '<font style="font-size:12px">' + f.name + '</font>'  
	       		+ '<a href="#" style="margin-left: 5px; font-size: 12px;"'
	       		+ 'onclick="fileDelete(\'file' + fileNum + '\')">삭제</a>' 
	       		+ '<div/>'
			);
	        fileNum ++;
	      };
	      reader.readAsDataURL(f);
	    });
	    console.log(content_files);
	    //초기화 한다.
	    $("#input_file").val("");
	  }
	
	// 파일 부분 삭제 함수
	function fileDelete(fileNum){
	    var no = fileNum.replace(/[^0-9]/g, "");
	    content_files[no].is_delete = true;
		$('#' + fileNum).remove();
		fileCount --;
	    console.log(content_files);
	}

</script>
</head>
</html>