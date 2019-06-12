<%--
#*
 *  파 일 명 :  APM0008.jsp
 *  설    명 :  서비스 정보 상세
 *  작 성 자 :  유기태
 *  작 성 일 :  2015.02.23
 *  버    전 :  1.0
 *  기타사항 :
 *  Copyrights 2013 by ㈜ 유비원. All right reserved.
*# 
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.ubone.framework.util.ViewUtil"%>
<%@ include file="/WEB-INF/jsp/include/pageCommon.jsp"%>
<%@ page import="com.ubone.framework.data.DataList"%>
<%@ page import="com.ubone.framework.data.Parameter"%>
<%@ page import="com.ubone.framework.ConstantHolder"%>
<%@ page import="com.ubone.framework.ConfigHolder"%>
<%@ page import="java.util.Map"%>
<%@ page import="org.apache.commons.lang.StringUtils"%>
<%@ page import="com.ubone.ubmeta.page.util.JspUtils"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core"   prefix="c" %>
<%
	DataList _dataList = null;		/* List Table default dataTable */ 
	DataList _dl_CALL_TYPE = ViewUtil.getResult().getDataList("Code.APMD_CALL_TYPE");
	DataList _dl_FLAG_YN = ViewUtil.getResult().getDataList("Code.FLAG_YN");
	DataList _dl_SERVICE_TYPE = ViewUtil.getResult().getDataList("Code.APMD_SERVICE_TYPE");
	DataList _dl_ServiceManageInquiry_getDetail = ViewUtil.getResult().getDataList("ServiceManageInquiry.getDetail");
	DataList _dl_WORKFLOW_ACTIVITY = ViewUtil.getResult().getDataList("Code.WORKFLOW_ACTIVITY");
	DataList _dl_WORK_CATEGORY = ViewUtil.getResult().getDataList("Code.WORK_CATEGORY");
%>


<!--  ========================================================================
  This page is generated with the UB-META™ ver4.0 
 
   - PAGE ID : APM0008R00
   - PAGE TYPE : JSP
 
  Copyright ⓒ UBONE Co., Ltd. All rights reserved.
 ========================================================================
--> 

