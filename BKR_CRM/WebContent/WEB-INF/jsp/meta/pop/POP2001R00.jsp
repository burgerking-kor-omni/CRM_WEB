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
 
   - PAGE ID : POP2001R00
   - PAGE TYPE : JSP
 
  Copyright ⓒ UBONE Co., Ltd. All rights reserved.
 ========================================================================
--> 


<!-- layout-1 Start -->
<h1 class="ub-control title">상품추가</h1>
<h2 class="ub-control title">기본정보</h2>
<div class="ub-layout "><form id="detailForm" name="detailForm"><table class="ub-control table normal ">
<colgroup>
<col width="120PX"/>
<col />
</colgroup>
<tbody>
<tr id="layout-1_1">
<th id="layout-1_1_1"><label class="ub-control label">상품</label></th>
<td id="layout-1_1_2"><input type=text  class="ub-control input-text " id="MENU_NM" name="MENU_NM"         readonly              style="text-align:left;width:100px;"   disabled><span class="ub-control button inner icon"     onclick="fnSearch();">    <a href="#none" title="찾기"><span></span>찾기</a></span><input type=hidden id="MENU_CD" name="MENU_CD"></td>
</tr>
<tr id="layout-1_2">
<th id="layout-1_2_3"><label class="ub-control label">적립개수</label></th>
<td id="layout-1_2_4"><input type=text  class="ub-control input-text "      metaformat="number"                 style="text-align:left;width:50px;"><label class="ub-control label"> 개</label></td>
</tr>
<tr id="layout-1_3">
<th id="layout-1_3_5"><label class="ub-control label">사용여부</label></th>
<td id="layout-1_3_6"><select id="FG_USE" name="FG_USE" class="ub-control select "     style="width:115px;" size="1"></select></td>
</tr>
</tbody>
</table>
 
</form>
</div>
<div class="ub-layout button bottom"><span class="ub-control button bottom icon"     onclick="fnSave();">
    <a href="#none" title="Save"><span class="ico-save"></span>저장</a>
</span>
</div>

<!-- layout-1 End -->
