<%--
#*
 *  파 일 명 :  APP0006.jsp
 *  설    명 :  나의 결재 - 진행
 *  작 성 자 :  최소정
 *  작 성 일 :  2013.11.29
 *  버    전 :  1.0
 *  기타사항 :
 *  Copyrights 2011 by ㈜ 유비원. All right reserved.
*#
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/include/pageCommon.jsp" %>
<%@ include file="/WEB-INF/jsp/include/pageTagLibs.jsp"%>
<%@ page import="com.ubone.framework.util.ViewUtil"%>
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
	DataList _dl_ApprovalInquiry_getMyApproveDetail = ViewUtil.getResult().getDataList("ApprovalInquiry.getMyApproveDetail");
	DataList _dl_TP_APPR_PROC = ViewUtil.getResult().getDataList("Code.TP_APPR_PROC");
%>


<!--  ========================================================================
  This page is generated with the UB-META™ ver4.0 
 
   - PAGE ID : APP0006R00
   - PAGE TYPE : JSP
 
  Copyright ⓒ UBONE Co., Ltd. All rights reserved.
 ========================================================================
--> 


<!-- layout-1 Start -->
<h1 class="ub-control title">결재 상세</h1>
<div class="ub-layout button top"><span class="ub-control button top icon" id="LIST_SEE">
    <a href="#none" title="목록"><span class="ico-list"></span>목록</a>
</span>
</div>
<form id="APP_ROOT_FORM" name="APP_ROOT_FORM"><h2 class="ub-control title">결재경로</h2>
<div class="ub-layout list"><div class="ub-control temp" style="border:2px solid gray;width:100%;height:300px;text-align:center;"><h3 style="padding-top:120px;">Grid Control</h3></div>
<table class="ub-control grid" id="APP_ROOT" name="APP_ROOT"></table> 
	
</div>
<h2 class="ub-control title" id="marginTitle" name="marginTitle">결재내용</h2>
<div class="ub-layout details"><table class="ub-control table normal ">
<colgroup>
<col />
<col />
</colgroup>
<tbody>
<tr id="layout-1_1">
<th id="layout-1_1_1"><label class="ub-control label">제목</label></th>
<td id="layout-1_1_2"><input type=text  class="ub-control input-text " id="DS_TITLE_APPR" name="DS_TITLE_APPR"       value="<%=JspUtils.getDefaultValue(_dl_ApprovalInquiry_getMyApproveDetail, "DS_TITLE_APPR") %>"                style="text-align:left;width:588px;"   disabled><input type=hidden id="ID_APPR" name="ID_APPR"    value="${paramMap.ID_APPR}"><input type=hidden id="ID_APPR_DTL" name="ID_APPR_DTL"    value="${paramMap.ID_APPR_DTL}"><input type=hidden id="SEQ_APPR" name="SEQ_APPR"    value="<%=JspUtils.getDefaultValue(_dl_ApprovalInquiry_getMyApproveDetail, "SEQ_APPR") %>"><input type=hidden id="ID_VOC" name="ID_VOC"    value="<%=JspUtils.getDefaultValue(_dl_ApprovalInquiry_getMyApproveDetail, "ID_VOC") %>"><input type=hidden id="ID_SUB_VOC" name="ID_SUB_VOC"    value="<%=JspUtils.getDefaultValue(_dl_ApprovalInquiry_getMyApproveDetail, "ID_SUB_VOC") %>"><input type=hidden id="TP_BIZ" name="TP_BIZ"    value="<%=JspUtils.getDefaultValue(_dl_ApprovalInquiry_getMyApproveDetail, "TP_BIZ") %>"><span class="ub-control button inner icon" id="reportPop">    <a href="#none" title="Report 보기"><span></span>Report 보기</a></span><input type=hidden id="ID_BIZ_KEY" name="ID_BIZ_KEY"    value="<%=JspUtils.getDefaultValue(_dl_ApprovalInquiry_getMyApproveDetail, "ID_VOC") %>"><input type=hidden id="ID_ISSUE" name="ID_ISSUE"    value="${paramMap.ID_ISSUE}"></td>
</tr>
<tr id="layout-1_2">
<th id="layout-1_2_3"><label class="ub-control label">상태</label></th>
<td id="layout-1_2_4"><select id="TP_APPR_PROC" name="TP_APPR_PROC" class="ub-control select "     style="width:120px;" size="1" datacid="TP_APPR_PROC" defaultvalue="<%=JspUtils.getDefaultValue(_dl_ApprovalInquiry_getMyApproveDetail, "TP_APPR_PROC") %>"              disabled><%    if(!"".equals("")){        out.println("<OPTION VALUE=\"\"></OPTION>\r\n");    }    if(_dl_TP_APPR_PROC != null){        for(int codeIdx=0; codeIdx < _dl_TP_APPR_PROC.getRowCount(); codeIdx++){            String code = _dl_TP_APPR_PROC.getString(codeIdx, ConstantHolder.CODE_COLUMN_CODE);            String name = _dl_TP_APPR_PROC.getString(codeIdx, ConstantHolder.CODE_COLUMN_NAME);            String selected = code.equals(JspUtils.getDefaultValue(_dl_ApprovalInquiry_getMyApproveDetail, "TP_APPR_PROC"))?"selected":"";            out.println("<option VALUE=\""+code+"\" "+selected+">"+name+"</option>\r\n");        }    }%></select></td>
</tr>
<tr id="layout-1_3">
<th id="layout-1_3_5"><label class="ub-control label">내용</label></th>
<td id="layout-1_3_6"><textarea class="ub-control textarea " id="DS_APPR" name="DS_APPR"       style="width:600px;" rows="5"                  rows="5" disabled><%=JspUtils.getDefaultValue(_dl_ApprovalInquiry_getMyApproveDetail, "DS_APPR") %></textarea></td>
</tr>
<tr id="layout-1_4">
<th id="layout-1_4_7"><label class="ub-control label">첨부파일</label></th>
<td id="layout-1_4_8"><div class="ub-control temp" style="border:2px solid gray;width:100%;height:80px;text-align:center;"><h3 style="padding-top:30px;padding-left:10px;padding-right:10px;">Attach File Control</h3></div><span class="ub-control attachFile">   	<div class="filefieldset" id='uploadedFiles_FILE'></div>   	<div class="filefieldset" id='uploadProgress_FILE' style="display:none;">   		<span class="legend">Uploading...</span>   	</div>	<span id='btnUpload_FILE'></span> </span></td>
</tr>
</tbody>
</table>
 
