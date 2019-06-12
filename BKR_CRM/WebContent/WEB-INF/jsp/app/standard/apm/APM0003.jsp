<%--
#*
 *  파 일 명 :  APM0003.jsp
 *  설    명 :  SCREEN 등록
 *  작 성 자 :  유기태
 *  작 성 일 :  2015.02.23
 *  버    전 :  1.0
 *  기타사항 :
 *  수정이력 :  2016-10-07 다국어 호환 작업 - by 이창섭
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
	DataList _dl_LAYOUT_TYPE = ViewUtil.getResult().getDataList("Code.APMD_LAYOUT_TYPE");
	DataList _dl_SCREEN_TYPE = ViewUtil.getResult().getDataList("Code.APMD_SCREEN_TYPE");
	DataList _dl_SCREEN_VIEW_TYPE = ViewUtil.getResult().getDataList("Code.APMD_SCREEN_VIEW_TYPE");
	DataList _dl_ScreenManageInquiry_getProjectPath = ViewUtil.getResult().getDataList("ScreenManageInquiry.getProjectPath");
%>


<!--  ========================================================================
  This page is generated with the UB-META™ ver4.0 
 
   - PAGE ID : APM0003R00
   - PAGE TYPE : JSP
 
  Copyright ⓒ UBONE Co., Ltd. All rights reserved.
 ========================================================================
--> 


<!-- layout-1 Start -->
<h1 class="ub-control title"><ub:message code="title.APM0003.title" text="화면 등록"/></h1>
<div class="ub-layout button top"><span class="ub-control button top icon" id="btnList"        title="목록">
    <a href="#none" title="목록"><span class="ico-list"></span><ub:message code="button.common.list" text="목록"/></a>
</span>
</div>
<div class="ub-layout details"><form id="detailForm" name="detailForm"><table class="ub-control table normal " id="tblScrInfo">
<colgroup>
<col width="150px"/>
<col width="40%"/>
<col width="150px"/>
<col />
</colgroup>
<tbody>
<tr id="layout-1_1">
<th id="layout-1_1_1"><label class="ub-control label"             for="CATEGORY_CODE"><ub:message code="label.APM.category" text="분류"/></label></th>
<td id="layout-1_1_2">
	<ub:code-select codeCategory="CATEGORY_CODE" id="CATEGORY_CODE" style="width:200px;" blankType="2" essential="true"/>
</td>
<th id="layout-1_1_3"><label class="ub-control label"             for="SCREEN_ID"><ub:message code="label.APM.screen.id" text="화면ID"/></label></th>
<td id="layout-1_1_4"><input type=text  class="ub-control input-text " id="SCREEN_ID" name="SCREEN_ID" maxLength="0" metalength="0"      metaformat="z3n94"      metaessential="1"           style="text-align:left;width:186px;"><label id="lblMessage" name="lblMessage" class="ub-control label">사용가능여부메세지</label></td>
</tr>
<tr id="layout-1_2">
<th id="layout-1_2_5"><label class="ub-control label"             for="SCREEN_TYPE"><ub:message code="label.APM.screen.type" text="화면 유형"/></label></th>
<td id="layout-1_2_6">
	<ub:code-select codeCategory="APMD_SCREEN_TYPE" id="SCREEN_TYPE" style="width:200px;" blankType="2" essential="true"/>
</td>
<th id="layout-1_2_7"><label class="ub-control label"             for="LAYOUT_TYPE"><ub:message code="label.APM.layout.type" text="레이아웃 유형"/></label></th>
<td id="layout-1_2_8">
	<ub:code-select codeCategory="APMD_LAYOUT_TYPE" id="LAYOUT_TYPE" style="width:200px;" blankType="2" essential="true"/>
</td>
</tr>
<tr id="layout-1_3">
<th id="layout-1_3_9"><label class="ub-control label"             for="VIEW_TYPE"><ub:message code="label.APM.view.type" text="View 유형"/></label></th>
<td id="layout-1_3_10">
	<ub:code-select codeCategory="APMD_SCREEN_VIEW_TYPE" id="VIEW_TYPE" style="width:200px;" blankType="2" essential="true"/>
