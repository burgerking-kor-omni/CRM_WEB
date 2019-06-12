<%--
#*
 *  파 일 명 :  APP0002.jsp
 *  설    명 :  나의상신상세
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
	DataList _dl_ApprovalInquiry_getMyApprovalDetail_content = ViewUtil.getResult().getDataList("ApprovalInquiry.getMyApprovalDetail_content");
	DataList _dl_TP_BIZ = ViewUtil.getResult().getDataList("Code.TP_BIZ");
	DataList _dl_TP_STATUS_APPR = ViewUtil.getResult().getDataList("Code.TP_STATUS_APPR");
%>


<!--  ========================================================================
  This page is generated with the UB-META™ ver4.0 
 
   - PAGE ID : APP0002R00
   - PAGE TYPE : JSP
 
  Copyright ⓒ UBONE Co., Ltd. All rights reserved.
 ========================================================================
--> 


<!-- layout-1 Start -->
<h1 class="ub-control title">나의 상신 상세</h1>
<div class="ub-layout button top"><span class="ub-control button top icon" id="MENU">
    <a href="#none" title="목록"><span class="ico-list"></span>목록</a>
</span>
</div>
<form id="DETAIL_FORM" name="DETAIL_FORM"><h2 class="ub-control title">결재경로</h2>
<div class="ub-layout list"><div class="ub-control temp" style="border:2px solid gray;width:100%;height:300px;text-align:center;"><h3 style="padding-top:120px;">Grid Control</h3></div>
<table class="ub-control grid" id="LIST" name="LIST"></table> 
	