</div>
<div class="ub-layout button bottom"><span class="ub-control button bottom icon" id="BANRAE">
    <a href="#none" title="반려"><span></span>반려</a>
</span>
<span class="ub-control button bottom icon" id="APP_OK">
    <a href="#none" title="결재"><span></span>결재</a>
</span>
</div>
<div class="ub-control temp" style="border:2px solid gray;width:100%;height:50px;text-align:center;"><h3 style="padding:10px;">Tab Control</h3></div>
<div id="tabs" name="tabs" class="ub-control tab"></div>
</form>

<!-- layout-1 End -->


<%
// 	String tp_proj_1 = VocConstantHolder.CD_PROJ_1;
%>


<style type="text/css">
	#marginTitle {margin-top:15px;}
	.ui-jqgrid .ui-jqgrid-btable {cursor:default;}
</style>
<script type="text/javascript" charset="UTF-8" src="<spring:url value='/uxl/tab/uxl-tab-1.3.0.js'/>"></script>
<script type="text/javascript">
uxl.onLoad(function(){
	
	if($('#TP_BIZ').val() == '11'){
		// 리포트일 경우
		$('#WORK_DETAIL_SEARCH').hide();
		$('#reportPop').show();
	}else{
		$('#WORK_DETAIL_SEARCH').show();
		$('#reportPop').hide();
	}
	
	//목록으로 이동
	$('#LIST_SEE').click(function(){
		uxl.returnToList('APP0005');
	});
	
		
	//반려버튼 클릭
	$('#BANRAE').click(function(){		
		uxl.openWindow('PopupReturn',uxl.getScreenURL('APP0007')+"?ID_APPR="+$("#ID_APPR").val()+"&ID_APPR_DTL="+$("#ID_APPR_DTL").val()+"&TP_BIZ="+$("#TP_BIZ").val()+"&ID_VOC="+$("#ID_VOC").val(), { width:'500px' ,height:'183px' }, null);
	});
				
			
	//결재버튼 클릭
	$('#APP_OK').click(function(){
		uxl.openWindow('PopupAccept',uxl.getScreenURL('APP0011')+"?ID_APPR="+$("#ID_APPR").val()+"&ID_APPR_DTL="+$("#ID_APPR_DTL").val()+"&TP_BIZ="+$("#TP_BIZ").val(), { width:'500px' ,height:'183px' }, null);
	});
		
	//결재경로 Grid Control
	var options = {
		//header name
		colNames:['번호','직책','담당자','결재처리구분','부서명','처리일시','상세번호','의견']

		//mapping column
		,colModel:[
				  {name:'SEQ_APPR', width:5, align:'center', sorttype:'int'}  //번호
				 ,{name:'CD_DUTY', width:10, align:'center'}  //직위
				 ,{name:'ID_EMP_APPR', index:'who', width:10, align:'center'}  //담당자
				 ,{name:'TP_APPR_PROC', width:15, align:'center'} //결재처리구분
				 ,{name:'ID_DEPT', width:38, align:'left'}      //부서명
				 ,{name:'DT_ACT', width:18, align:'center'}       //결재일자
				 ,{name:'ID_APPR_DTL', width:0, align:'center', hidden:true} //상세번호
				 ,{name:'DS_COMMENT', width:60, align:'left'}  //의견
		]
		, width:966
		, height:80
		, gridComplete: function(){ //해당 결재자 row 색상바꾸기 
 			var ids = jQuery("#APP_ROOT").jqGrid('getDataIDs');
 			for(var i=0; i < ids.length; i++){
 				var cl = ids[i];			
			
 				if($('#SEQ_APPR').val()==$('#APP_ROOT').jqGrid('getRowData',cl)['SEQ_APPR']) 
 					jQuery("#APP_ROOT").jqGrid('setRowData',ids[i],$('#'+cl).css("background","#dcdcdc"));			
 				
 			}
 		}

	};
	uxl.grid('APP_ROOT', options);
	fnSearch();
	
	
	uxl.ext.Upload('FILE', {readOnly:true});
	
	//현재 로그인한 결재자가 합의자인지 여부에 따라 보이는 버튼을 달리한다.
	if($("#TP_APPR_LINE").val() == '03'){
		$('#BANRAE').hide();
		$('#APP_OK').hide();
	}else{
		$('#HABEE_OK').hide();
	}	
	
	//[결재 or 반려 or 합의] 처리 했을시 [반려/결재/합의] 버튼 숨기기
	if($("[name=TP_APPR_PROC]").val() == '03' || $("[name=TP_APPR_PROC]").val() == '04' || $("[name=TP_APPR_PROC]").val() == '05'){
		$('#BANRAE').hide();
		$('#APP_OK').hide();
		$('#HABEE_OK').hide();
		
		$('#DS_COMMENT').attr("disabled", "disabled");		
	}
	
	// 업무상세조회
// 	$('#WORK_DETAIL_SEARCH').click(function(){
// 		// VOC 일 경우
// 		if($('#TP_BIZ').val() == '01'){
// 			uxl.openWindow('PopVocDetail', uxl.getScreenURL('POP0023')+'?ID_VOC='+$('#ID_VOC').val()+'&ID_SUB_VOC='+$('#ID_SUB_VOC').val(), { width:'960px' ,height:'400px', scrollbars:'yes' });	
// 		}else{
// 			// 개선과제일 경우
// 			var url = uxl.getFunctionUrl(_SCREEN_ID,'USERDEFINED3');
// 			var options = {
// 					 data : {ID_ISSUE:$('#ID_BIZ_KEY').val()}
// 					,success : function(result){
// 						var dataSet = result.getDataList(0).rows;
						
<%-- 						if(dataSet[0].TP_PROJ_1 == '<%=tp_proj_1%>'){ --%>
// 							// VOC 개선과제
// 							uxl.openWindow('PopIssueDetail', uxl.getScreenURL('POP0070')+'?ID_ISSUE='+dataSet[0].ID_ISSUE, { width:'960px' ,height:'400px', scrollbars:'yes' });	
// 						}else{
// 							// 간담회 개선과제
// 							uxl.openWindow('PopIssueDetail', uxl.getScreenURL('POP0071')+'?ID_ISSUE='+dataSet[0].ID_ISSUE, { width:'960px' ,height:'400px', scrollbars:'yes' });
// 						}
// 					}
// 					,async : false
// 			};
// 			uxl.callFunction(url, options);
			
// 		}	
// 	});
	
	// report 조회
	$('#reportPop').click(function(){
		var url = uxl.getFunctionUrl(_SCREEN_ID,'USERDEFINED1');
		var options = {
				 data : {SEQ_REPORT:$('#ID_BIZ_KEY').val()}
				,success : function(result){
					var dataSet = result.getDataList(0).rows;
					var strURL = uxl.getContextURL("/uxl/ext/RexServer30/rexLotteReport.jsp?SEQ_REPORT="+dataSet[0].SEQ_REPORT+"&TP_REPORT="+dataSet[0].TP_REPORT);
					uxl.openWindow('PopupRexpert', strURL, { width:1024 ,height:668, scrollbars:'no',resizable:'yes' }, null);			
				}
				,async : false
		};
		uxl.callFunction(url, options);
	});
	
// 	var param = '?ID_ISSUE=' + $('#ID_ISSUE').val();
// 	var tab = new uxl.Tabs('tabs');
<%-- 	tab.add('ISS0001', '<%=request.getContextPath()%>' + '/screen/ISS0001.ub' + param, '개선과제', false);		//VOC이력 --%>
// 	$(window).resize(function(){
// 		tab.resize(170);
// 	}).trigger('resize');
	
});

//결재경로 조회
function fnSearch(){
	
	//필수정보 체크
	var url = uxl.getFunctionUrl(_SCREEN_ID,'USERDEFINED2');
	var option = {
			  data:{}
			, validator:function(data,targetForm){
					var returnVal = false;			
					
					//필수항목체크
					if(uxl.checkRequiredFields(targetForm)){
						returnVal = true;
					}
					
										
					return returnVal;
			}
			/*
			 * 조회한 데이터를 그리드에 추가함.
			 * @param {String} 그리드로 변환할 테이블ID
			 * @param {Result} 조회된 데이터 객체 result
			 * @param {boolean} 데이터 추가시 기존데이터의 clear 여부
			 */
			, success:function(result){
				uxl.grid.appendData('APP_ROOT' ,result , true );
			}
			, async:true
	};
	uxl.callSubmitFunction('APP_ROOT_FORM' , url , option );
	
}

</script>

