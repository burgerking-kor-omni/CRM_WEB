<%--
#*
 *  파 일 명 :  APP0003.jsp
 *  설    명 :  결재상신등록
 *  작 성 자 :  유기태
 *  작 성 일 :  2013.11.29
 *  버    전 :  1.0
 *  기타사항 :
 *  Copyrights 2011 by ㈜ 유비원. All right reserved.
*#
--%>
<%@page import="com.ubone.framework.util.ViewUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/include/pageCommon.jsp" %>
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
	DataList _dl_ApprovalInquiry_getApprovalSubmitData = ViewUtil.getResult().getDataList("ApprovalInquiry.getApprovalSubmitData");
%>


<!--  ========================================================================
  This page is generated with the UB-META™ ver4.0 
 
   - PAGE ID : APP0003R00
   - PAGE TYPE : JSP
 
  Copyright ⓒ UBONE Co., Ltd. All rights reserved.
 ========================================================================
--> 


<!-- layout-1 Start -->
<h1 class="ub-control title">결재 상신</h1>
<form id="APPROVAL_FORM" name="APPROVAL_FORM"><div class="ub-layout details"><h2 class="ub-control title">결재경로 지정 </h2>
<table class="ub-control table normal ">
<colgroup>
<col width="20%"/>
<col />
</colgroup>
<tbody>
<tr id="layout-1_1">
<th id="layout-1_1_1"><label class="ub-control label">결재자 지정</label></th>
<td id="layout-1_1_2"><input type=text  class="ub-control input-text " id="NM_USER" name="NM_USER"                       style="text-align:left;width:100px;"><a href="#none" title="search" class="ub-control button imgBtn img-search" id="SEARCH_LINE" name="SEARCH_LINE"><span>결재자 지정</span></a><span class="ub-control button inner icon" id="BTN_APPR_LINE">    <a href="#none" title="결재선"><span></span>결재선</a></span><input type=hidden id="USER_ID" name="USER_ID"    value="<%=JspUtils.getDefaultValue(_dl_ApprovalInquiry_getApprovalSubmitData, "USER_ID") %>"><input type=hidden id="USER_NM" name="USER_NM"    value="<%=JspUtils.getDefaultValue(_dl_ApprovalInquiry_getApprovalSubmitData, "USER_NM") %>"><input type=hidden id="DEPT_NM" name="DEPT_NM"    value="<%=JspUtils.getDefaultValue(_dl_ApprovalInquiry_getApprovalSubmitData, "DEPT_NM") %>"><input type=hidden id="DEPT_ID" name="DEPT_ID"    value="<%=JspUtils.getDefaultValue(_dl_ApprovalInquiry_getApprovalSubmitData, "DEPT_ID") %>"><input type=hidden id="POSITION_CD" name="POSITION_CD"    value="<%=JspUtils.getDefaultValue(_dl_ApprovalInquiry_getApprovalSubmitData, "POSITION_CD") %>"><input type=hidden id="CODE_NAME" name="CODE_NAME"    value="<%=JspUtils.getDefaultValue(_dl_ApprovalInquiry_getApprovalSubmitData, "CODE_NAME") %>"><input type=hidden id="CD_LEVEL" name="CD_LEVEL"    value="<%=JspUtils.getDefaultValue(_dl_ApprovalInquiry_getApprovalSubmitData, "CD_LEVEL") %>"><input type=hidden id="DUTY_CD" name="DUTY_CD"    value="<%=JspUtils.getDefaultValue(_dl_ApprovalInquiry_getApprovalSubmitData, "DUTY_CD") %>"><input type=hidden id="DUTY_NM" name="DUTY_NM"    value="<%=JspUtils.getDefaultValue(_dl_ApprovalInquiry_getApprovalSubmitData, "DUTY_NM") %>"></td>
</tr>
<tr id="layout-1_2">
<th id="layout-1_2_3"><label class="ub-control label"             for="LINE">결재경로</label></th>
<td id="layout-1_2_4"><div class="ub-layout floatBox"><div class="ub-layout leftBox"><select id="LINE" name="LINE" multiple class="ub-control select-multiple"     style="width:400px;"  size="6"         metaessential="1"></select></div><div class="ub-layout rightBox"><a href="#none" title="삭제" class="ub-control button imgBtn img-minus" id="DELETE_LINE" name="DELETE_LINE"><span></span></a><a href="#none" title="위" class="ub-control button imgBtn img-up" id="UP_LINE" name="UP_LINE"><span></span></a><a href="#none" title="아래" class="ub-control button imgBtn img-down" id="DOWN_LINE" name="DOWN_LINE"><span></span></a></div></div></td>
</tr>
</tbody>
</table>
 
