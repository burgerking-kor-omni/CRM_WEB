<%--
#*
 *  파 일 명 :  APM0036.jsp
 *  설    명 :  서비스관리 등록 (팝업)
 *  작 성 자 :  유기태
 *  작 성 일 :  2015.03.25
 *  버    전 :  1.0
 *  기타사항 :
 *  수정이력 :  2016-10-10 다국어 호환 작업 - by 이창섭
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
	DataList _dl_WORKFLOW_ACTIVITY = ViewUtil.getResult().getDataList("Code.WORKFLOW_ACTIVITY");
	DataList _dl_WORK_CATEGORY = ViewUtil.getResult().getDataList("Code.WORK_CATEGORY");
%>


<!--  ========================================================================
  This page is generated with the UB-META™ ver4.0 
 
   - PAGE ID : APM0036R00
   - PAGE TYPE : JSP
 
  Copyright ⓒ UBONE Co., Ltd. All rights reserved.
 ========================================================================
--> 

<form method='post' name=detailForm id=detailForm autocomplete=off  style='margin:0 0 0 0;'>
<!-- layout-1 Start -->
<h1 class="ub-control title"><ub:message code="title.APM0036.title" text="서비스 등록"/></h1>
<div class="ub-layout details">
<h2 class="ub-control title"><ub:message code="title.APM0036.service.info" text="서비스 정보"/></h2>
<table class="ub-control table normal " id="tblSvcInfo">
<colgroup>
<col width="150px"/>
<col width="450px"/>
<col width="150px"/>
<col />
</colgroup>
<tbody>
<tr id="layout-1_1">
<th id="layout-1_1_1"><label class="ub-control label"             for="CATEGORY_CODE"><ub:message code="label.APM.category" text="분류"/></label></th>
<td id="layout-1_1_2">
	<!-- <select id="CATEGORY_CODE" name="CATEGORY_CODE" class="ub-control select "     style="width:170px;" size="1"       metaessential="1"></select> -->
	<ub:code-select id="CATEGORY_CODE" codeCategory="CATEGORY_CODE" style="width:170px;" essential="true"/>
</td>
<th id="layout-1_1_3"><label class="ub-control label"             for="SERVICE_TYPE"><ub:message code="label.APM.service.type" text="서비스유형"/></label></th>
<td id="layout-1_1_4">
	<%-- <select id="SERVICE_TYPE" name="SERVICE_TYPE" class="ub-control select "     style="width:120px;" size="1" datacid="APMD_SERVICE_TYPE"      metaessential="1"><%    if(!"선택안됨".equals("")){        out.println("<OPTION VALUE=\"\">선택안됨</OPTION>\r\n");    }    if(_dl_SERVICE_TYPE != null){        for(int codeIdx=0; codeIdx < _dl_SERVICE_TYPE.getRowCount(); codeIdx++){            String code = _dl_SERVICE_TYPE.getString(codeIdx, ConstantHolder.CODE_COLUMN_CODE);            String name = _dl_SERVICE_TYPE.getString(codeIdx, ConstantHolder.CODE_COLUMN_NAME);            out.println("<option VALUE=\""+code+"\">"+name+"</option>\r\n");        }    }%></select> --%>
	<ub:code-select id="SERVICE_TYPE" codeCategory="APMD_SERVICE_TYPE" style="width:120px;" blankType="2" essential="true"/>
</td>
</tr>
<tr id="layout-1_2">
<th id="layout-1_2_5"><label class="ub-control label"><ub:message code="label.APM.paging.yn" text="페이징여부"/></label></th>
<td id="layout-1_2_6">
	<%-- <select id="PAGING_YN" name="PAGING_YN" class="ub-control select "     style="width:170px;" size="1" datacid="FLAG_YN"><%    if(!"".equals("")){        out.println("<OPTION VALUE=\"\"></OPTION>\r\n");    }    if(_dl_FLAG_YN != null){        for(int codeIdx=0; codeIdx < _dl_FLAG_YN.getRowCount(); codeIdx++){            String code = _dl_FLAG_YN.getString(codeIdx, ConstantHolder.CODE_COLUMN_CODE);            String name = _dl_FLAG_YN.getString(codeIdx, ConstantHolder.CODE_COLUMN_NAME);            out.println("<option VALUE=\""+code+"\">"+name+"</option>\r\n");        }    }%></select> --%>
	<ub:code-select id="PAGING_YN" codeCategory="FLAG_YN" style="width:170px;" blankType="0"/>