<form method='post' name=detailForm id=detailForm autocomplete=off  style='margin:0 0 0 0;'>
<!-- layout-1 Start -->
<h2 class="ub-control title">서비스 정보</h2>
<div class="ub-layout button top"></div>
<div class="ub-layout details"><table class="ub-control table normal " id="tblSvcInfo">
<colgroup>
<col width="150px"/>
<col width="40%"/>
<col width="150px"/>
<col />
</colgroup>
<tbody>
<tr id="layout-1_1">
<th id="layout-1_1_1"><label class="ub-control label">서비스ID</label></th>
<td id="layout-1_1_2"><input type=text  class="ub-control input-text " id="SERVICE_ID" name="SERVICE_ID"       value="<%=JspUtils.getDefaultValue(_dl_ServiceManageInquiry_getDetail, "SERVICE_ID") %>"  readonly   metaessential="1"           style="text-align:left;width:100px;"></td>
<td id="layout-1_1_3"></td>
<td id="layout-1_1_4"></td>
</tr>
<tr id="layout-1_2">
<th id="layout-1_2_5"><label class="ub-control label"             for="SERVICE_TYPE">서비스유형</label></th>
<td id="layout-1_2_6"><select id="SERVICE_TYPE" name="SERVICE_TYPE" class="ub-control select "     style="width:114px;" size="1" datacid="APMD_SERVICE_TYPE" defaultvalue="<%=JspUtils.getDefaultValue(_dl_ServiceManageInquiry_getDetail, "SERVICE_TYPE") %>"     metaessential="1"><%    if(!"선택안됨".equals("")){        out.println("<OPTION VALUE=\"\">선택안됨</OPTION>\r\n");    }    if(_dl_SERVICE_TYPE != null){        for(int codeIdx=0; codeIdx < _dl_SERVICE_TYPE.getRowCount(); codeIdx++){            String code = _dl_SERVICE_TYPE.getString(codeIdx, ConstantHolder.CODE_COLUMN_CODE);            String name = _dl_SERVICE_TYPE.getString(codeIdx, ConstantHolder.CODE_COLUMN_NAME);            String selected = code.equals(JspUtils.getDefaultValue(_dl_ServiceManageInquiry_getDetail, "SERVICE_TYPE"))?"selected":"";            out.println("<option VALUE=\""+code+"\" "+selected+">"+name+"</option>\r\n");        }    }%></select></td>
<th id="layout-1_2_7"><label class="ub-control label"             for="CATEGORY_CODE">분류</label></th>
<td id="layout-1_2_8"><select id="CATEGORY_CODE" name="CATEGORY_CODE" class="ub-control select "     style="width:170px;" size="1"    disabled   metaessential="1"         disabled></select><input type=hidden id="CATEGORY_CODE_VALUE" name="CATEGORY_CODE_VALUE"    value="<%=JspUtils.getDefaultValue(_dl_ServiceManageInquiry_getDetail, "CATEGORY_CODE") %>"></td>
</tr>
<tr id="layout-1_3">
<th id="layout-1_3_9"><label id="prtdRsrcYn" name="prtdRsrcYn" class="ub-control label"             for="IS_PROTECTED_RESOURCE">보호된 자원여부</label></th>
<td id="layout-1_3_10"><select id="IS_PROTECTED_RESOURCE" name="IS_PROTECTED_RESOURCE" class="ub-control select "     style="width:114px;" size="1" datacid="FLAG_YN" defaultvalue="<%=JspUtils.getDefaultValue(_dl_ServiceManageInquiry_getDetail, "IS_PROTECTED_RESOURCE") %>"><%    if(!"선택안됨".equals("")){        out.println("<OPTION VALUE=\"\">선택안됨</OPTION>\r\n");    }    if(_dl_FLAG_YN != null){        for(int codeIdx=0; codeIdx < _dl_FLAG_YN.getRowCount(); codeIdx++){            String code = _dl_FLAG_YN.getString(codeIdx, ConstantHolder.CODE_COLUMN_CODE);            String name = _dl_FLAG_YN.getString(codeIdx, ConstantHolder.CODE_COLUMN_NAME);            String selected = code.equals(JspUtils.getDefaultValue(_dl_ServiceManageInquiry_getDetail, "IS_PROTECTED_RESOURCE"))?"selected":"";            out.println("<option VALUE=\""+code+"\" "+selected+">"+name+"</option>\r\n");        }    }%></select></td>
<td id="layout-1_3_11"></td>
<td id="layout-1_3_12"></td>
</tr>
<tr id="layout-1_4">
<th id="layout-1_4_13"><label class="ub-control label">페이징여부</label></th>
<td id="layout-1_4_14"><select id="PAGING_YN" name="PAGING_YN" class="ub-control select "     style="width:114px;" size="1" datacid="FLAG_YN" defaultvalue="<%=JspUtils.getDefaultValue(_dl_ServiceManageInquiry_getDetail, "PAGING_YN") %>"><%    if(!"선택안됨".equals("")){        out.println("<OPTION VALUE=\"\">선택안됨</OPTION>\r\n");    }    if(_dl_FLAG_YN != null){        for(int codeIdx=0; codeIdx < _dl_FLAG_YN.getRowCount(); codeIdx++){            String code = _dl_FLAG_YN.getString(codeIdx, ConstantHolder.CODE_COLUMN_CODE);            String name = _dl_FLAG_YN.getString(codeIdx, ConstantHolder.CODE_COLUMN_NAME);            String selected = code.equals(JspUtils.getDefaultValue(_dl_ServiceManageInquiry_getDetail, "PAGING_YN"))?"selected":"";            out.println("<option VALUE=\""+code+"\" "+selected+">"+name+"</option>\r\n");        }    }%></select></td>
<th id="layout-1_4_15"><label class="ub-control label">검색이력저장여부</label></th>
<td id="layout-1_4_16"><select id="FIND_COND_SAVE_YN" name="FIND_COND_SAVE_YN" class="ub-control select "     style="width:170px;" size="1" datacid="FLAG_YN" defaultvalue="<%=JspUtils.getDefaultValue(_dl_ServiceManageInquiry_getDetail, "FIND_COND_SAVE_YN") %>"><%    if(!"선택안됨".equals("")){        out.println("<OPTION VALUE=\"\">선택안됨</OPTION>\r\n");    }    if(_dl_FLAG_YN != null){        for(int codeIdx=0; codeIdx < _dl_FLAG_YN.getRowCount(); codeIdx++){            String code = _dl_FLAG_YN.getString(codeIdx, ConstantHolder.CODE_COLUMN_CODE);            String name = _dl_FLAG_YN.getString(codeIdx, ConstantHolder.CODE_COLUMN_NAME);            String selected = code.equals(JspUtils.getDefaultValue(_dl_ServiceManageInquiry_getDetail, "FIND_COND_SAVE_YN"))?"selected":"";            out.println("<option VALUE=\""+code+"\" "+selected+">"+name+"</option>\r\n");        }    }%></select></td>
</tr>
<tr id="layout-1_5">
<th id="layout-1_5_17"><label class="ub-control label">페이징건수</label></th>
<td id="layout-1_5_18"><input type=text  class="ub-control input-text " id="PAGING_COUNT" name="PAGING_COUNT" maxLength="4" metalength="4"       value="<%=JspUtils.getDefaultValue(_dl_ServiceManageInquiry_getDetail, "PAGING_COUNT") %>"            onkeypress="allowOnly('0..9');"      style="ime-mode:disabled;text-align:right;width:100px;"></td>
<td id="layout-1_5_19"></td>
<td id="layout-1_5_20"></td>
</tr>
<tr id="layout-1_6">
<th id="layout-1_6_21"><label class="ub-control label"             for="SERVICE_NAME">서비스명</label></th>
<td id="layout-1_6_22" colspan=3><input type=text  class="ub-control input-text " id="SERVICE_NAME" name="SERVICE_NAME" maxLength="100" metalength="100"       value="<%=JspUtils.getDefaultValue(_dl_ServiceManageInquiry_getDetail, "SERVICE_NAME") %>"     metaessential="1"           style="text-align:left;width:400px;"></td>
</tr>
<tr id="layout-1_7">
<th id="layout-1_7_23" style=' vertical-align:Top'><label class="ub-control label">서비스설명</label></th>
<td id="layout-1_7_24" colspan=3><textarea class="ub-control textarea " id="DESCRIPTION" name="DESCRIPTION"  metalength="1000"      style="width:412px;" rows="5"                  rows="5"><%=JspUtils.getDefaultValue(_dl_ServiceManageInquiry_getDetail, "DESCRIPTION") %></textarea></td>
</tr>
<tr id="layout-1_8">
<th id="layout-1_8_25"><label class="ub-control label">등록자</label></th>
<td id="layout-1_8_26"><input type=text  class="ub-control input-text " id="REG_USER_ID" name="REG_USER_ID"       value="<%=JspUtils.getDefaultValue(_dl_ServiceManageInquiry_getDetail, "REG_USER_ID") %>"  readonly              style="text-align:left;width:100px;"></td>
<th id="layout-1_8_27"><label class="ub-control label">등록일</label></th>
<td id="layout-1_8_28"><input type=text  class="ub-control input-text " id="REG_DATETIME" name="REG_DATETIME"       value="<%=JspUtils.getDefaultValue(_dl_ServiceManageInquiry_getDetail, "REG_DATETIME") %>"  readonly              style="text-align:left;width:120px;"></td>
</tr>
<tr id="layout-1_9">
<th id="layout-1_9_29"><label class="ub-control label">수정자</label></th>
<td id="layout-1_9_30"><input type=text  class="ub-control input-text " id="UPD_USER_ID" name="UPD_USER_ID"       value="<%=JspUtils.getDefaultValue(_dl_ServiceManageInquiry_getDetail, "UPD_USER_ID") %>"  readonly              style="text-align:left;width:100px;"></td>
<th id="layout-1_9_31"><label class="ub-control label">수정일</label></th>
<td id="layout-1_9_32"><input type=text  class="ub-control input-text " id="UPD_DATETIME" name="UPD_DATETIME"       value="<%=JspUtils.getDefaultValue(_dl_ServiceManageInquiry_getDetail, "UPD_DATETIME") %>"  readonly              style="text-align:left;width:120px;"></td>
</tr>
</tbody>
</table>
 