<h2 class="ub-control title">결재 정보</h2>
<table class="ub-control table normal ">
<colgroup>
<col width="20%"/>
<col />
</colgroup>
<tbody>
<tr id="layout-1_1">
<th id="layout-1_1_1"><label class="ub-control label"             for="DS_TITLE_APPR">제목</label></th>
<td id="layout-1_1_2"><input type=text  class="ub-control input-text " id="DS_TITLE_APPR" name="DS_TITLE_APPR"            metaessential="1"           style="text-align:left;width:568px;"><input type=hidden id="ID_BIZ_KEY" name="ID_BIZ_KEY"    value="${paramMap.ID_BIZ_KEY}"><input type=hidden id="ID_BIZ_KEY_ETC" name="ID_BIZ_KEY_ETC"    value="${paramMap.ID_BIZ_KEY_ETC}"><input type=hidden id="TP_BIZ" name="TP_BIZ"    value="${paramMap.TP_BIZ}"><input type=hidden id="TP_FLAG" name="TP_FLAG"    value="${paramMap.TP_FLAG}"></td>
</tr>
<tr id="layout-1_2">
<th id="layout-1_2_3"><label class="ub-control label"             for="DS_APPR">내용</label></th>
<td id="layout-1_2_4"><textarea class="ub-control textarea " id="DS_APPR" name="DS_APPR"       style="width:580px;" rows="5"      metaessential="1"            rows="5"></textarea></td>
</tr>
<tr id="layout-1_3">
<th id="layout-1_3_5"><label class="ub-control label">담당자 의견</label></th>
<td id="layout-1_3_6"><textarea class="ub-control textarea " id="DS_COMMENT" name="DS_COMMENT"       style="width:580px;" rows="5"                  rows="5"></textarea></td>
</tr>
<tr id="layout-1_4">
<th id="layout-1_4_7"><label class="ub-control label">첨부파일</label></th>
<td id="layout-1_4_8"><div class="ub-control temp" style="border:2px solid gray;width:100%;height:80px;text-align:center;"><h3 style="padding-top:30px;padding-left:10px;padding-right:10px;">Attach File Control</h3></div><span class="ub-control attachFile">   	<div class="filefieldset" id='uploadedFiles_FILE'></div>   	<div class="filefieldset" id='uploadProgress_FILE' style="display:none;">   		<span class="legend">Uploading...</span>   	</div>	<span id='btnUpload_FILE'></span> </span></td>
</tr>
</tbody>
</table>
 
</div>
</form>
<div class="ub-layout button bottom"><span class="ub-control button bottom icon" id="APPR_SUBMIT">
    <a href="#none" title="기안"><span></span>기안</a>
</span>
</div>

<!-- layout-1 End -->


<style type="text/css">
	select, select.select {height:57px;}
</style>
<script type="text/javascript" charset="UTF-8" src="<spring:url value='/page/js/vocCommon.js'/>"></script>

<script type="text/javascript">

