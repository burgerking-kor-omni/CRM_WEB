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
	DataList _dl_CD_ORG_1 = ViewUtil.getResult().getDataList("Code.CD_ORG_1");
%>


<!--  ========================================================================
  This page is generated with the UB-META™ ver4.0 
 
   - PAGE ID : INF0006R00
   - PAGE TYPE : JSP
 
  Copyright ⓒ UBONE Co., Ltd. All rights reserved.
 ========================================================================
--> 


<!-- layout-1 Start -->
<h1 class="ub-control title">FAQ - 등록</h1>
<div class="ub-layout button top"><span class="ub-control button top icon" id="list">
    <a href="#none" title="목록"><span class="ico-list"></span>목록</a>
</span>
</div>
<div class="ub-layout details"><form id="registForm" name="registForm"><table class="ub-control table normal ">
<colgroup>
<col />
<col />
</colgroup>
<tbody>
<tr id="layout-1_1">
<th id="layout-1_1_1"><label class="ub-control label"             for="TP_CATEGORY_2">카테고리</label></th>
<td id="layout-1_1_2"><select id="CD_COMP" name="CD_COMP" class="ub-control select "     style="width:120px;" size="1" datacid="CD_ORG_1"><%    if(!"선택".equals("")){        out.println("<OPTION VALUE=\"\">선택</OPTION>\r\n");    }    if(_dl_CD_ORG_1 != null){        for(int codeIdx=0; codeIdx < _dl_CD_ORG_1.getRowCount(); codeIdx++){            String code = _dl_CD_ORG_1.getString(codeIdx, ConstantHolder.CODE_COLUMN_CODE);            String name = _dl_CD_ORG_1.getString(codeIdx, ConstantHolder.CODE_COLUMN_NAME);            out.println("<option VALUE=\""+code+"\">"+name+"</option>\r\n");        }    }%></select><select id="CD_BRAND" name="CD_BRAND" class="ub-control select "     style="width:120px;" size="1"       metaessential="1"></select><select id="CD_SUB_BRAND" name="CD_SUB_BRAND" class="ub-control select "     style="width:120px;" size="1"  defaultvalue="${paramMap.CD_SUB_BRAND}"     metaessential="1"></select></td>
</tr>
<tr id="layout-1_2">
<th id="layout-1_2_3"><label class="ub-control label"             for="DS_TITLE">제목</label></th>
<td id="layout-1_2_4"><input type=text  class="ub-control input-text " id="DS_TITLE" name="DS_TITLE"            metaessential="1"           style="text-align:left;width:835px;"></td>
</tr>
<tr id="layout-1_3">
<th id="layout-1_3_5"><label class="ub-control label"             for="DS_CONTENT">세부내용</label></th>
<td id="layout-1_3_6"><textarea class="ub-control textarea " id="DS_CONTENT" name="DS_CONTENT"       style="width:0;" rows="0"                  rows="0"></textarea></td>
</tr>
</tbody>
</table>
 
</form>
</div>
<div class="ub-layout button bottom"><span class="ub-control button top icon" id="save">
    <a href="#none" title="Register"><span class="ico-register"></span>등록</a>
</span>
</div>

<!-- layout-1 End -->
