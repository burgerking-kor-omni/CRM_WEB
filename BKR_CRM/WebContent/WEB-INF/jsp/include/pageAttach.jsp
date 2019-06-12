<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page errorPage="/jsp/error/errorPage.jsp" %>
<%@ page import="com.ubone.framework.util.ViewUtil"%>
<%@ page import="com.ubone.framework.data.DataList"%>
<%@ page import="com.ubone.framework.ConstantHolder"%>
<%
	// Attach file 데이터 추가 함수
	DataList fileInfo = ViewUtil.getResult().getDataList(ConstantHolder.KEY_FILEINFO);
	
	out.println("<!-- Attach file info -->");
	out.println("<script language=\"javascript\" type=\"text/javascript\">");
	out.println("      var fileDataList = [];");
	
	if(fileInfo != null){
		
		for(int i = 0 ; i < fileInfo.getRowCount() ; i++ ){
			String fileId        = fileInfo.getString(i, "id");
			String attachType    = fileInfo.getString(i, "attachType");
			String attachSubType = fileInfo.getString(i, "attachSubType");
			String fileName      = fileInfo.getString(i, "fileName");
			String fileSize      = fileInfo.getString(i, "fileSize");
			String contentType   = fileInfo.getString(i, "contentType");
			out.println("    fileDataList.push({id : '"+fileId+"', attachType : '"+attachType+"', attachSubType : '"+attachSubType+"', fileName : '"+fileName+"', fileSize : "+fileSize+", contentType : '"+contentType+"'});");
		} //end for
		
	} //end if
	
	out.println("</script>");
				
%>