uxl.onLoad(function(){
	
	// 결재라인 검색
	$('#SEARCH_LINE').click(function(){
		uxl.openWindow('PopupCorp', uxl.getScreenURL('APP0004')+ '?NM_USER='+$("#NM_USER").val(), {width:'980px' ,height:'589px'} ,callBackLine);
	});
	
	// 선택한 열 삭제
	$('#DELETE_LINE').click(function(){
		if($('#LINE option:selected').attr('id') != "REPOTER"){		// 기안자는 삭제하지 못함
			$('#LINE option:selected').remove();
		}else{
			uxl.showMessage(uxl.getMessage('message.common.apprDel.error'));
		}
	});	
	
	// 선택한 열 위로
	$('#UP_LINE').click(function() {
		var opt = $('#LINE option:selected');
		if($('#LINE :eq(1)').val()!=opt.val()){	// 기안자보다 위로 못올라옴
			if(opt.size() == 1) {					// 한개만 움직일 수 있음
				opt.insertBefore(opt.prev());
			}else{
				alert("하나만 움직일 수 있습니다.");
			}
		}else{
			alert("기안자보다 먼저 올 수 없습니다.");
		}
	});
	
	// 선택한 열 아래로
	$('#DOWN_LINE').click(function() {
		if($('#LINE option:selected').attr('id') != "REPOTER"){		// 기안자는 아래로 못내림
			var opt = $('#LINE option:selected');
			if(opt.size() == 1) {					// 한개만 움직일 수 있음
				opt.insertAfter(opt.next());
			}else{
				alert("하나만 움직일 수 있습니다.");
			}
		}else{
			alert("기안자는 경로 상단에 있어야 합니다.");
		}
	});

	//저장
	$('#APPR_SUBMIT').click(function(){
		fnSave();
	});
	
	//Enter Key 이벤트
	$('#DS_TITLE_APPR').keydown(function(event) {
		if(event.keyCode == '13') {
			$('#DS_APPR').focus();
			return false;
		}
	});
	
	//Enter Key 이벤트
	$('#NM_USER').keydown(function(event) {
		if(event.keyCode == '13') {
			uxl.openWindow('PopupCorp', uxl.getScreenURL('APP0004')+ '?NM_USER='+$("#NM_USER").val(), {width:'980px' ,height:'589px'} ,callBackLine);    
			return false;
		}
	});
	
	uxl.ext.Upload('FILE');
	
	// 결재선 조회
	$('#BTN_APPR_LINE').click(function(){
		uxl.openWindow('PopApprLine', uxl.getScreenURL('APP0010'), { width:'800px' ,height:'392px'}, callBackLine_select);	
	});
	
	//개선과제 제목 및 내용 초기입력
	//1. 제목
	$('#DS_TITLE_APPR').val($('#DS_TITLE_PROJ',opener.document).val());
	//2. 내용
	$('#DS_APPR').val($('#DS_CONT_PROJ',opener.document).val());
});

//기안등록
function fnSave() {
	// 모든 결재라인 선택
	$('#LINE > option').attr('selected', 'selected');

	//2014.04.15 개선과제 계획결제/완료결제 구분값
	var tpBiz = $('#TP_BIZ').val();
	var tpFlag = $('#TP_FLAG').val();
	var issueStatus = '';
	
	if(tpBiz == '04'){
		if(tpFlag == 'R1'){
			issueStatus = "R1";
		}else if(tpFlag == 'P1'){
			issueStatus = "P1";
		}	
	}
	
	// 결재라인이 기안자뿐이면 리턴
	if($("#LINE option").size()==1){
		uxl.showMessage(uxl.getMessage('message.common.validation.noselect','결재라인'));
		return;
	}			
	
	//필수정보 체크
	var url = uxl.getFunctionUrl(_SCREEN_ID,'REGIST');
	var option = {
			
			  // 첫 등록시 기본값 설정(TP_BIZ, TP_APPR, TP_STATUS_APPR, FG_DEL, TP_APPR_PROC)
			  data:{TP_APPR:'01',TP_STATUS_APPR:'01',FG_DEL:'N',TP_APPR_PROC:'02'}
			, validator:function(data,targetForm){
					var returnVal = false;
					//필수항목체크
					if(uxl.checkRequiredFields(targetForm)){
						returnVal = true;
					}
					
					return returnVal;
			}
			, success:function(result){
				// 팝업닫고 상신목록으로 화면전환
				//var url = '/screen/APP0001.ub'; 
				//if(uxl.isScreenId(url)) {
				//	url = uxl.getScreenURL(url);
				//}
				//opener.$("#bodyiframe").attr('src',url);
				//opener.iframeResize(1);
				//uxl.close();
				if(tpBiz == '04'){
					//2014.04.15 개선과제화면으로 넘기는 플래그 값. 
// 					uxl.pushToParent(issueStatus);
					opener.callBackAppData(issueStatus);
					self.close();	
				}else if(tpBiz == '11'){
					//report
					uxl.reload(opener.document);
					self.close();
				}
				
			}
			, async:true
			, message : {
				 confirm : uxl.getMessage('@message.common.apprSubmit.confirm'),
				 success : uxl.getMessage('@message.common.apprSubmit.success'),
				 fail : uxl.getMessage('@message.common.apprSubmit.fail')
			  }
	};
	uxl.callSubmitFunction('APPROVAL_FORM' , url , option );
}