</td>
<td id="layout-1_3_11"></td>
<td id="layout-1_3_12"></td>
</tr>
<tr id="layout-1_4">
<th id="layout-1_4_13"><label class="ub-control label"             for="PID"><ub:message code="label.APM.meta.id" text="메타ID"/></label></th>
<td id="layout-1_4_14">
	<ub:code-select codeCategory="PID" id="PID" style="width:414px;" blankType="2"/>
</td>
<td id="layout-1_4_15"></td>
<td id="layout-1_4_16"></td>
</tr>
<tr id="layout-1_5">
<th id="layout-1_5_17"><label class="ub-control label"             for="SCREEN_NAME"><ub:message code="label.APM.screen.name" text="화면명"/></label></th>
<td id="layout-1_5_18"><input type=text  class="ub-control input-text " id="SCREEN_NAME" name="SCREEN_NAME" maxLength="100" metalength="100"            metaessential="1"           style="text-align:left;width:400px;"></td>
<td id="layout-1_5_19"></td>
<td id="layout-1_5_20"></td>
</tr>
<tr id="layout-1_6">
<th id="layout-1_6_21"><label class="ub-control label"             for="FILE_PATH"><ub:message code="label.APM.file.path" text="파일경로"/></label></th>
<td id="layout-1_6_22" colspan=3><input type=text  class="ub-control input-text " id="FILE_PATH" name="FILE_PATH" maxLength="1000" metalength="1000"            metaessential="1"           style="text-align:left;width:400px;"><input type=hidden id="original_filePathNm" name="original_filePathNm"    value="<%=JspUtils.getDefaultValue(_dl_ScreenManageInquiry_getProjectPath, "CODE_NAME") %>"></td>
</tr>
<tr id="layout-1_7">
<th id="layout-1_7_23"><label class="ub-control label"             for="FILE_NAME"><ub:message code="label.APM.file.name" text="파일명"/></label></th>
<td id="layout-1_7_24"><input type=text  class="ub-control input-text " id="FILE_NAME" name="FILE_NAME" maxLength="100" metalength="100"            metaessential="1"           style="text-align:left;width:400px;"></td>
<th id="layout-1_7_25"><label class="ub-control label"><ub:message code="label.APM.login.check.yn" text="로그인 체크 여부"/></label></th>
<td id="layout-1_7_26"><input class="ub-control input-checkbox" type="checkbox" id="chkLoginYn" name="chkLoginYn"    checked><label></label></input><input type=hidden id="LOGIN_CHECK_YN" name="LOGIN_CHECK_YN"    value="Y"></td>
</tr>
<tr id="layout-1_8">
<th id="layout-1_8_27"><label class="ub-control label"><ub:message code="label.APM.description" text="설명"/></label></th>
<td id="layout-1_8_28" colspan=3><textarea class="ub-control textarea " id="DESCRIPTION" name="DESCRIPTION"  metalength="2000"      style="width:412px;" rows="5"                  rows="5"></textarea></td>
</tr>
</tbody>
</table>
 
</form>
</div>
<div class="ub-layout button bottom"><span class="ub-control button bottom icon" id="btnInsert"        title="저장">
    <a href="#none" title="저장"><span class="ico-save"></span><ub:message code="button.common.save" text="저장"/></a>
</span>
</div>

<!-- layout-1 End -->


