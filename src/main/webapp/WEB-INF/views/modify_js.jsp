<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<script type="text/javascript">
	$(document).ready(function() {
		$("#modify_input_file").on("change", modify_fileCheck);
		// 모달 열기
		$("#modifyBtn").click(function() {
			console.log("수정");
			if ($('input[name=c1]:checked').length == 0) {
				alert('직원을 선택해주세요.');
				return;
			}
			var rowData = new Array();
			var totaldata = new Array();
			var checkbox = $("input[name=c1]:checked");
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
			
			//getfile
			$.ajax({
		       url: "/showDetail",
		       type: "get",
		       data : {
					"id" : id
				},
		       contentType: "application/json; charset=utf-8;",
		       success: function(result){
		    	   empfiles = result.empfiles;
			       	id = result.employee[0].id;
			       	name = result.employee[0].name;
			       	job = result.employee[0].job;
			       	phonenumber = result.employee[0].phonenumber;
			       	email = result.employee[0].email;
			       	updateDate = result.employee[0].updateDate;
		       }, complete : function() {		   		
			   		$("#detailid").text(id);
			   		$("#detailname").text(name);
			   		$("#detailjob").text(job);
			   		$("#detailphonenumber").text(phonenumber);
			   		$("#detailemail").text(email);
			   		$("#detailupdateDate").text(updateDate);
				    console.log(empfiles);
			   		$.each( empfiles, function( key, file ){ //key -> index
		    		    console.log(key );
		    		    modifycontent_files.push(file);
		    		    $('#modifyfileChange').append(
		    		    		'<div id="file' + key + '" >'
		    		       		+ '<font style="font-size:12px">' + file.org_file_name + '</font>'  
		    		       		+ '<a href="#" style="margin-left: 5px; font-size: 12px;"'
		    		       		+ 'onclick="modify_fileDelete(\'file' + key + '\')">삭제</a>' 
		    		       		+ '<div/>'
		    		    );
				    });
		       }
			});
			
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
			
			
			var form = $("form")[0];        
		 	var formData2 = new FormData(form);
		 	var delfile = [];
		 	var fileSize = 0;	
		 	
		 	for (var x = 0; x < modifycontent_files.length; x++) {
				// 삭제 안한것만 담아 준다. 
				if(!modifycontent_files[x].is_delete){
					formData2.append("modify_file", modifycontent_files[x]);
					fileSize++;
				}else{
					delfile.push(modifycontent_files[x].fileid);
				}
			}
		 	
			formData2.append("empid", $("#modifyid").val());
			formData2.append("mainid", $("#modify_main_id").val());
			formData2.append("delfile", delfile);
			
			if (fileSize == 0) {
				alert("1개이상의 파일을 등록해 주세요.");
				return;
			}
			
			var fileSize = 0;			
		   
			$.ajax({
		        type : 'post',
		   	   	enctype: "multipart/form-data",
		        url : '/doModifyFile',
		        data : formData2,
		        processData : false,
		        contentType : false,
		        success : function(data) {
		        },
		        error : function(error) {
		            alert("파일 업로드에 실패하였습니다.");
		        }
		    })
			
			var data = {
					"id" : $("#modifyid").val(),
					"mainid" : $("#modify_main_id").val(),
					"name" : $("#modifyname").val(),
					"job" : $("#modifyjob").val(),
					"phonenumber" : $("#modifyphonenumber").val(),
					"email" : $("#modifyemail").val()
				};
			
			$.ajax({
				url : "doModify",
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
		
		$(function() {
			$('#modify-btn-upload').click(function(e) {
				e.preventDefault();
				$('#modify_input_file').click();
			});
		});
		// 파일 현재 필드 숫자 totalCount랑 비교값
		var fileCount = 0;
		// 해당 숫자를 수정하여 전체 업로드 갯수를 정한다.
		var totalCount = 10;
		// 파일 고유넘버
		var fileNum = 0;
		
		function modify_fileCheck(e) {
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
		    	  modifycontent_files.push(f);
		        $('#modifyfileChange').append(
		       		'<div id="file' + fileNum + '" >'
		       		+ '<font style="font-size:12px">' + f.name + '</font>'  
		       		+ '<a href="#" style="margin-left: 5px; font-size: 12px;"'
		       		+ 'onclick="modify_fileDelete(\'file' + fileNum + '\')">삭제</a>' 
		       		+ '<div/>'
				);
		        fileNum ++;
		      };
		      reader.readAsDataURL(f);
		    });
		    console.log(modifycontent_files);
		    //초기화 한다.
		    $("#modify_input_file").val("");
		  }
	});
</script>
</head>
</html>