</div>
<h2 class="ub-control title">컴포넌트</h2>
<div class="ub-layout details"><table class="ub-control table normal " id="tblComponent">
<colgroup>
<col width="150px"/>
<col width="40%"/>
<col width="150px"/>
<col />
</colgroup>
<tbody>
<tr id="layout-1_1">
<th id="layout-1_1_1"><label class="ub-control label"             for="CALL_TYPE">호출유형</label></th>
<td id="layout-1_1_2"><select id="CALL_TYPE" name="CALL_TYPE" class="ub-control select "     style="width:120px;" size="1" datacid="APMD_CALL_TYPE" defaultvalue="<%=JspUtils.getDefaultValue(_dl_ServiceManageInquiry_getDetail, "CALL_TYPE") %>"     metaessential="1"><%    if(!"선택안됨".equals("")){        out.println("<OPTION VALUE=\"\">선택안됨</OPTION>\r\n");    }    if(_dl_CALL_TYPE != null){        for(int codeIdx=0; codeIdx < _dl_CALL_TYPE.getRowCount(); codeIdx++){            String code = _dl_CALL_TYPE.getString(codeIdx, ConstantHolder.CODE_COLUMN_CODE);            String name = _dl_CALL_TYPE.getString(codeIdx, ConstantHolder.CODE_COLUMN_NAME);            String selected = code.equals(JspUtils.getDefaultValue(_dl_ServiceManageInquiry_getDetail, "CALL_TYPE"))?"selected":"";            out.println("<option VALUE=\""+code+"\" "+selected+">"+name+"</option>\r\n");        }    }%></select></td>
<th id="layout-1_1_3"><label class="ub-control label">로그인 체크 여부</label></th>
<td id="layout-1_1_4"><input class="ub-control input-checkbox" type="checkbox" id="chkLoginYn" name="chkLoginYn"><label></label></input><input type=hidden id="loginChkYn" name="loginChkYn"    value="<%=JspUtils.getDefaultValue(_dl_ServiceManageInquiry_getDetail, "LOGIN_CHECK_YN") %>"></td>
</tr>
<tr id="layout-1_2">
<th id="layout-1_2_5"><label class="ub-control label">첨부파일 지원여부</label></th>
<td id="layout-1_2_6"><select id="HAS_LINKED_FILE" name="HAS_LINKED_FILE" class="ub-control select "     style="width:120px;" size="1" datacid="FLAG_YN" defaultvalue="<%=JspUtils.getDefaultValue(_dl_ServiceManageInquiry_getDetail, "HAS_LINKED_FILE") %>"><%    if(!"선택안됨".equals("")){        out.println("<OPTION VALUE=\"\">선택안됨</OPTION>\r\n");    }    if(_dl_FLAG_YN != null){        for(int codeIdx=0; codeIdx < _dl_FLAG_YN.getRowCount(); codeIdx++){            String code = _dl_FLAG_YN.getString(codeIdx, ConstantHolder.CODE_COLUMN_CODE);            String name = _dl_FLAG_YN.getString(codeIdx, ConstantHolder.CODE_COLUMN_NAME);            String selected = code.equals(JspUtils.getDefaultValue(_dl_ServiceManageInquiry_getDetail, "HAS_LINKED_FILE"))?"selected":"";            out.println("<option VALUE=\""+code+"\" "+selected+">"+name+"</option>\r\n");        }    }%></select></td>
<th id="layout-1_2_7"><label class="ub-control label">이벤트 유발여부</label></th>
<td id="layout-1_2_8"><select id="IS_INDUCED_EVENT" name="IS_INDUCED_EVENT" class="ub-control select "     style="width:120px;" size="1" datacid="FLAG_YN" defaultvalue="<%=JspUtils.getDefaultValue(_dl_ServiceManageInquiry_getDetail, "IS_INDUCED_EVENT") %>"><%    if(!"선택안됨".equals("")){        out.println("<OPTION VALUE=\"\">선택안됨</OPTION>\r\n");    }    if(_dl_FLAG_YN != null){        for(int codeIdx=0; codeIdx < _dl_FLAG_YN.getRowCount(); codeIdx++){            String code = _dl_FLAG_YN.getString(codeIdx, ConstantHolder.CODE_COLUMN_CODE);            String name = _dl_FLAG_YN.getString(codeIdx, ConstantHolder.CODE_COLUMN_NAME);            String selected = code.equals(JspUtils.getDefaultValue(_dl_ServiceManageInquiry_getDetail, "IS_INDUCED_EVENT"))?"selected":"";            out.println("<option VALUE=\""+code+"\" "+selected+">"+name+"</option>\r\n");        }    }%></select></td>
</tr>
<tr id="layout-1_3">
<th id="layout-1_3_9"><label class="ub-control label"             for="CLASS_NAME">클래스명</label></th>
<td id="layout-1_3_10" colspan=3><input type=text  class="ub-control input-text " id="CLASS_NAME" name="CLASS_NAME" maxLength="1000" metalength="1000"       value="<%=JspUtils.getDefaultValue(_dl_ServiceManageInquiry_getDetail, "CLASS_NAME") %>"                style="text-align:left;width:400px;"></td>
</tr>
<tr id="layout-1_4">
<th id="layout-1_4_11"><label class="ub-control label"             for="METHOD_NAME">메서드명</label></th>
<td id="layout-1_4_12" colspan=3><input type=text  class="ub-control input-text " id="METHOD_NAME" name="METHOD_NAME" maxLength="200" metalength="200"       value="<%=JspUtils.getDefaultValue(_dl_ServiceManageInquiry_getDetail, "METHOD_NAME") %>"                style="text-align:left;width:400px;"></td>
</tr>
<tr id="layout-1_5">
<th id="layout-1_5_13"><label class="ub-control label"             for="LINKED_WORK_CATEGORY">업무유형</label></th>
<td id="layout-1_5_14" colspan=3><select id="LINKED_WORK_CATEGORY" name="LINKED_WORK_CATEGORY" class="ub-control select "     style="width:120px;" size="1" datacid="WORK_CATEGORY" defaultvalue="<%=JspUtils.getDefaultValue(_dl_ServiceManageInquiry_getDetail, "LINKED_WORK_CATEGORY") %>"><%    if(!"선택안됨".equals("")){        out.println("<OPTION VALUE=\"\">선택안됨</OPTION>\r\n");    }    if(_dl_WORK_CATEGORY != null){        for(int codeIdx=0; codeIdx < _dl_WORK_CATEGORY.getRowCount(); codeIdx++){            String code = _dl_WORK_CATEGORY.getString(codeIdx, ConstantHolder.CODE_COLUMN_CODE);            String name = _dl_WORK_CATEGORY.getString(codeIdx, ConstantHolder.CODE_COLUMN_NAME);            String selected = code.equals(JspUtils.getDefaultValue(_dl_ServiceManageInquiry_getDetail, "LINKED_WORK_CATEGORY"))?"selected":"";            out.println("<option VALUE=\""+code+"\" "+selected+">"+name+"</option>\r\n");        }    }%></select></td>
</tr>
<tr id="layout-1_6">
<th id="layout-1_6_15"><label class="ub-control label">업무활동</label></th>
<td id="layout-1_6_16" colspan=3><select id="LINKED_ACTIVITY_TYPE" name="LINKED_ACTIVITY_TYPE" class="ub-control select "     style="width:120px;" size="1" datacid="WORKFLOW_ACTIVITY" defaultvalue="<%=JspUtils.getDefaultValue(_dl_ServiceManageInquiry_getDetail, "LINKED_ACTIVITY_TYPE") %>"><%    if(!"선택안됨".equals("")){        out.println("<OPTION VALUE=\"\">선택안됨</OPTION>\r\n");    }    if(_dl_WORKFLOW_ACTIVITY != null){        for(int codeIdx=0; codeIdx < _dl_WORKFLOW_ACTIVITY.getRowCount(); codeIdx++){            String code = _dl_WORKFLOW_ACTIVITY.getString(codeIdx, ConstantHolder.CODE_COLUMN_CODE);            String name = _dl_WORKFLOW_ACTIVITY.getString(codeIdx, ConstantHolder.CODE_COLUMN_NAME);            String selected = code.equals(JspUtils.getDefaultValue(_dl_ServiceManageInquiry_getDetail, "LINKED_ACTIVITY_TYPE"))?"selected":"";            out.println("<option VALUE=\""+code+"\" "+selected+">"+name+"</option>\r\n");        }    }%></select></td>
</tr>
</tbody>
</table>
 