</div>
<div class="ub-layout details" id="layoutDetail" name="layoutDetail"><h2 class="ub-control title" id="marginTitle" name="marginTitle">결재내용</h2>
<table class="ub-control table normal ">
<colgroup>
<col width="12%"/>
<col width="38%"/>
<col width="12%"/>
<col width="38%"/>
</colgroup>
<tbody>
<tr id="layout-1_1">
<th id="layout-1_1_1"><label class="ub-control label">제목</label></th>
<td id="layout-1_1_2" colspan=3><input type=text  class="ub-control input-text " id="DS_TITLE_APPR" name="DS_TITLE_APPR"       value="<%=JspUtils.getDefaultValue(_dl_ApprovalInquiry_getMyApprovalDetail_content, "DS_TITLE_APPR") %>"                style="text-align:left;width:400px;"   disabled><input type=hidden id="ID_APPR" name="ID_APPR"    value="${paramMap.ID_APPR}"><input type=hidden id="ID_VOC" name="ID_VOC"    value="<%=JspUtils.getDefaultValue(_dl_ApprovalInquiry_getMyApprovalDetail_content, "ID_BIZ_KEY") %>"><input type=hidden id="ID_SUB_VOC" name="ID_SUB_VOC"    value="<%=JspUtils.getDefaultValue(_dl_ApprovalInquiry_getMyApprovalDetail_content, "ID_BIZ_KEY_ETC") %>"><span class="ub-control button inner icon" id="reportPop">    <a href="#none" title="Report 보기"><span></span>Report 보기</a></span><input type=hidden id="ID_BIZ_KEY" name="ID_BIZ_KEY"    value="<%=JspUtils.getDefaultValue(_dl_ApprovalInquiry_getMyApprovalDetail_content, "ID_BIZ_KEY") %>"><input type=hidden id="ID_ISSUE" name="ID_ISSUE"    value="${paramMap.ID_ISSUE}"></td>
</tr>
<tr id="layout-1_2">
<th id="layout-1_2_3"><label class="ub-control label">유형</label></th>
<td id="layout-1_2_4"><select id="TP_BIZ" name="TP_BIZ" class="ub-control select "     style="width:115px;" size="1" datacid="TP_BIZ" defaultvalue="<%=JspUtils.getDefaultValue(_dl_ApprovalInquiry_getMyApprovalDetail_content, "TP_BIZ") %>"              disabled><%    if(!"".equals("")){        out.println("<OPTION VALUE=\"\"></OPTION>\r\n");    }    if(_dl_TP_BIZ != null){        for(int codeIdx=0; codeIdx < _dl_TP_BIZ.getRowCount(); codeIdx++){            String code = _dl_TP_BIZ.getString(codeIdx, ConstantHolder.CODE_COLUMN_CODE);            String name = _dl_TP_BIZ.getString(codeIdx, ConstantHolder.CODE_COLUMN_NAME);            String selected = code.equals(JspUtils.getDefaultValue(_dl_ApprovalInquiry_getMyApprovalDetail_content, "TP_BIZ"))?"selected":"";            out.println("<option VALUE=\""+code+"\" "+selected+">"+name+"</option>\r\n");        }    }%></select></td>
<td id="layout-1_2_5"></td>
<td id="layout-1_2_6"></td>
</tr>
<tr id="layout-1_3">
<th id="layout-1_3_7"><label class="ub-control label">상신일자</label></th>
<td id="layout-1_3_8"><input type=text  class="ub-control input-text " id="DT_SUBMIT" name="DT_SUBMIT"       value="<%=JspUtils.getDefaultValue(_dl_ApprovalInquiry_getMyApprovalDetail_content, "DT_SUBMIT") %>"  readonly              style="text-align:left;width:100px;"   disabled></td>
<th id="layout-1_3_9"><label class="ub-control label">결재일자</label></th>
<td id="layout-1_3_10"><input type=text  class="ub-control input-text " id="DT_APPR" name="DT_APPR"       value="<%=JspUtils.getDefaultValue(_dl_ApprovalInquiry_getMyApprovalDetail_content, "DT_APPR") %>"  readonly              style="text-align:left;width:100px;"   disabled></td>
</tr>
<tr id="layout-1_4">
<th id="layout-1_4_11"><label class="ub-control label">결재상태</label></th>
<td id="layout-1_4_12"><select id="TP_STATUS_APPR" name="TP_STATUS_APPR" class="ub-control select "     style="width:115px;" size="1" datacid="TP_STATUS_APPR" defaultvalue="<%=JspUtils.getDefaultValue(_dl_ApprovalInquiry_getMyApprovalDetail_content, "TP_STATUS") %>"              disabled><%    if(!"".equals("")){        out.println("<OPTION VALUE=\"\"></OPTION>\r\n");    }    if(_dl_TP_STATUS_APPR != null){        for(int codeIdx=0; codeIdx < _dl_TP_STATUS_APPR.getRowCount(); codeIdx++){            String code = _dl_TP_STATUS_APPR.getString(codeIdx, ConstantHolder.CODE_COLUMN_CODE);            String name = _dl_TP_STATUS_APPR.getString(codeIdx, ConstantHolder.CODE_COLUMN_NAME);            String selected = code.equals(JspUtils.getDefaultValue(_dl_ApprovalInquiry_getMyApprovalDetail_content, "TP_STATUS"))?"selected":"";            out.println("<option VALUE=\""+code+"\" "+selected+">"+name+"</option>\r\n");        }    }%></select></td>
<td id="layout-1_4_13"></td>
<td id="layout-1_4_14"></td>
</tr>
<tr id="layout-1_5">
<th id="layout-1_5_15"><label class="ub-control label">내용</label></th>
<td id="layout-1_5_16" colspan=3><textarea class="ub-control textarea " id="DS_APPR" name="DS_APPR"       style="width:624px;" rows="5"                  rows="5" disabled><%=JspUtils.getDefaultValue(_dl_ApprovalInquiry_getMyApprovalDetail_content, "DS_APPR") %></textarea></td>
</tr>
<tr id="layout-1_6">
<th id="layout-1_6_17"><label class="ub-control label">첨부파일</label></th>
<td id="layout-1_6_18" colspan=3><div class="ub-control temp" style="border:2px solid gray;width:100%;height:80px;text-align:center;"><h3 style="padding-top:30px;padding-left:10px;padding-right:10px;">Attach File Control</h3></div><span class="ub-control attachFile">   	<div class="filefieldset" id='uploadedFiles_FILE'></div>   	<div class="filefieldset" id='uploadProgress_FILE' style="display:none;">   		<span class="legend">Uploading...</span>   	</div>	<span id='btnUpload_FILE'></span> </span></td>
</tr>
</tbody>
</table>
 
</div>
<div class="ub-layout button bottom"><span class="ub-control button bottom icon" id="CANCLE">
    <a href="#none" title="기안취소"><span></span>기안취소</a>
</span>
</div>
<div class="ub-control temp" style="border:2px solid gray;width:100%;height:50px;text-align:center;"><h3 style="padding:10px;">Tab Control</h3></div>
<div id="tabs" name="tabs" class="ub-control tab"></div>
</form>

<!-- layout-1 End -->


<script type="text/javascript" charset="UTF-8" src="<spring:url value='/uxl/tab/uxl-tab-1.3.0.js'/>"></script>
<style type="text/css">
	#marginTitle {margin-top:15px;}
	.ui-jqgrid .ui-jqgrid-btable {cursor:default;}
