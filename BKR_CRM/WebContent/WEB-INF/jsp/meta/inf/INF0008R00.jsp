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
	DataList _dl_ReferManageInquiry_getRefDetail = ViewUtil.getResult().getDataList("ReferManageInquiry.getRefDetail");
%>


<!--  ========================================================================
  This page is generated with the UB-META™ ver4.0 
 
   - PAGE ID : INF0008R00
   - PAGE TYPE : JSP
 
  Copyright ⓒ UBONE Co., Ltd. All rights reserved.
 ========================================================================
--> 


<!-- layout-1 Start -->
<h1 class="ub-control title">자료실 - 상세</h1>
<div class="ub-layout button top"><span class="ub-control button top icon" id="list">
    <a href="#none" title="목록"><span class="ico-list"></span>목록</a>
</span>
</div>
<div class="ub-layout details"><form id="detailForm" name="detailForm"><table class="ub-control table normal ">
<colgroup>
<col width="120px"/>
<col width="400px"/>
<col width="120px"/>
<col />
</colgroup>
<tbody>
<tr id="layout-1_1">
<th id="layout-1_1_1"><label class="ub-control label"             for="DS_TITLE">제목</label></th>
<td id="layout-1_1_2" colspan=3><input type=text  class="ub-control input-text " id="DS_TITLE" name="DS_TITLE" maxLength="100" metalength="100"       value="<%=JspUtils.getDefaultValue(_dl_ReferManageInquiry_getRefDetail, "DS_TITLE") %>"     metaessential="1"           style="text-align:left;width:620px;"><input type=hidden id="ID_BULLETIN" name="ID_BULLETIN"    value="${paramMap.ID_BULLETIN}"><input type=hidden id="ID_REG_EMP" name="ID_REG_EMP"    value="<%=JspUtils.getDefaultValue(_dl_ReferManageInquiry_getRefDetail, "ID_REG_EMP") %>"></td>
</tr>
<tr id="layout-1_2">
<th id="layout-1_2_3"><label class="ub-control label"             for="DS_CONTENT">내용</label></th>
<td id="layout-1_2_4" colspan=3><textarea class="ub-control textarea " id="DS_CONTENT" name="DS_CONTENT"       style="width:620px;" rows="14"      metaessential="1"            rows="14"><%=JspUtils.getDefaultValue(_dl_ReferManageInquiry_getRefDetail, "DS_CONTENT") %></textarea></td>
</tr>
<tr id="layout-1_3">
<th id="layout-1_3_5"><label class="ub-control label">등록자</label></th>
<td id="layout-1_3_6"><input type=text  class="ub-control input-text "       value="<%=JspUtils.getDefaultValue(_dl_ReferManageInquiry_getRefDetail, "NM_REG_EMP") %>"                style="text-align:left;width:100px;"   disabled></td>
<th id="layout-1_3_7"><label class="ub-control label">등록부서</label></th>
<td id="layout-1_3_8"><input type=text  class="ub-control input-text "       value="<%=JspUtils.getDefaultValue(_dl_ReferManageInquiry_getRefDetail, "NM_REG_DEPT") %>"                style="text-align:left;width:100px;"   disabled></td>
</tr>
<tr id="layout-1_4">
<th id="layout-1_4_9"><label class="ub-control label">첨부파일</label></th>
<td id="layout-1_4_10" colspan=3><div class="ub-control temp" style="border:2px solid gray;width:100%;height:80px;text-align:center;"><h3 style="padding-top:30px;padding-left:10px;padding-right:10px;">Attach File Control</h3></div><span class="ub-control attachFile">   	<div class="filefieldset" id='uploadedFiles_file'></div>   	<div class="filefieldset" id='uploadProgress_file' style="display:none;">   		<span class="legend">Uploading...</span>   	</div>	<span id='btnUpload_file'></span> </span></td>
</tr>
</tbody>
</table>
 
</form>
</div>
<div class="ub-layout button bottom"><span class="ub-control button bottom icon" id="update">
    <a href="#none" title="수정"><span></span>수정</a>
</span>
<span class="ub-control button bottom icon" id="delete">
    <a href="#none" title="삭제"><span></span>삭제</a>
</span>
</div>

<!-- layout-1 End -->
