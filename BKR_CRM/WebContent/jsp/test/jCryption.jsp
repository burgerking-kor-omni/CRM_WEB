<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<html>
<head>
<title>Login form</title>
</head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">

<script src="/uxl/ext/jquery/jquery-1.8.3.min.js" type="text/javascript"></script>
<script type="text/javascript" src="/uxl/ext/jcryption/jquery.jcryption-1.1.js"></script>	
	
<script type="text/javascript">
$(document).ready(function() {
	var $statusText = $('<span id="status"></span>').hide();
    $("#status_container").append($statusText);
    $("#lf").jCryption({ 
    	getKeysURL:"<%=request.getContextPath()%>/jcryption/keygen.ub",
		beforeEncryption : function() {
			$statusText.text("Test Code").show();
			return true;
		},
		encryptionFinished : function(encryptedString, objectLength) {
			$statusText.text(encryptedString);
			return true;
		}
	});
});
</script>
<body>
	<form id="lf" action="<%=request.getContextPath()%>/jsp/test/jCryptionResult.jsp" method="post">
		<fieldset>
			<legend>login</legend>
			<div>
				<div>username:<br>
				<input type="text" size="45" name="user" value=""></div>
				<div>password:<br>
				<input type="password" size="45" name="password" value=""></div>
			</div>
			<div>
				<p><input type="submit" /><span id="status_container"></span></p>
			</div>
		</fieldset>
	</form>
</body>
</html>
