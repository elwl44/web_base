<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<script type="text/javascript">
function callFunction(_id) {
	var id;
	var name;
	var job;
	var phonenumber;
	var email;
	var updateDate;
	var empfiles;
	 $.ajax({
       url: "/showDetail",
       type: "get",
       data : {
			"id" : _id
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
	   		$.each( empfiles, function( key, file ){ 
    		    console.log(file.fileid );
    		    $('#detailfileChange').append(
    		       		'<div id="file' + id + '" >'
    		       		+ '<a href="#" style="margin-left: 5px;"'
    		       		+ 'onclick="fileDownload(' +"'" + file.fileid+"'" +')">'+file.org_file_name +'</a>' 
    		       		+ '<div/>'
    				);
    		});
	   	 	
	   		action = 'detail';
	   		type = 'POST'
	   		$("#detailModal").modal();  
       }
	});
}
//파일 부분 다운 함수
function fileDownload(fileid){
	location.href = "/fileDownload?fileid="+fileid;
}
</script>
</head>
</html>