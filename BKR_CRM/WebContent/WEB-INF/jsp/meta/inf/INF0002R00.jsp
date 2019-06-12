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
	DataList _dl_NoticeManageInquiry_getNoticeDetail = ViewUtil.getResult().getDataList("NoticeManageInquiry.getNoticeDetail");
%>


<!--  ========================================================================
  This page is generated with the UB-META™ ver4.0 
 
   - PAGE ID : INF0002R00
   - PAGE TYPE : JSP
 
  Copyright ⓒ UBONE Co., Ltd. All rights reserved.
 ========================================================================
--> 


<!-- layout-1 Start -->
<h1 class="ub-control title">공지사항 - 상세</h1>
<div class="ub-layout button top"><span class="ub-control button top icon" id="list">
    <a href="#none" title="목록"><span class="ico-list"></span>목록</a>
</span>
</div>
<div class="ub-layout details"><form id="detailForm" name="detailForm"><table class="ub-control table normal ">
<colgroup>
<col />
<col />
<col />
<col />
</colgroup>
<tbody>
<tr id="layout-1_1">
<th id="layout-1_1_1"><label class="ub-control label">제목</label></th>
<td id="layout-1_1_2" colspan=3><input type=text  class="ub-control input-text " id="DS_TITLE" name="DS_TITLE"       value="<%=JspUtils.getDefaultValue(_dl_NoticeManageInquiry_getNoticeDetail, "DS_TITLE") %>"                style="text-align:left;width:620px;"><input type=hidden id="ID_NOTICE" name="ID_NOTICE"    value="${paramMap.ID_NOTICE}"><input type=hidden id="DS_TITLE_H" name="DS_TITLE_H"    value="${paramMap.DS_TITLE_H}"><input type=hidden id="DT_REG_START_H" name="DT_REG_START_H"    value="${paramMap.DT_REG_START_H}"><input type=hidden id="DT_REG_END_H" name="DT_REG_END_H"    value="${paramMap.DT_REG_END_H}"><input type=hidden id="CD_FLAG" name="CD_FLAG"    value="W"></td>
</tr>
<tr id="layout-1_2">
<th id="layout-1_2_3"><label class="ub-control label">내용</label></th>
<td id="layout-1_2_4" colspan=3><textarea class="ub-control textarea " id="DS_NOTICE" name="DS_NOTICE"       style="width:620px;" rows="20"                  rows="20"><%=JspUtils.getDefaultValue(_dl_NoticeManageInquiry_getNoticeDetail, "DS_NOTICE") %></textarea></td>
</tr>
<tr id="layout-1_3">
<th id="layout-1_3_5"><label class="ub-control label">게시여부</label></th>
<td id="layout-1_3_6"><input class="ub-control input-checkbox" type="checkbox" id="FG_OPEN_PORTAL" name="FG_OPEN_PORTAL"    <%= ("Y".equals(JspUtils.getDefaultValue(_dl_NoticeManageInquiry_getNoticeDetail, "FG_OPEN_PORTAL")))?"checked":"" %> value="Y"><label>게시여부</label></input></td>
<th id="layout-1_3_7"><label class="ub-control label">공지기간</label></th>
<td id="layout-1_3_8"><input type=text class="ub-control input-text calendar " id="DT_START" name="DT_START"       metaformat="date" value="<%=JspUtils.getDefaultValue(_dl_NoticeManageInquiry_getNoticeDetail, "DT_START") %>"                style="text-align:left;width:100px;"><label class="ub-control label">~</label><input type=text class="ub-control input-text calendar " id="DT_END" name="DT_END"       metaformat="date" value="<%=JspUtils.getDefaultValue(_dl_NoticeManageInquiry_getNoticeDetail, "DT_END") %>"                style="text-align:left;width:100px;"></td>
</tr>
<tr id="layout-1_4">
<th id="layout-1_4_9"><label class="ub-control label"             for="ID_REG_EMP">등록자</label></th>
<td id="layout-1_4_10"><input type=text  class="ub-control input-text "       value="<%=JspUtils.getDefaultValue(_dl_NoticeManageInquiry_getNoticeDetail, "NM_REG_EMP") %>"                style="text-align:left;width:100px;"   disabled><input type=hidden id="ID_REG_EMP" name="ID_REG_EMP"    value="<%=JspUtils.getDefaultValue(_dl_NoticeManageInquiry_getNoticeDetail, "ID_REG_EMP") %>"></td>
<th id="layout-1_4_11"><label class="ub-control label"             for="ID_REG_DEPT">등록팀/지점</label></th>
<td id="layout-1_4_12"><input type=text  class="ub-control input-text "       value="<%=JspUtils.getDefaultValue(_dl_NoticeManageInquiry_getNoticeDetail, "NM_REG_DEPT") %>"                style="text-align:left;width:100px;"   disabled><input type=hidden id="ID_REG_DEPT" name="ID_REG_DEPT"    value="<%=JspUtils.getDefaultValue(_dl_NoticeManageInquiry_getNoticeDetail, "ID_REG_DEPT") %>"></td>
</tr>
<tr id="layout-1_5">
<th id="layout-1_5_13"><label class="ub-control label">첨부파일</label></th>
<td id="layout-1_5_14" colspan=3><div class="ub-control temp" style="border:2px solid gray;width:100%;height:80px;text-align:center;"><h3 style="padding-top:30px;padding-left:10px;padding-right:10px;">Attach File Control</h3></div><span class="ub-control attachFile">   	<div class="filefieldset" id='uploadedFiles_file'></div>   	<div class="filefieldset" id='uploadProgress_file' style="display:none;">   		<span class="legend">Uploading...</span>   	</div>	<span id='btnUpload_file'></span> </span></td>
</tr>
</tbody>
</table>
 
</form>
</div>
<div class="ub-layout button inner"><span class="ub-control button inner icon" id="prev">
    <a href="#none" title="이전글"><span></span>이전글</a>
</span>
<span class="ub-control button inner icon" id="next">
    <a href="#none" title="다음글"><span></span>다음글</a>
</span>
</div>
<div class="ub-layout button bottom"><span class="ub-control button bottom icon" id="update">
    <a href="#none" title="수정"><span></span>수정</a>
</span>
<span class="ub-control button bottom icon" id="delete">
    <a href="#none" title="삭제"><span></span>삭제</a>
</span>
</div>

<!-- layout-1 End -->
