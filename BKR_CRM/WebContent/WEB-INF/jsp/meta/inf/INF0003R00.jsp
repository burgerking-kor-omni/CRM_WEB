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
 
   - PAGE ID : INF0003R00
   - PAGE TYPE : JSP
 
  Copyright ⓒ UBONE Co., Ltd. All rights reserved.
 ========================================================================
--> 


<!-- layout-1 Start -->
<h1 class="ub-control title">공지사항 - 등록</h1>
<div class="ub-layout button top"><span class="ub-control button top icon" id="list">
    <a href="#none" title="목록"><span class="ico-list"></span>목록</a>
</span>
</div>
<div class="ub-layout details"><form id="registForm" name="registForm"><table class="ub-control table normal ">
<colgroup>
<col width="100px"/>
<col width="260px"/>
<col width="100px"/>
<col />
</colgroup>
<tbody>
<tr id="layout-1_1">
<th id="layout-1_1_1"><label class="ub-control label"             for="DS_TITLE">제목</label></th>
<td id="layout-1_1_2" colspan=3><input type=text  class="ub-control input-text " id="DS_TITLE" name="DS_TITLE" maxLength="100" metalength="100"            metaessential="1"           style="text-align:left;width:650px;"></td>
</tr>
<tr id="layout-1_2">
<th id="layout-1_2_3"><label class="ub-control label"             for="DS_NOTICE">내용</label></th>
<td id="layout-1_2_4" colspan=3><textarea class="ub-control textarea " id="DS_NOTICE" name="DS_NOTICE"       style="width:650px;" rows="14"      metaessential="1"            rows="14"></textarea></td>
</tr>
<tr id="layout-1_3">
<th id="layout-1_3_5"><label class="ub-control label">게시여부</label></th>
<td id="layout-1_3_6"><input class="ub-control input-checkbox" type="checkbox" id="FG_OPEN" name="FG_OPEN"    checked><label>게시여부</label></input></td>
<th id="layout-1_3_7"><label class="ub-control label"             for="DT_START,DT_END">공지기간</label></th>
<td id="layout-1_3_8"><input type=text class="ub-control input-text calendar " id="DT_START" name="DT_START"       metaformat="date"      metaessential="1"           style="text-align:left;width:100px;"><label class="ub-control label">~</label><input type=text class="ub-control input-text calendar " id="DT_END" name="DT_END"       metaformat="date"      metaessential="1"           style="text-align:left;width:100px;"></td>
</tr>
<tr id="layout-1_4">
<th id="layout-1_4_9"><label class="ub-control label">첨부파일</label></th>
<td id="layout-1_4_10" colspan=3><div class="ub-control temp" style="border:2px solid gray;width:100%;height:80px;text-align:center;"><h3 style="padding-top:30px;padding-left:10px;padding-right:10px;">Attach File Control</h3></div><span class="ub-control attachFile">   	<div class="filefieldset" id='uploadedFiles_file'></div>   	<div class="filefieldset" id='uploadProgress_file' style="display:none;">   		<span class="legend">Uploading...</span>   	</div>	<span id='btnUpload_file'></span> </span></td>
</tr>
</tbody>
</table>
 
</form>
</div>
<div class="ub-layout button bottom"><span class="ub-control button bottom icon" id="save">
    <a href="#none" title="등록"><span></span>등록</a>
</span>
</div>

<!-- layout-1 End -->