</td>
<th id="layout-1_2_7"><label class="ub-control label"><ub:message code="label.APM.find.cond.save.yn" text="검색이력 저장 여부"/></label></th>
<td id="layout-1_2_8">
	<%-- <select id="FIND_COND_SAVE_YN" name="FIND_COND_SAVE_YN" class="ub-control select "     style="width:120px;" size="1" datacid="FLAG_YN"><%    if(!"".equals("")){        out.println("<OPTION VALUE=\"\"></OPTION>\r\n");    }    if(_dl_FLAG_YN != null){        for(int codeIdx=0; codeIdx < _dl_FLAG_YN.getRowCount(); codeIdx++){            String code = _dl_FLAG_YN.getString(codeIdx, ConstantHolder.CODE_COLUMN_CODE);            String name = _dl_FLAG_YN.getString(codeIdx, ConstantHolder.CODE_COLUMN_NAME);            out.println("<option VALUE=\""+code+"\">"+name+"</option>\r\n");        }    }%></select> --%>
	<ub:code-select id="FIND_COND_SAVE_YN" codeCategory="FLAG_YN" style="width:120px;" blankType="0"/>
</td>
</tr>
<tr id="layout-1_3">
<th id="layout-1_3_9"><label class="ub-control label"><ub:message code="label.APM.paging.count" text="페이징 건수"/></label></th>
<td id="layout-1_3_10"><input type=text  class="ub-control input-text " id="PAGING_COUNT" name="PAGING_COUNT" maxLength="4" metalength="4"                   onkeypress="allowOnly('0..9');"      style="ime-mode:disabled;text-align:left;width:156px;"></td>
<td id="layout-1_3_11"></td>
<td id="layout-1_3_12"></td>
</tr>
<tr id="layout-1_4">
<th id="layout-1_4_13"><label class="ub-control label"             for="SERVICE_NAME"><ub:message code="label.APM.service.name" text="서비스명"/></label></th>
<td id="layout-1_4_14"><input type=text  class="ub-control input-text " id="SERVICE_NAME" name="SERVICE_NAME" maxLength="100" metalength="100"            metaessential="1"           style="text-align:left;width:400px;"></td>
<th id="layout-1_4_15"><label id="prtdRsrcYn" name="prtdRsrcYn" class="ub-control label"             for="IS_PROTECTED_RESOURCE"><ub:message code="label.APM.protected.resource.yn" text="보호된 자원 여부"/></label></th>
<td id="layout-1_4_16">
	<%-- <select id="IS_PROTECTED_RESOURCE" name="IS_PROTECTED_RESOURCE" class="ub-control select "     style="width:120px;" size="1" datacid="FLAG_YN"><%    if(!"선택안됨".equals("")){        out.println("<OPTION VALUE=\"\">선택안됨</OPTION>\r\n");    }    if(_dl_FLAG_YN != null){        for(int codeIdx=0; codeIdx < _dl_FLAG_YN.getRowCount(); codeIdx++){            String code = _dl_FLAG_YN.getString(codeIdx, ConstantHolder.CODE_COLUMN_CODE);            String name = _dl_FLAG_YN.getString(codeIdx, ConstantHolder.CODE_COLUMN_NAME);            out.println("<option VALUE=\""+code+"\">"+name+"</option>\r\n");        }    }%></select> --%>
	<ub:code-select id="IS_PROTECTED_RESOURCE" codeCategory="FLAG_YN" style="width:120px;" blankType="0"/>
</td>
</tr>
<tr id="layout-1_5">
<th id="layout-1_5_17" style=' vertical-align:Top'><label class="ub-control label"><ub:message code="label.APM.description" text="설명"/></label></th>
<td id="layout-1_5_18" colspan=3><textarea class="ub-control textarea " id="DESCRIPTION" name="DESCRIPTION"  metalength="1000"      style="width:412px;" rows="5"                  rows="5"></textarea></td>
</tr>
</tbody>
</table>
 