</div>

<h2 class="ub-control title" id="lblEncrypt">암호화</h2>
<div class="ub-layout " id="lytEncrypt">
	<table class="ub-control table normal ">
		<colgroup>
			<col width="150px"/>
			<col />
		</colgroup>
		<tbody>
			<tr id="layout-1_1">
				<th id="layout-1_1_1" style=' vertical-align:Top'><label class="ub-control label"             for="ENCRYPT_COLUMNS">인코딩컬럼</label></th>
				<td id="layout-1_1_2"><textarea class="ub-control textarea " id="ENCRYPT_COLUMNS" name="ENCRYPT_COLUMNS"  metalength="2000"      style="width:412px;" rows="5"                  rows="5"><%=JspUtils.getDefaultValue(_dl_ServiceManageInquiry_getDetail, "ENCRYPT_COLUMNS") %></textarea><label class="ub-control label"><br>* 대상컬럼 구분자는 , 또는 엔터로 구분하세요.</label></td>
			</tr>
		</tbody>
	</table>
</div>

<h2 class="ub-control title">화면 목록</h2>
<div class="ub-layout "><div class="ub-control temp" style="border:2px solid gray;width:100%;height:300px;text-align:center;"><h3 style="padding-top:120px;">Grid Control</h3></div>
<table class="ub-control grid" id="list" name="list"></table> 
	
