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
	DataList _dl_BATCH_TYPE = ViewUtil.getResult().getDataList("Code.BATCH_TYPE");
%>


<!--  ========================================================================
  This page is generated with the UB-META™ ver4.0 
 
   - PAGE ID : SYS0041R00
   - PAGE TYPE : JSP
 
  Copyright ⓒ UBONE Co., Ltd. All rights reserved.
 ========================================================================
--> 


<!-- layout-1 Start -->
<h1 class="ub-control title">배치 등록</h1>
<div class="ub-layout button top"><span class="ub-control button top icon" id="listBtn">
    <a href="#none" title="목록"><span class="ico-list"></span>목록</a>
</span>
</div>
<form id="insertForm" name="insertForm"><h2 class="ub-control title">배치 정보</h2>
<div class="ub-layout details"><table class="ub-control table normal ">
<colgroup>
<col width="20%"/>
<col width="80%"/>
</colgroup>
<tbody>
<tr id="layout-1_1">
<th id="layout-1_1_1"><label class="ub-control label"             for="BATCH_ID">배치ID</label></th>
<td id="layout-1_1_2"><input type=text  class="ub-control input-text " id="BATCH_ID" name="BATCH_ID"            metaessential="1"           style="text-align:left;width:400px;"></td>
</tr>
<tr id="layout-1_2">
<th id="layout-1_2_3"><label class="ub-control label"             for="BATCH_NAME">배치명</label></th>
<td id="layout-1_2_4"><input type=text  class="ub-control input-text " id="BATCH_NAME" name="BATCH_NAME"            metaessential="1"           style="text-align:left;width:400px;"></td>
</tr>
<tr id="layout-1_3">
<th id="layout-1_3_5"><label class="ub-control label">배치설명</label></th>
<td id="layout-1_3_6"><textarea class="ub-control textarea " id="BATCH_DESC" name="BATCH_DESC"       style="width:400px;" rows="5"                  rows="5"></textarea></td>
</tr>
</tbody>
</table>
 
</div>
<h2 class="ub-control title">배치 주기</h2>
<div class="ub-layout details"><table class="ub-control table normal ">
<colgroup>
<col width="20%"/>
<col width="80%"/>
</colgroup>
<tbody>
<tr id="layout-1_1">
<th id="layout-1_1_1"><label class="ub-control label"             for="BATCH_TYPE">배치TYPE</label></th>
<td id="layout-1_1_2"><select id="BATCH_TYPE" name="BATCH_TYPE" class="ub-control select "     style="width:120px;" size="1" datacid="BATCH_TYPE"      metaessential="1"><%    if(!"선택안됨".equals("")){        out.println("<OPTION VALUE=\"\">선택안됨</OPTION>\r\n");    }    if(_dl_BATCH_TYPE != null){        for(int codeIdx=0; codeIdx < _dl_BATCH_TYPE.getRowCount(); codeIdx++){            String code = _dl_BATCH_TYPE.getString(codeIdx, ConstantHolder.CODE_COLUMN_CODE);            String name = _dl_BATCH_TYPE.getString(codeIdx, ConstantHolder.CODE_COLUMN_NAME);            out.println("<option VALUE=\""+code+"\">"+name+"</option>\r\n");        }    }%></select></td>
</tr>
<tr id="layout-1_2">
<th id="layout-1_2_3"><label id="SCHEDULE" name="SCHEDULE" class="ub-control label">일정</label></th>
<td id="layout-1_2_4"><table class="ub-control table normal "><colgroup><col /><col /><col /><col /><col /></colgroup><tbody><tr id="layout-1_1"><th id="layout-1_1_1"><label class="ub-control label"      style="width:100px;"        for="EXEC_COND_MIN">분<br>(0-59)</label></th><th id="layout-1_1_2"><label class="ub-control label"      style="width:100px;"        for="EXEC_COND_HOUR">시<br>(0-23)</label></th><th id="layout-1_1_3"><label class="ub-control label"      style="width:100px;"        for="EXEC_COND_DAY">일<br>(1-31)</label></th><th id="layout-1_1_4"><label class="ub-control label"      style="width:100px;"        for="EXEC_COND_MONTH">월<br>(1-12)</label></th><th id="layout-1_1_5"><label class="ub-control label"      style="width:100px;"        for="EXEC_COND_WEEK">주<br>(0-6)</label></th></tr><tr id="layout-1_2"><td id="layout-1_2_6"><input type=text  class="ub-control input-text " id="EXEC_COND_MIN" name="EXEC_COND_MIN"            metaessential="1"           style="text-align:left;width:100px;"></td><td id="layout-1_2_7"><input type=text  class="ub-control input-text " id="EXEC_COND_HOUR" name="EXEC_COND_HOUR"            metaessential="1"           style="text-align:left;width:100px;"></td><td id="layout-1_2_8"><input type=text  class="ub-control input-text " id="EXEC_COND_DAY" name="EXEC_COND_DAY"            metaessential="1"           style="text-align:left;width:100px;"></td><td id="layout-1_2_9"><input type=text  class="ub-control input-text " id="EXEC_COND_MONTH" name="EXEC_COND_MONTH"            metaessential="1"           style="text-align:left;width:100px;"></td><td id="layout-1_2_10"><input type=text  class="ub-control input-text " id="EXEC_COND_WEEK" name="EXEC_COND_WEEK"            metaessential="1"           style="text-align:left;width:100px;"></td></tr></tbody></table> </td>
</tr>
<tr id="layout-1_3">
<th id="layout-1_3_5"><label class="ub-control label"             for="EXEC_PROGRAM">실행CLASS</label></th>
<td id="layout-1_3_6"><input type=text  class="ub-control input-text " id="EXEC_PROGRAM" name="EXEC_PROGRAM"            metaessential="1"           style="text-align:left;width:400px;"></td>
</tr>
</tbody>
</table>
 
</div>
</form>
<div class="ub-layout button bottom"><span class="ub-control button bottom icon" id="insertBtn">
    <a href="#none" title="Save"><span class="ico-save"></span>저장</a>
</span>
</div>

<!-- layout-1 End -->
