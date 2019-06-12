<%@ page language="java" pageEncoding="UTF-8"%>
<html>
<head>
<title>Login form</title>
	<script type="text/javascript">
		var _CONTEXT_ROOT = '';
		var _SERVER_MODE = 'local';
		
		var _KEY_PRIMARY = 'primary_key';
		var _KEY_RECOVERY = 'searchRecoveryCommand';
		
		var _REQUEST_PATH_SCREEN = 'screen';
		var _REQUEST_PATH_FUNCTION = 'function';
		var _REQUEST_PATH_SERVICE = 'service';
		var _REQUEST_PATH_CODE = 'code';
		var _REQUEST_PATH_MESSAGE = 'message';
		
		var _CODE_PREFIX = 'Code.';
		var _CODE_COLUMN_PARENT = 'PARENT_CODE';
		var _CODE_COLUMN_CODE = 'CODE';
		var _CODE_COLUMN_NAME = 'CODE_NAME';
		
		var _SEARCH_RECOVERY_COMMAND_SAVE = '';
		var _SEARCH_RECOVERY_COMMAND_RECOVERY = 'recovery';
		var _SEARCH_RECOVERY_COMMAND_CLEAR = 'clear';
		
		var _CALL_LAYOUT = 'call_layout';
		var _CALL_LAYOUT_PARAM = '';
	
		var _FORM_SEARCH = 'searchForm';
		var _FORM_DETAIL = 'detailForm';
		
		var _BUTTON_SEARCH = 'searchBtn';
		var _BUTTON_NEW = 'newBtn';
		var _BUTTON_LIST = 'listBtn';
		var _BUTTON_INSERT = 'insertBtn';
		var _BUTTON_UPDATE = 'updateBtn';
		var _BUTTON_DELETE = 'deleteBtn';
		var _BUTTON_REQUEST = 'requestBtn';
		var _BUTTON_CONFIRM = 'confirmBtn';
		var _BUTTON_COMPLETE = 'completeBtn';
		var _BUTTON_CANCEL = 'cancelBtn';
		var _BUTTON_IMPORT = 'importBtn';
		var _BUTTON_EXPORT = 'exportBtn';

		var _KEY_PAGE_NUMBER = "pageNumber";
		var _KEY_PAGE_BLOCK  = "pageBlock";
		var _KEY_PAGE_SIZE  = "pageSize";
		
		var _KEY_PAGE_ORDER_COLUMN = "ORDER_COLUMN";
		var _KEY_PAGE_ORDER_ASC = "ORDER_ASC"
		
		var pageSize    = 10;
		
		
		
		var _SECURITY_KEY_TOKEN = 'a_token';
		var _SECURITY_SERVICE_ENABLED = 'false' == 'true' ? true : false;

		var orderColumn = '';
		var orderAsc = '';
		
		var _SCREEN_ID = 'SYS0021';
		var _SCREEN_FUNCTIONS = [];

		_SCREEN_FUNCTIONS.push({
			functionId: 'FNCSYS0057', 
			functionName: '사용자 관리 목록 호출', 
			functionType: 'ServiceEvent', 
			alias: 'INQUIRY', 
			serviceId: 'SVCSYS0054',
			tokenKey: '',
			authorityLevel: ''
		});

	</script>	
<%@ include file="/WEB-INF/jsp/include/pageJs.jsp" %>
</head>


<script type="text/javascript"> 
$(document).ready(function() {
	var $statusText = $('<span id="status"></span>').hide();
    $("#status_container").append($statusText);
    
    $("#btnSubmit").click(function(){
    	fnSearch();
    });
    
    
/*
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
*/
});

//조회
function fnSearch(){
	//필수정보 체크
	var url = "/jsp/test/jCryptionResult2.jsp";
	var option = {
			  data: {}
			, validator:function(data,targetForm){
					var returnVal = false;
					//필수항목체크
					if(uxl.checkRequiredFields(targetForm)){
						returnVal = true;
					}
					
					return returnVal;
			}
			/*
			 * 조회한 데이터를 그리드에 추가함.
			 * @param {String} 그리드로 변환할 테이블ID
			 * @param {Result} 조회된 데이터 객체 result
			 * @param {boolean} 데이터 추가시 기존데이터의 clear 여부
			 */
			, success:function(result){
				uxl.grid.appendData('list' ,result , true );
			}
			, async:true
			, cryptoParams:['username','password']
	};
	uxl.callSubmitFunction('lf' , url , option );		
}
</script>
<body>
	<form id="lf" name="lf" action="<%=request.getContextPath()%>" method="post">
		<fieldset>
			<legend>login</legend>
			<div>
				<div>username:<br>
				<input type="text" size="45" name="username" value=""></div>
				<div>password:<br>
				<input type="password" size="45" name="password" value=""></div>
			</div>
			<div>
				<p><span id="status_container"></span></p>
			</div>
		</fieldset>
	</form>
	<button id="btnSubmit">submit</button>
</body>
</html>