</div>
<div class="ub-layout button inner"></div>
<div class="ub-layout button bottom"><span class="ub-control button bottom icon" id="updateBtn"        title="수정">
    <a href="#none" title="Save"><span class="ico-save"></span>수정</a>
</span>
<span class="ub-control button bottom icon" id="deleteBtn"        title="삭제">
    <a href="#none" title="Delete"><span class="ico-delete"></span>삭제</a>
</span>
</div>

<!-- layout-1 End -->
</form>

<script type="text/javascript">

uxl.onLoad(function(){
	//암호화 숨김
	$('#lblEncrypt, #lytEncrypt').hide();
	
	var tab = parent.tab;
	var serviceQueryTab = parent.serviceQueryTab;

 	var loginChkYn = $("#loginChkYn").val();
	if (loginChkYn == "Y") $("#chkLoginYn").attr("checked", true);
 
//  	hsqlData.getCategoryCode("CATEGORY_CODE",{blankOption:"선택안됨", selectValue:$("#CATEGORY_CODE_VALUE").val()});
	uxl.bindComboCode('CATEGORY_CODE', 'CATEGORY_CODE', {emptyOption:'선택안됨'});
	
	if ($("#SERVICE_TYPE").val() != "R") {
		$("#tblSvcInfo #layout-1_4").hide();
	}

	if ($("#PAGING_YN").val() != "Y") {
		$("#tblSvcInfo #layout-1_5").hide();
	}

	if ($("#CALL_TYPE").val() == "C") {
		$("#CLASS_NAME").attr("metaessential", "1");
		$("#METHOD_NAME").attr("metaessential", "1");
	} else if($("#CALL_TYPE").val() == "S"){
		serviceQueryTab.show();
		$("#tblComponent #layout-1_3").hide();
		$("#tblComponent #layout-1_4").hide();
	} else {
		$("#tblComponent #layout-1_3").hide();
		$("#tblComponent #layout-1_4").hide();
	}

	$("#tblComponent #layout-1_5").hide();
	$("#tblComponent #layout-1_6").hide();
	$("#LINKED_WORK_CATEGORY").attr("metaessential", "");

	if (($("#HAS_LINKED_FILE").val() == "Y") || ($("#IS_INDUCED_EVENT").val() == "Y")) {
		$("#tblComponent #layout-1_5").show();
		$("#tblComponent #layout-1_6").show();
		$("#LINKED_WORK_CATEGORY").attr("metaessential", "1");
	}
	
	resize();
	uxl.displayRequired();

	$('#updateBtn').click(function() {
		updateService();
	});
	
	$('#deleteBtn').click(function() {
		deleteService();
	});

	$('#CALL_TYPE').change(function() {
		if ($(this).val() == "C") {
			var queryTab = tab.getTabIndex("APM0032");
			if(queryTab != -1){
				serviceQueryTab.hide();
			}
			$("#tblComponent #layout-1_3").show();
			$("#tblComponent #layout-1_4").show();
			
			$("#CLASS_NAME").attr("metaessential", "1");
			$("#METHOD_NAME").attr("metaessential", "1");
		} else if($("#CALL_TYPE").val() == "S"){
			serviceQueryTab.show();
			
			$("#tblComponent #layout-1_3").hide();
			$("#tblComponent #layout-1_4").hide();

			$("#CLASS_NAME").attr("metaessential", "");
			$("#METHOD_NAME").attr("metaessential", "");
		} else {
			var queryTab = tab.getTabIndex("APM0032");
			if(queryTab != -1){
				serviceQueryTab.hide();
			}
			
			$("#tblComponent #layout-1_3").hide();
			$("#tblComponent #layout-1_4").hide();

			$("#CLASS_NAME").attr("metaessential", "");
			$("#METHOD_NAME").attr("metaessential", "");
		}
		resize();
		uxl.displayRequired();
	});
	
	$('#SERVICE_TYPE').change(function() {
		$("#PAGING_COUNT").val(null);
		if ($(this).val() == "R") {
			$("#tblSvcInfo #layout-1_4").show();
			
			if ($('#PAGING_YN').val() == "Y") {
				$("#PAGING_COUNT").val(10);
				$("#tblSvcInfo_5").show();
			}
		} else {
			$("#tblSvcInfo #layout-1_4").hide();
			$("#tblSvcInfo #layout-1_5").hide();
		}
		resize();
	});
	
	$('#PAGING_YN').change(function() {
		if ($(this).val() == "Y") {
			$("#tblSvcInfo #layout-1_5").show();
			$("#PAGING_COUNT").val("10");
		} else {
			$("#tblSvcInfo #layout-1_5").hide();
			$("#PAGING_COUNT").val(null);
		}
		resize();
	});

	$('#HAS_LINKED_FILE, #IS_INDUCED_EVENT').change(function() {
		var atchFileSprtYn = $('#HAS_LINKED_FILE').val();
		var evntIndcYn = $('#IS_INDUCED_EVENT').val();

		$("#tblComponent #layout-1_5").hide();
		$("#tblComponent #layout-1_6").hide();
		$("#LINKED_WORK_CATEGORY").attr("metaessential", "");
		$("#LINKED_WORK_CATEGORY").val("");
		$("#LINKED_ACTIVITY_TYPE").val("");

		if (atchFileSprtYn == "Y") {
			$("#tblComponent #layout-1_5").show();	
			$("#LINKED_WORK_CATEGORY").attr("metaessential", "1");
		}
		
		if(evntIndcYn == "Y"){
			$("#tblComponent #layout-1_5").show();
			$("#tblComponent #layout-1_6").show();
			$("#LINKED_WORK_CATEGORY").attr("metaessential", "1");
		}

		resize();
		uxl.displayRequired();
	});
	
	/*
	그리드 옵션
	colNames : 그리드 Header 정보,
	colModel : 그리드 Contents 의 바인딩 정보
	*/
	
	var options = {
		//header name
		colNames:['분류', '화면ID', '화면명', '화면유형', 'View유형']

		//mapping column
	  , colModel:[
		    {name:'CATEGORY_CODE',    width:10, align:'center'}
		  , {name:'SCREEN_ID',       width:15, align:'center'}
		  , {name:'SCREEN_NAME',       width:55, align:'left'}
		  , {name:'SCREEN_TYPE',     width:10, align:'center', codeCategory:'APMD_SCREEN_TYPE'}
		  , {name:'VIEW_TYPE', width:10, align:'center', codeCategory:'APMD_SCREEN_VIEW_TYPE'}
		]
	  , autowidth:true
	  , height:261
	  , multiselect:false
	};
	
	uxl.grid('list', options);
	uxl.grid.init('list');
	fnSearch();

	$("#chkLoginYn").change(function() {
		$("#loginChkYn").val(((this.checked) ? "Y" : "N"));
	});
});