</div>

<div class="ub-layout details">
<h2 class="ub-control title"><ub:message code="title.APM0036.component" text="컴포넌트"/></h2>
<table class="ub-control table normal " id="tblComponent">
<colgroup>
<col width="150px"/>
<col width="450px"/>
<col width="150px"/>
<col />
</colgroup>
<tbody>
<tr id="layout-1_1">
<th id="layout-1_1_1"><label class="ub-control label"             for="CALL_TYPE"><ub:message code="label.APM.call.type" text="호출유형"/></label></th>
<td id="layout-1_1_2">
	<%-- <select id="CALL_TYPE" name="CALL_TYPE" class="ub-control select "     style="width:120px;" size="1" datacid="APMD_CALL_TYPE"      metaessential="1"><%    if(!"선택안됨".equals("")){        out.println("<OPTION VALUE=\"\">선택안됨</OPTION>\r\n");    }    if(_dl_CALL_TYPE != null){        for(int codeIdx=0; codeIdx < _dl_CALL_TYPE.getRowCount(); codeIdx++){            String code = _dl_CALL_TYPE.getString(codeIdx, ConstantHolder.CODE_COLUMN_CODE);            String name = _dl_CALL_TYPE.getString(codeIdx, ConstantHolder.CODE_COLUMN_NAME);            out.println("<option VALUE=\""+code+"\">"+name+"</option>\r\n");        }    }%></select> --%>
	<ub:code-select id="CALL_TYPE" codeCategory="APMD_CALL_TYPE" style="width:120px;" blankType="2" essential="true"/>
</td>
<th id="layout-1_1_3"><label class="ub-control label"><ub:message code="label.APM.login.check.yn" text="로그인 체크 여부"/></label></th>
<td id="layout-1_1_4"><input class="ub-control input-checkbox" type="checkbox" id="chkLoginYn" name="chkLoginYn"    checked><label></label></input><input type=hidden id="loginChkYn" name="loginChkYn"    value="Y"></td>
</tr>
<tr id="layout-1_2">
<th id="layout-1_2_5"><label class="ub-control label"><ub:message code="label.APM.attach.yn" text="첨부파일 지원여부"/></label></th>
<td id="layout-1_2_6">
	<%-- <select id="HAS_LINKED_FILE" name="HAS_LINKED_FILE" class="ub-control select "     style="width:120px;" size="1" datacid="FLAG_YN"><%    if(!"".equals("")){        out.println("<OPTION VALUE=\"\"></OPTION>\r\n");    }    if(_dl_FLAG_YN != null){        for(int codeIdx=0; codeIdx < _dl_FLAG_YN.getRowCount(); codeIdx++){            String code = _dl_FLAG_YN.getString(codeIdx, ConstantHolder.CODE_COLUMN_CODE);            String name = _dl_FLAG_YN.getString(codeIdx, ConstantHolder.CODE_COLUMN_NAME);            out.println("<option VALUE=\""+code+"\">"+name+"</option>\r\n");        }    }%></select> --%>
	<ub:code-select id="HAS_LINKED_FILE" codeCategory="FLAG_YN" style="width:120px;" blankType="0"/>
</td>
<th id="layout-1_2_7"><label class="ub-control label"><ub:message code="label.APM.event.induce" text="이벤트 유발여부"/></label></th>
<td id="layout-1_2_8">
	<%-- <select id="IS_INDUCED_EVENT" name="IS_INDUCED_EVENT" class="ub-control select "     style="width:120px;" size="1" datacid="FLAG_YN"><%    if(!"".equals("")){        out.println("<OPTION VALUE=\"\"></OPTION>\r\n");    }    if(_dl_FLAG_YN != null){        for(int codeIdx=0; codeIdx < _dl_FLAG_YN.getRowCount(); codeIdx++){            String code = _dl_FLAG_YN.getString(codeIdx, ConstantHolder.CODE_COLUMN_CODE);            String name = _dl_FLAG_YN.getString(codeIdx, ConstantHolder.CODE_COLUMN_NAME);            out.println("<option VALUE=\""+code+"\">"+name+"</option>\r\n");        }    }%></select> --%>
	<ub:code-select id="IS_INDUCED_EVENT" codeCategory="FLAG_YN" style="width:120px;" blankType="0"/>