</style>
<%
// 	String tp_proj_1 = VocConstantHolder.CD_PROJ_1;
%>
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
		
		uxl.ext.Upload('FILE', {readOnly : true});
		
			var options = {
				//header name
				colNames:['번호','직책','담당자','결재처리구분','부서명','결재일시','의견']
	
				//mapping column
				,colModel:[
				          {name:'SEQ_APPR',width:5,align:'center'}
				         ,{name:'CD_DUTY', width:10,align:'center'}
						 ,{name:'ID_EMP_APPR' ,width:10,align:'center'}
						 ,{name:'TP_APPR_PROC' ,width:15,align:'center'}
						 ,{name:'ID_DEPT',width:38,align:'left'}
						 ,{name:'DT_ACT',width:18,align:'center'}
						 ,{name:'DS_COMMENT',width:60,align:'left'}
				]
				, width:966
				, height:80
				
			};
			uxl.grid('LIST', options);
	
			fnSearch();	
			
			// 목록버튼 클릭시
			$('#MENU').click(function(){
				uxl.returnToList('APP0001');
			});
			
			// 기안취소버튼 클릭시
			$('#CANCLE').click(function(){
				fnApprCancle();
			});
			
			// 결재중이 아니면 기안취소버튼 숨김
			if($("[name=TP_STATUS_APPR] option:selected").val()!="01"){
				$("#CANCLE").hide();
			}
			
			// 업무상세조회
			$('#WORK_DETAIL_SEARCH').click(function(){
				// VOC 일 경우
// 				if($('#TP_BIZ').val() == '01'){
// 					uxl.openWindow('PopVocDetail', uxl.getScreenURL('POP0023')+'?ID_VOC='+$('#ID_VOC').val()+'&ID_SUB_VOC='+$('#ID_SUB_VOC').val(), { width:'960px' ,height:'400px', scrollbars:'yes' });	
// 				}else{
// 					// 개선과제일 경우
// 					var url = uxl.getFunctionUrl(_SCREEN_ID,'USERDEFINED2');
// 					var options = {
// 							 data : {ID_ISSUE:$('#ID_BIZ_KEY').val()}
// 							,success : function(result){
// 								var dataSet = result.getDataList(0).rows;
								
<%-- 								if(dataSet[0].TP_PROJ_1 == '<%=tp_proj_1%>'){ --%>
// 									// VOC 개선과제
// 									uxl.openWindow('PopIssueDetail', uxl.getScreenURL('POP0070')+'?ID_ISSUE='+dataSet[0].ID_ISSUE, { width:'960px' ,height:'400px', scrollbars:'yes' });	
// 								}else{
// 									// 간담회 개선과제
// 									uxl.openWindow('PopIssueDetail', uxl.getScreenURL('POP0071')+'?ID_ISSUE='+dataSet[0].ID_ISSUE, { width:'960px' ,height:'400px', scrollbars:'yes' });
// 								}
// 							}
// 							,async : false
// 					};
// 					uxl.callFunction(url, options);
					
// 				}
					
			});
			
			// report 조회
// 			$('#reportPop').click(function(){
// 				var url = uxl.getFunctionUrl(_SCREEN_ID,'USERDEFINED1');
// 				var options = {
// 						 data : {SEQ_REPORT:$('#ID_BIZ_KEY').val()}
// 						,success : function(result){
// 							var dataSet = result.getDataList(0).rows;
// 							var strURL = uxl.getContextURL("/uxl/ext/RexServer30/rexLotteReport.jsp?SEQ_REPORT="+dataSet[0].SEQ_REPORT+"&TP_REPORT="+dataSet[0].TP_REPORT);
// 							uxl.openWindow('PopupRexpert', strURL, { width:1024 ,height:668, scrollbars:'no',resizable:'yes' }, null);			
// 						}
// 						,async : false
// 				};
// 				uxl.callFunction(url, options);
// 			});
			
// 			var param = '?ID_ISSUE=' + $('#ID_ISSUE').val();
// 			var tab = new uxl.Tabs('tabs');
<%-- 			tab.add('ISS0001', '<%=request.getContextPath()%>'+'/screen/ISS0001.ub' + param, '개선과제', false);		//VOC이력 --%>
// 			$(window).resize(function(){
// 				tab.resize(170);
// 			}).trigger('resize');
	});
	
	function fnSearch(){
		//필수정보 체크
		var url = uxl.getFunctionUrl(_SCREEN_ID,'INQUIRY');
		var option = {
				  data:{}		
				, success:function(result){
					uxl.grid.appendData('LIST' ,result , true );
				}
				, async:true
		};
		uxl.callSubmitFunction('DETAIL_FORM' , url , option );		
	}
	
	// 기안취소
	function fnApprCancle(){
		var url = uxl.getFunctionUrl(_SCREEN_ID,'REMOVE');
		var option = {
				  data:{}
				
				, success:function(result){
					uxl.moveLocation(uxl.getScreenURL('APP0001'));
				}
				, async:true
				, message : {
					 confirm : uxl.getMessage('@message.common.apprCancle.confirm'),
					 success : uxl.getMessage('@message.common.apprCancle.success'),
					 fail : uxl.getMessage('@message.common.apprCancle.fail')
				  }
		};
		uxl.callSubmitFunction('DETAIL_FORM' , url , option );
	}
	
</script>