//조회
function fnSearch() {
	//필수정보 체크
	var url = uxl.getFunctionUrl(_SCREEN_ID, 'INQUIRY');
	
	var option = {
		data:uxl.grid.getParam('list')
		
	    /*
		 * 조회한 데이터를 그리드에 추가함.
		 * @param {String} 그리드로 변환할 테이블ID
		 * @param {Result} 조회된 데이터 객체 result
		 * @param {boolean} 데이터 추가시 기존데이터의 clear 여부
		 */
	  , success:function(result) {
			uxl.grid.appendData('list', result, true);
		}
	  , async:true
	};
	uxl.callSubmitFunction('detailForm', url, option);		
}

function updateService() {
	var svcId = $("#SERVICE_ID").val();
	var url = uxl.getFunctionUrl(_SCREEN_ID, 'MODIFY');
	var option = {
		data:{}
	  , validator:function(data,targetForm) {
			var returnVal = false;
			//필수항목체크
			if(uxl.checkRequiredFields(targetForm)) {
				returnVal = true;
			}
			return returnVal;
		}
	  , success:function(result) {
			uxl.moveLocation(uxl.getScreenURL(_SCREEN_ID) + '?SERVICE_ID=' + svcId);
		}
	  , async:true
	  , message : {
			confirm : uxl.getMessage('@message.common.update.confirm'),
			success : uxl.getMessage('@message.common.update.success'),
			fail : uxl.getMessage('@message.common.update.fail')
		}
	  
	};
	uxl.callSubmitFunction('detailForm', url, option);
}

function deleteService() {
	var svcId = $("#SERVICE_ID").val();
	var url = uxl.getFunctionUrl(_SCREEN_ID, 'REMOVE');
	var option = {
		data:{"SERVICE_ID" : svcId}
	  , validator:function(data,targetForm) {
			var returnVal = false;
			
			if (confirm(uxl.getMessage('@message.common.delete.confirm'))) {
				returnVal = true;
			}
			
			return returnVal;
		}
	  , success:function(result) {
		  	parent.uxl.returnToList('APM0005'); 
		}
	  , async:true
	  , message : {
			success : uxl.getMessage('@message.common.delete.success'),
			fail : uxl.getMessage('@message.common.delete.fail')
		}
	};
	uxl.callFunction(url, option);
}


</script>