</td>
</tr>
<tr id="layout-1_3">
<th id="layout-1_3_9"><label class="ub-control label"><ub:message code="label.APM.class.name" text="클래스명"/></label></th>
<td id="layout-1_3_10" colspan=3><input type=text  class="ub-control input-text " id="CLASS_NAME" name="CLASS_NAME" maxLength="1000" metalength="1000"                       style="text-align:left;width:400px;"></td>
</tr>
<tr id="layout-1_4">
<th id="layout-1_4_11"><label class="ub-control label"><ub:message code="label.APM.method.name" text="메소드명"/></label></th>
<td id="layout-1_4_12" colspan=3><input type=text  class="ub-control input-text " id="METHOD_NAME" name="METHOD_NAME" maxLength="200" metalength="200"                       style="text-align:left;width:400px;"></td>
</tr>
<tr id="layout-1_5">
<th id="layout-1_5_13"><label class="ub-control label"             for="LINKED_WORK_CATEGORY"><ub:message code="label.APM.work.category" text="업무유형"/></label></th>
<td id="layout-1_5_14" colspan=3>
	<%-- <select id="LINKED_WORK_CATEGORY" name="LINKED_WORK_CATEGORY" class="ub-control select "     style="width:120px;" size="1" datacid="WORK_CATEGORY"><%    if(!"선택안됨".equals("")){        out.println("<OPTION VALUE=\"\">선택안됨</OPTION>\r\n");    }    if(_dl_WORK_CATEGORY != null){        for(int codeIdx=0; codeIdx < _dl_WORK_CATEGORY.getRowCount(); codeIdx++){            String code = _dl_WORK_CATEGORY.getString(codeIdx, ConstantHolder.CODE_COLUMN_CODE);            String name = _dl_WORK_CATEGORY.getString(codeIdx, ConstantHolder.CODE_COLUMN_NAME);            out.println("<option VALUE=\""+code+"\">"+name+"</option>\r\n");        }    }%></select> --%>
	<ub:code-select id="LINKED_WORK_CATEGORY" codeCategory="WORK_CATEGORY" style="width:120px;" blankType="2"/>
</td>
</tr>
<tr id="layout-1_6">
<th id="layout-1_6_15"><label class="ub-control label"><ub:message code="label.APM.workflow.category" text="업무활동"/></label></th>
<td id="layout-1_6_16" colspan=3>
	<%-- <select id="LINKED_ACTIVITY_TYPE" name="LINKED_ACTIVITY_TYPE" class="ub-control select "     style="width:120px;" size="1" datacid="WORKFLOW_ACTIVITY"><%    if(!"선택안됨".equals("")){        out.println("<OPTION VALUE=\"\">선택안됨</OPTION>\r\n");    }    if(_dl_WORKFLOW_ACTIVITY != null){        for(int codeIdx=0; codeIdx < _dl_WORKFLOW_ACTIVITY.getRowCount(); codeIdx++){            String code = _dl_WORKFLOW_ACTIVITY.getString(codeIdx, ConstantHolder.CODE_COLUMN_CODE);            String name = _dl_WORKFLOW_ACTIVITY.getString(codeIdx, ConstantHolder.CODE_COLUMN_NAME);            out.println("<option VALUE=\""+code+"\">"+name+"</option>\r\n");        }    }%></select> --%>
	<ub:code-select id="LINKED_ACTIVITY_TYPE" codeCategory="WORKFLOW_ACTIVITY" style="width:120px;" blankType="2"/>
</td>
</tr>
</tbody>
</table>
 
</div>