// 콜백(결재라인)
function callBackLine(apprList){
	var lineTxt="";
	var lineVal="";
	
	// 기안작성자 결재경로에 추가
	if($("#LINE option").size()==0){
		var myLineVal="01"+"|"+$("#USER_ID").val()+"|"+$("#DUTY_CD").val()+"|"+$("#DEPT_ID").val();
		var myLineTxt="기안"+"/"+$("#DEPT_NM").val()+"/("+$("#DUTY_NM").val() +")"+ $("#USER_NM").val();
		$("#LINE").append("<option value='"+myLineVal+"' id='REPOTER'>"+myLineTxt+"</option>");
	}
	
	// 추가된 결재자들 결재경로에 추가
	for(var i=0; i<apprList.SEQ_APPR.length;i++){
		lineVal=apprList.TP_APPR_LINE[i]+"|"+apprList.ID_EMP[i]+"|"+apprList.DUTY_CD[i]+"|"+apprList.ID_DEPT[i];
		
		if(apprList.TP_APPR_LINE[i]=='03')
			lineTxt="합의/"+apprList.NM_DEPT[i]+"/("+apprList.DUTY_NM[i]+")"+apprList.NM_EMP[i];		
		else		
			lineTxt="결재/"+apprList.NM_DEPT[i]+"/("+apprList.DUTY_NM[i]+")"+apprList.NM_EMP[i];		
		
		$('#LINE').append("<option value='"+lineVal+"'>"+lineTxt+"</option>");
	}
}

//콜백(결재선 선택시 결재경로를 지우고 새로 지정한다.)
function callBackLine_select(apprList){
	var lineTxt="";
	var lineVal="";
	
	$('#LINE option').remove();
	
	// 기안작성자 결재경로에 추가
	if($("#LINE option").size()==0){
		var myLineVal="01"+"|"+$("#USER_ID").val()+"|"+$("#DUTY_CD").val()+"|"+$("#DEPT_ID").val();
		var myLineTxt="기안"+"/"+$("#DEPT_NM").val()+"/("+$("#DUTY_NM").val() +")"+ $("#USER_NM").val();
		$("#LINE").append("<option value='"+myLineVal+"' id='REPOTER'>"+myLineTxt+"</option>");
	}
	
	// 추가된 결재자들 결재경로에 추가
	for(var i=0; i<apprList.SEQ_APPR.length;i++){
		lineVal=apprList.TP_APPR_LINE[i]+"|"+apprList.ID_EMP[i]+"|"+apprList.DUTY_CD[i]+"|"+apprList.ID_DEPT[i];
		
		if(apprList.TP_APPR_LINE[i]=='03')
			lineTxt="합의/"+apprList.NM_DEPT[i]+"/("+apprList.DUTY_NM[i]+")"+apprList.NM_EMP[i];		
		else		
			lineTxt="결재/"+apprList.NM_DEPT[i]+"/("+apprList.DUTY_NM[i]+")"+apprList.NM_EMP[i];		
		
		$('#LINE').append("<option value='"+lineVal+"'>"+lineTxt+"</option>");
	}
}
</script>