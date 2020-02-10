<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.ubone.framework.util.ViewUtil"%>
<%@ page import="com.ubone.framework.data.DataList"%>
<%@ page import="com.ubone.framework.data.Parameter"%>
<%@ page import="com.ubone.framework.ConstantHolder"%>
<%@ page import="com.ubone.framework.ConfigHolder"%>
<%@ page import="java.util.Map"%>
<%@ page import="org.apache.commons.lang.StringUtils"%>
<%@ page import="com.ubone.ubmeta.page.util.JspUtils"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.ubqone.com/tags" prefix="ub" %>
<%
	DataList _dataList = null;		/* List Table default dataTable */ 
%>


<!--  ========================================================================
  This page is generated with the UB-META™ ver4.0 
 
   - PAGE ID : POP4001R00
   - PAGE TYPE : JSP
 
  Copyright ⓒ UBONE Co., Ltd. All rights reserved.
 ========================================================================
--> 


<!-- layout-1 Start -->
<h1 class="ub-control title">이메일 주소 변경 팝업</h1>
<form id="detailForm" name="detailForm"><table class="ub-control table normal ">
<colgroup>
<col width="120px"/>
<col />
</colgroup>
<tbody>
<tr id="layout-1_1">
<th id="layout-1_1_1"><label class="ub-control label">변경 전</label></th>
<td id="layout-1_1_2"><input type=text  class="ub-control input-text " id="DS_EMAIL_BR" name="DS_EMAIL_BR"       value="${paramMap.DS_EMAIL}"  readonly              style="text-align:left;width:200px;"></td>
</tr>
<tr id="layout-1_2">
<th id="layout-1_2_3"><label class="ub-control label">변경 후</label></th>
<td id="layout-1_2_4"><input type=text  class="ub-control input-text " id="DS_EMAIL" name="DS_EMAIL"                       style="text-align:left;width:200px;"></td>
</tr>
</tbody>
</table>
 
<input type=hidden id="ID_MEMBER" name="ID_MEMBER"    value="${paramMap.ID_MEMBER}">
</form>
<div class="ub-layout button bottom"><span class="ub-control button bottom icon" id="updateBtn">
    <a href="#none" title="변경"><span></span>변경</a>
</span>
<span class="ub-control button bottom icon"     onclick="self.close();">
    <a href="#none" title="취소"><span></span>취소</a>
</span>
</div>

<!-- layout-1 End -->
