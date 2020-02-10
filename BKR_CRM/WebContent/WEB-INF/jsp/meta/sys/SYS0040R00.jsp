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
	DataList _dl_BATCH_STATUS = ViewUtil.getResult().getDataList("Code.BATCH_STATUS");
%>


<!--  ========================================================================
  This page is generated with the UB-META™ ver4.0 
 
   - PAGE ID : SYS0040R00
   - PAGE TYPE : JSP
 
  Copyright ⓒ UBONE Co., Ltd. All rights reserved.
 ========================================================================
--> 


<!-- layout-1 Start -->
<h1 class="ub-control title">배치목록</h1>
<div class="ub-layout button top"><span class="ub-control button top icon" id="insertBatchBtn">
    <a href="#none" title="Register"><span class="ico-register"></span>배치등록</a>
</span>
</div>
<form id="searchForm" name="searchForm"><div class="ub-layout search">
    <span class="search-ltbg"></span>
    <span class="search-rtbg"></span>
    <span class="search-lbbg"></span>
    <span class="search-rbbg"></span>
<table class="ub-control table normal ">
<colgroup>
<col />
<col />
<col />
<col />
</colgroup>
<tbody>
<tr id="layout-1_1">
<th id="layout-1_1_1"><label class="ub-control label">배치ID</label></th>
<td id="layout-1_1_2"><input type=text  class="ub-control input-text " id="BATCH_ID" name="BATCH_ID"       value="${paramMap.BATCH_ID}"                style="text-align:left;width:100px;"></td>
<th id="layout-1_1_3"><label class="ub-control label">배치명</label></th>
<td id="layout-1_1_4"><input type=text  class="ub-control input-text " id="BATCH_NAME" name="BATCH_NAME"       value="${paramMap.BATCH_NAME}"                style="text-align:left;width:100px;"></td>
</tr>
<tr id="layout-1_2">
<th id="layout-1_2_5"><label class="ub-control label">배치상태</label></th>
<td id="layout-1_2_6"><select id="STATUS" name="STATUS" class="ub-control select "     style="width:120px;" size="1" datacid="BATCH_STATUS" defaultvalue="${paramMap.STATUS}"><%    if(!"전체".equals("")){        out.println("<OPTION VALUE=\"\">전체</OPTION>\r\n");    }    if(_dl_BATCH_STATUS != null){        for(int codeIdx=0; codeIdx < _dl_BATCH_STATUS.getRowCount(); codeIdx++){            String code = _dl_BATCH_STATUS.getString(codeIdx, ConstantHolder.CODE_COLUMN_CODE);            String name = _dl_BATCH_STATUS.getString(codeIdx, ConstantHolder.CODE_COLUMN_NAME);            String selected = code.equals(ViewUtil.getParameter().getValue("STATUS"))?"selected":"";            out.println("<option VALUE=\""+code+"\" "+selected+">"+name+"</option>\r\n");        }    }%></select></td>
<th id="layout-1_2_7"><label class="ub-control label">사용여부</label></th>
<td id="layout-1_2_8"><input class="ub-control input-checkbox" type="checkbox" id="USE_YN" name="USE_YN"     value="Y"><label>미사용포함여부</label></input></td>
</tr>
</tbody>
</table>
 
<div class="ub-layout button bottom"><span class="ub-control button search" id="searchBtn">
<a href="#none" title="Search">검색</a>
</span>
</div>

</div>
</form>
<div class="ub-layout list"><div class="ub-control temp" style="border:2px solid gray;width:100%;height:300px;text-align:center;"><h3 style="padding-top:120px;">Grid Control</h3></div>
<table class="ub-control grid" id="list" name="list"></table> 
	
</div>
<div class="ub-layout pagging"><div class="ub-control temp" style="border:2px solid gray;width:100%;height:30px;text-align:center;"><h3 style="padding-top:3px;">Paging Navigation</h3></div>
<div class="ub-control pagging" for="list" formId="searchForm" function="selectBatchList"></div>
</div>

<!-- layout-1 End -->
