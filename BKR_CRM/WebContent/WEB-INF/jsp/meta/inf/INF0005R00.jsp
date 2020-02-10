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
	DataList _dl_FaqManageInquiry_getFaqDetail = ViewUtil.getResult().getDataList("FaqManageInquiry.getFaqDetail");
%>


<!--  ========================================================================
  This page is generated with the UB-META™ ver4.0 
 
   - PAGE ID : INF0005R00
   - PAGE TYPE : JSP
 
  Copyright ⓒ UBONE Co., Ltd. All rights reserved.
 ========================================================================
--> 


<!-- layout-1 Start -->
<h1 class="ub-control title">FAQ - 상세</h1>
<div class="ub-layout button top"><span class="ub-control button top icon" id="list">
    <a href="#none" title="목록"><span class="ico-list"></span>목록</a>
</span>
</div>
<div class="ub-layout details"><form id="detailForm" name="detailForm"><table class="ub-control table normal ">
<colgroup>
<col />
<col />
</colgroup>
<tbody>
<tr id="layout-1_1">
<th id="layout-1_1_1"><label class="ub-control label">카테고리</label></th>
<td id="layout-1_1_2"><input type=hidden id="ID_BULLETIN" name="ID_BULLETIN"    value="${paramMap.ID_BULLETIN}"><select id="CD_COMP" name="CD_COMP" class="ub-control select "     style="width:120px;" size="1"  defaultvalue="<%=JspUtils.getDefaultValue(_dl_FaqManageInquiry_getFaqDetail, "CD_COMP") %>"></select><select id="CD_BRAND" name="CD_BRAND" class="ub-control select "     style="width:120px;" size="1"  defaultvalue="<%=JspUtils.getDefaultValue(_dl_FaqManageInquiry_getFaqDetail, "CD_BRAND") %>"></select><select id="CD_SUB_BRAND" name="CD_SUB_BRAND" class="ub-control select "     style="width:120px;" size="1"  defaultvalue="<%=JspUtils.getDefaultValue(_dl_FaqManageInquiry_getFaqDetail, "CD_SUB_BRAND") %>"></select></td>
</tr>
<tr id="layout-1_2">
<th id="layout-1_2_3"><label class="ub-control label">제목</label></th>
<td id="layout-1_2_4"><input type=text  class="ub-control input-text " id="DS_TITLE" name="DS_TITLE"       value="<%=JspUtils.getDefaultValue(_dl_FaqManageInquiry_getFaqDetail, "DS_TITLE") %>"                style="text-align:left;width:835px;"><input type=hidden id="ID_REG_EMP" name="ID_REG_EMP"    value="<%=JspUtils.getDefaultValue(_dl_FaqManageInquiry_getFaqDetail, "ID_REG_EMP") %>"></td>
</tr>
<tr id="layout-1_3">
<th id="layout-1_3_5"><label class="ub-control label">세부내용</label></th>
<td id="layout-1_3_6"><textarea class="ub-control textarea " id="DS_CONTENT" name="DS_CONTENT"       style="width:0;" rows="0"                  rows="0"><%=JspUtils.getDefaultValue(_dl_FaqManageInquiry_getFaqDetail, "DS_CONTENT") %></textarea></td>
</tr>
</tbody>
</table>
 
</form>
</div>
<div class="ub-layout button bottom"><span class="ub-control button bottom icon" id="update">
    <a href="#none" title="Save"><span class="ico-save"></span>수정</a>
</span>
<span class="ub-control button bottom icon" id="delete">
    <a href="#none" title="Delete"><span class="ico-delete"></span>삭제</a>
</span>
</div>

<!-- layout-1 End -->
