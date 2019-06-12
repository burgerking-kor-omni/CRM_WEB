<%@page import="org.apache.commons.lang.StringUtils"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.ubone.framework.engine.domain.Function"%>
<%@ page import="com.ubone.framework.ConfigHolder"%>
<%@ page import="com.ubone.framework.data.Parameter"%>
<%@ page import="com.ubone.framework.engine.domain.User"%>
<%@ page import="com.ubone.framework.security.token.TokenContainer"%>
<%@ page import="com.ubone.framework.engine.domain.Screen"%>
<%@ page import="com.ubone.framework.data.ServiceMessage"%>
<%@ page import="com.ubone.framework.data.Result"%>
<%@ page import="com.ubone.framework.ConstantHolder"%>
<%@ page import="com.ubone.framework.util.UserUtil"%>
<%@ page import="com.ubone.framework.data.DataUtil"%>
<%
	String rootPath = request.getContextPath();
	if(!rootPath.endsWith("/")) {
		rootPath = rootPath + "/";
	}

	Result result = (Result) request.getAttribute(ConstantHolder.KEY_SERVICE_RESULT);
	if(result == null) result = DataUtil.makeResult();
	
	ServiceMessage serviceMessage = result.getServiceMessage();

	Screen screen = (Screen) request.getAttribute(ConstantHolder.KEY_SCREEN);
	User user = UserUtil.getLoginUser();
	
	Parameter parameter = (Parameter) request.getAttribute(ConstantHolder.KEY_PARAMETER);
	if(parameter == null){
		parameter = DataUtil.makeParameter();
	}
	
	TokenContainer tokenContainer = (TokenContainer) request.getAttribute(TokenContainer.class.getSimpleName());
	
	String constant_form_search = "searchForm";
	String constant_form_detail = "detailForm";
	
	String constant_button_search = "searchBtn";
	String constant_button_new = "newBtn";
	String constant_button_list = "listBtn";
	String constant_button_insert = "insertBtn";
	String constant_button_update = "updateBtn";
	String constant_button_delete = "deleteBtn";
	String constant_button_request = "requestBtn";
	String constant_button_confirm = "confirmBtn";
	String constant_button_complete = "completeBtn";
	String constant_button_cancel = "cancelBtn";
	String constant_button_import = "importBtn";
	String constant_button_export = "exportBtn";
