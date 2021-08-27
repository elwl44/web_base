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
	 $.ajax({
       url: "/test",
       type: "get",
       data : {
			"id" : _id
		},
       contentType: "application/json; charset=utf-8;",
       success: function(result){
	       	console.log(result);
	       	id = result[0].id;
	       	name = result[0].name;
	       	job = result[0].job;
	       	phonenumber = result[0].phonenumber;
	       	email = result[0].email;
	       	updateDate = result[0].updateDate;
       }, complete : function() {		   		
	   		$("#detailid").text(id);
	   		$("#detailname").text(name);
	   		$("#detailjob").text(job);
	   		$("#detailphonenumber").text(phonenumber);
	   		$("#detailemail").text(email);
	   		$("#detailupdateDate").text(updateDate);
	   		action = 'detail';
	   		type = 'POST'
	   		$("#detailModal").modal();  
       }
	});
}
</script>
</head>
</html>