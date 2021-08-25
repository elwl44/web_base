<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<script>
var msg = '${msg}';
msg = msg.trim();
if ( msg.length > 0 ) {
	alert(msg);
}
var historyBack = '${historyBack}' == 'true';
if ( historyBack ) {
	history.back();
}
var replaceUri = '${replaceUri}';
replaceUri = replaceUri.trim();
console.log(replaceUri);
if ( replaceUri ) {
	location.replace(replaceUri);
}
var selfclose='${popup_close}'
	selfclose = selfclose.trim();
if ( selfclose ) {
	self.close();
}
</script>