<div class="ub-layout details">
<h2 class="ub-control title"><ub:message code="title.APM0036.encrypt" text="암호화"/></h2>
<table class="ub-control table normal ">
<colgroup>
<col width="150px"/>
<col />
</colgroup>
<tbody>
<tr id="layout-1_1">
<th id="layout-1_1_1" style=' vertical-align:Top'><label class="ub-control label"><ub:message code="label.APM.target.column" text="대상컬럼"/></label></th>
<td id="layout-1_1_2"><textarea class="ub-control textarea " id="ENCRYPT_COLUMNS" name="ENCRYPT_COLUMNS"  metalength="2000"      style="width:412px;" rows="5"                  rows="5"></textarea><label class="ub-control label"><br><ub:message code="label.APM0036.encrypt.info" text="* 대상컬럼 구분자는 , 또는 엔터로 구분하세요."/></label></td>
</tr>
</tbody>
</table>
 
</div>
<div class="ub-layout button bottom"  style="text-align:right;"><span class="ub-control button bottom icon" id="btnInsert"        title="저장">
    <a href="#none" title="Save"><span class="ico-save"></span><ub:message code="button.common.save" text="저장"/></a>
</span>
</div>

<!-- layout-1 End -->
</form>

<script type="text/javascript">
uxl.onLoad(function(){
	$("#tblSvcInfo #layout-1_2").hide();
	$("#tblSvcInfo #layout-1_3").hide();
	$("#tblComponent #layout-1_3").hide();
	$("#tblComponent #layout-1_4").hide();
	$("#tblComponent #layout-1_5").hide();
	$("#tblComponent #layout-1_6").hide();
	
	hsqlData.getCategoryCode("CATEGORY_CODE", {blankOption:"선택안됨"});
	
	$("#IS_PROTECTED_RESOURCE").val('N');
	$("#PAGING_YN").val('N');
	$("#FIND_COND_SAVE_YN").val('N');
	$("#HAS_LINKED_FILE").val('N');
	$("#IS_INDUCED_EVENT").val('N');
	
	$('#btnList').click(function() {
		uxl.returnToList('APM0005');
	});

	$('#btnInsert').click(function() {
		insertService();
	});
	
	// 호출유형 변경시
	$('#CALL_TYPE').change(function() {
		if ($(this).val() == "C") {
			$("#tblComponent #layout-1_3").show();
			$("#tblComponent #layout-1_4").show();
			
			$("#CLASS_NAME").attr("metaessential", "1");
			$("#METHOD_NAME").attr("metaessential", "1");
		} else {
			$("#tblComponent #layout-1_3").hide();
			$("#tblComponent #layout-1_4").hide();

			$("#CLASS_NAME").attr("metaessential", "");
			$("#METHOD_NAME").attr("metaessential", "");
		}
		uxl.displayRequired();
	});
		
	// 서비스유형 변경시
	$('#SERVICE_TYPE').change(function() {
		if ($(this).val() == "R") {
			$("#tblSvcInfo #layout-1_2").show();
			
			if ($('#PAGING_YN').val() == "Y") {
				$("#PAGING_COUNT").val(10);
				$("#tblSvcInfo #layout-1_3").show();
			}
		} else {
			$("#tblSvcInfo #layout-1_2").hide();
			$("#tblSvcInfo #layout-1_3").hide();
		}
	});
	
	// 페이징여부 변경시
	$('#PAGING_YN').change(function() {
		if ($(this).val() == "Y") {
			$("#tblSvcInfo #layout-1_3").show();
			$("#PAGING_COUNT").val(10);
		} else {
			$("#tblSvcInfo #layout-1_3").hide();
			$("#PAGING_COUNT").val(null);
		}
	});
	
	// 첨부파일 지원여부, 이벤트 유발여부 변경시
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
		
		uxl.displayRequired();
	});
	
	$("#chkLoginYn").change(function() {
		$("#loginChkYn").val(((this.checked) ? "Y" : "N"));
	});
});

// 서비스 등록
function insertService() {
	// 앞뒤 스페이스 제거
	$("input[type='text'], textarea").each(function() {
		var value = $(this).val();
		$(this).val($.trim(value));
	});
	
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
		  	var svcId = result.getResultKey();
		  	var returnData = {"SERVICE_ID" : svcId.toString(), "SERVICE_NAME" : $('#SERVICE_NAME').val()};
		  	uxl.pushToParent(returnData);
		  	window.close();
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


</script>