<script type="text/javascript">
uxl.onLoad(function(){
	$("#lblMessage").hide();
	$("#tblScrInfo #layout-1_4").hide();
	$("#FILE_PATH").val("/"+$("#original_filePathNm").val()+"/");
	
// 	hsqlData.getCategoryCode("CATEGORY_CODE", {blankOption:"선택안됨"});
	uxl.bindComboCode('CATEGORY_CODE', 'CATEGORY_CODE', {emptyOption:'선택안됨'});
	
	$('#btnList').click(function() {
		uxl.returnToList('APM0001');
	});
	
	$('#btnInsert').click(function() {
		insertScreen();
	});
	
	$("#CATEGORY_CODE").change(function(){
		if($(this).val() == '' || $(this).val() == null){
			$("#SCREEN_ID").attr("maxlength","0");
		}else{
			$("#SCREEN_ID").attr("maxlength","7");
		}
		$("#SCREEN_ID").val($(this).val());
		
		$("#FILE_PATH").val("/"+$("#original_filePathNm").val()+"/"+$(this).val().toLowerCase()+"/");
		$("#PID option").remove();
		hsqlData.getPidList("PID", {blankOption:"선택안됨", categoryCode:$("#CATEGORY_CODE").val()});
	});
	
	$("#appCateCd").change(function() {
		var appCateCd = $(this).val();
		
		if ($.trim(appCateCd) != "") {
			$("#SCREEN_ID").val("UI" + appCateCd);	
		}
	});
	
	$("#VIEW_TYPE").change(function() {
		var scrnViewTpCd = $(this).val();
		$("#PID").setRequired(false);
		$("#SCREEN_ID").attr('readonly',false);
		$('#SCREEN_ID').attr('class', 'ub-control input-text');
		$("#tblScrInfo #layout-1_4").hide();
		$("#PID option").remove();
		if (scrnViewTpCd == "M") {
			$("#PID").setRequired(true);
			hsqlData.getPidList("PID", {blankOption:"선택안됨", categoryCode:$("#CATEGORY_CODE").val()});
			$("#tblScrInfo #layout-1_4").show();
			$("#SCREEN_ID").attr('readonly',true);
			$('#SCREEN_ID').attr('class', 'ub-control input-text readonly');
		}
	});
	
	$("#SCREEN_ID").keyup(function(event) {
		var scrnId = $(this).val();
		
		if (scrnId.length == 7) {
			fnSearch();
		} else if (scrnId.length < 7) {
			$("#FILE_NAME").val("");
			$("#lblMessage").text("");
		}
	});
	
	$("#PID").change(function(){
		var value = $(this).val();
		var screenName = this.options[this.options.selectedIndex].title;
		$("#FILE_NAME, #SCREEN_ID").val(value.substr(0,7));
		if(value != null && value != ''){
			fnSearch();
		}else{
			$("#lblMessage").html('');
			$("#SCREEN_ID").val($("#CATEGORY_CODE").val());
		}
		$("#SCREEN_NAME").val(screenName); // 화면명 자동입력 처리
	});
	
	$("#chkLoginYn").change(function() {
		$("#LOGIN_CHECK_YN").val(((this.checked) ? "Y" : "N"));
	});
	
});
function fnSearch() {
	var scrnId = $("#SCREEN_ID").val();
	var url = uxl.getFunctionUrl(_SCREEN_ID, 'INQUIRY');
	var option = {
		data:{"SCREEN_ID" : scrnId}
	  , success:function(result) {
			var rowCount = result.getDataList(0).rowCount;
			
			if (rowCount > 0) {
				$("#FILE_NAME").val("");
				$("#lblMessage").html('<strong class="txt-color01">등록된 화면ID입니다.</strong>');
			} else {
				$("#FILE_NAME").val(scrnId);
				$("#lblMessage").html('<strong class="txt-color02">사용가능한 화면ID입니다.</strong>');
			}
			$("#lblMessage").show();
	    }
	  , async:true
	};
	uxl.callFunction(url, option);
}

function insertScreen() {
	// 앞뒤 스페이스 제거
	$("input[type='text'], textarea").each(function() {
		var value = $(this).val();
		$(this).val($.trim(value));
	});
	
	var scrnId = $.trim($("#SCREEN_ID").val());
	var url = uxl.getFunctionUrl(_SCREEN_ID, 'REGIST');
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
		  	var key = result.getResultKey()[0];
		  	fnReadScreen(key);
		  	uxl.moveLocation(uxl.getScreenURL('APM0002') + '?SCREEN_ID=' + scrnId);
		}
	  , async:true
	  , message : {
			confirm : uxl.getMessage('@message.common.insert.confirm'),
			success : uxl.getMessage('@message.common.insert.success'),
			fail : uxl.getMessage('@message.common.insert.fail')
		}
	  
	};
	uxl.callSubmitFunction('detailForm', url, option);
}

function fnReadScreen(key) {
	var url = uxl.getFunctionUrl(_SCREEN_ID, 'USERDEFINED1');
	var option = {
		data:{"SCREEN_ID":key}
	  , async:false	  
	};
	uxl.callFunction(url, option);
}
</script>