%>
	<script type="text/javascript">
		var _CONTEXT_ROOT = '<%=request.getContextPath()%>';
		var _SERVER_MODE = '<%=ConfigHolder.APPLICATION_MODE%>';
		
		var _KEY_PRIMARY = '<%=ConstantHolder.KEY_PRIMARY%>';
		var _KEY_RECOVERY = '<%=ConstantHolder.KEY_SEARCH_RECOVERY_COMMAND%>';
		
		var _REQUEST_PATH_SCREEN = '<%=ConstantHolder.REQUEST_PATH_SCREEN%>';
		var _REQUEST_PATH_FUNCTION = '<%=ConstantHolder.REQUEST_PATH_FUNCTION%>';
		var _REQUEST_PATH_SERVICE = '<%=ConstantHolder.REQUEST_PATH_SERVICE%>';
		var _REQUEST_PATH_CODE = '<%=ConstantHolder.REQUEST_PATH_CODE%>';
		var _REQUEST_PATH_MESSAGE = '<%=ConstantHolder.REQUEST_PATH_MESSAGE%>';
		
		var _CODE_PREFIX = '<%=ConstantHolder.CODE_PREFIX%>';
		var _CODE_COLUMN_PARENT = '<%=ConstantHolder.CODE_COLUMN_PARENT%>';
		var _CODE_COLUMN_CODE = '<%=ConstantHolder.CODE_COLUMN_CODE%>';
		var _CODE_COLUMN_NAME = '<%=ConstantHolder.CODE_COLUMN_NAME%>';
		
		var _SEARCH_RECOVERY_COMMAND_SAVE = '<%=ConstantHolder.SEARCH_RECOVERY_COMMAND_SAVE%>';
		var _SEARCH_RECOVERY_COMMAND_RECOVERY = '<%=ConstantHolder.SEARCH_RECOVERY_COMMAND_RECOVERY%>';
		var _SEARCH_RECOVERY_COMMAND_CLEAR = '<%=ConstantHolder.SEARCH_RECOVERY_COMMAND_CLEAR%>';
		var _SEARCH_ADVANCED_FLAG = '<%=StringUtils.defaultString(parameter.get("SEARCH_ADVANCED_FLAG"), "false") %>';
		
		var _CALL_LAYOUT = '<%=ConstantHolder.KEY_PARAMETER_LAYOUT%>';
		var _CALL_LAYOUT_PARAM = '<%=parameter.get(ConstantHolder.KEY_PARAMETER_LAYOUT)%>';
	
		var _FORM_SEARCH = '<%=constant_form_search%>';
		var _FORM_DETAIL = '<%=constant_form_detail%>';
		
		var _BUTTON_SEARCH = '<%=constant_button_search%>';
		var _BUTTON_NEW = '<%=constant_button_new%>';
		var _BUTTON_LIST = '<%=constant_button_list%>';
		var _BUTTON_INSERT = '<%=constant_button_insert%>';
		var _BUTTON_UPDATE = '<%=constant_button_update%>';
		var _BUTTON_DELETE = '<%=constant_button_delete%>';
		var _BUTTON_REQUEST = '<%=constant_button_request%>';
		var _BUTTON_CONFIRM = '<%=constant_button_confirm%>';
		var _BUTTON_COMPLETE = '<%=constant_button_complete%>';
		var _BUTTON_CANCEL = '<%=constant_button_cancel%>';
		var _BUTTON_IMPORT = '<%=constant_button_import%>';
		var _BUTTON_EXPORT = '<%=constant_button_export%>';

		var _KEY_PAGE_NUMBER = "<%=ConstantHolder.KEY_PAGE_NUMBER%>";
		var _KEY_PAGE_BLOCK  = "<%=ConstantHolder.KEY_PAGE_BLOCK%>";
		var _KEY_PAGE_SIZE  = "<%=ConstantHolder.KEY_PAGE_SIZE%>";
		
		var _KEY_PAGE_ORDER_COLUMN = "ORDER_COLUMN";
		var _KEY_PAGE_ORDER_ASC = "ORDER_ASC";
		
		var pageSize    = <%=ConfigHolder.BLOCK_SIZE%>;
		
		var _USE_MULTI_LANG = <%=ConfigHolder.LOCALE_USE_MULTI_LANGUAGE%>;
		var _DEFAULT_LANG_CD = "<%=ConfigHolder.LOCALE_DEFAULT_LANGUAGE%>";
		var _CURR_LANG_CD = "<%=UserUtil.getLocale().getLanguage() %>";
		var _USE_LANG_LIST = new Array();
<%
	for(int i=0; i< ConfigHolder.LOCALE_USE_LANGUAGE_CODE.length; i++){
		out.println("		_USE_LANG_LIST["+i+"] = \""+ConfigHolder.LOCALE_USE_LANGUAGE_CODE[i]+"\";");		
	}
%>
		
		var _SECURITY_KEY_TOKEN = '<%=ConstantHolder.AUTH_KEY_TOKEN%>';
		var _SECURITY_SERVICE_ENABLED = '<%=ConfigHolder.SECURITY_SERVICE_ENABLED%>' == 'true' ? true : false;

		var orderColumn = '<%=parameter.get("ORDER_COLUMN")%>';
		var orderAsc = '<%=parameter.get("ORDER_ASC")%>';
		
		var _SCREEN_ID = '<%=screen.getId()%>';
		var _SCREEN_NAME = '<%=screen.getScreenName()%>';
		var _SCREEN_FUNCTIONS = [];
<%for(Function screenFunction : screen.getFunctions()) {%>
		_SCREEN_FUNCTIONS.push({
			functionId: '<%=screenFunction.getId()%>', 
			functionName: '<%=screenFunction.getFunctionName()%>', 
			functionType: '<%=screenFunction.getFunctionType()%>', 
			alias: '<%=screenFunction.getAlias()%>', 
			serviceId: '<%=screenFunction.getServiceId()%>',
			tokenKey: '<%=tokenContainer != null ? tokenContainer.get(screenFunction.getId()).getKey() : ""%>',
			authorityLevel: '<%=tokenContainer != null ? tokenContainer.get(screenFunction.getId()).getAuthorityLevel().getCode() : ""%>'
		});
<%
	}
%>
	</script>	