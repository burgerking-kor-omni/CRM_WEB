<%@page import="com.ubone.framework.engine.domain.ScreenType"%>
<%@page import="com.ubone.framework.data.Result"%>
<%@page import="org.apache.commons.lang.StringUtils"%>
<%@page import="com.ubone.framework.engine.service.support.Paging"%>
<%@page import="com.ubone.framework.data.DataUtil"%>
<%@page import="com.ubone.framework.data.Parameter"%>
<%@page import="com.ubone.framework.engine.domain.Service"%>
<%@page import="com.ubone.framework.engine.service.support.ServiceContext"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page errorPage="/jsp/error/errorPage.jsp" %>
<%@ page import="com.ubone.framework.engine.domain.ScreenViewType"%>
<%@ page import="com.ubone.framework.engine.domain.Screen"%>
<%@ page import="com.ubone.framework.util.ViewUtil"%>
<%@ page import="com.ubone.framework.ConfigHolder"%>
<%@ page import="com.ubone.framework.ConstantHolder"%>
<%@ page import="com.ubone.framework.data.DataList"%>
<%@ include file="/WEB-INF/jsp/include/pageTagLibs.jsp"%>
<%
	// 첨부파일 처리 jsp include
	String attachFile = "/WEB-INF/jsp/include/pageAttach.jsp";
	request.getRequestDispatcher(attachFile).include(request, response);
	
	// 메타 생성 JSP include
	Screen screen = ViewUtil.getScreen();
	if(screen.getScreenViewType().equals(ScreenViewType.Meta)){
		String jspPath = ConfigHolder.VIEW_JSP_ROOT 
				+ ConfigHolder.META_FILE_PATH 
				+ "/" + screen.getMetaPageId().substring(0,3).toLowerCase() 
				+ "/" + screen.getMetaPageId() + ".jsp";

		request.getRequestDispatcher(jspPath).include(request, response);
	}
	
	// 검색이력 저장여부에 따른 그리드 처리
	if(screen.getScreenType().equals(ScreenType.list)){
		Parameter parameter = ViewUtil.getParameter();
		
		String pageNumber = StringUtils.defaultIfEmpty(parameter.getValue(ConstantHolder.KEY_PAGE_NUMBER), "1");
		String pageSize   = StringUtils.defaultIfEmpty(parameter.getValue(ConstantHolder.KEY_PAGE_SIZE), "10");
		String recoveryCommand = StringUtils.defaultString(request.getParameter(ConstantHolder.KEY_SEARCH_RECOVERY_COMMAND), "");
		
		if("recovery".equals(recoveryCommand)){
%>
	<script type="text/javascript">
		/**
		 * jqGrid 2.0.0에서 사용되는 파라미터 설정값
		 */
		uxl.pageNumber = <%=pageNumber %>;
		uxl.pageSize   = <%=pageSize %>;
	</script>
<%
		}
	}
%>