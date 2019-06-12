<%--
#*
 *  파 일 명 :  APP0011.jsp
 *  설    명 :  나의 결재 - 승인의견
 *  작 성 자 :  김희연
 *  작 성 일 :  2014-04-10
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
%>


<!--  ========================================================================
  This page is generated with the UB-META™ ver4.0 
 
   - PAGE ID : APP0011R00
   - PAGE TYPE : JSP
 
  Copyright ⓒ UBONE Co., Ltd. All rights reserved.
 ========================================================================
--> 


<!-- layout-1 Start -->
<h1 class="ub-control title">승인의견 작성</h1>
<form id="apprForm" name="apprForm"><div class="ub-layout details"><table class="ub-control table normal ">
<colgroup>
<col width="30%"/>
<col />
</colgroup>
<tbody>
<tr id="layout-1_1">
<th id="layout-1_1_1"><label class="ub-control label">의견</label></th>
<td id="layout-1_1_2"><textarea class="ub-control textarea " id="DS_COMMENT" name="DS_COMMENT"       style="width:350px;" rows="5"                  rows="5">${paramMap.DS_COMMENT}</textarea><input type=hidden id="ID_APPR_DTL" name="ID_APPR_DTL"    value="${paramMap.ID_APPR_DTL}"><input type=hidden id="ID_APPR" name="ID_APPR"    value="${paramMap.ID_APPR}"><input type=hidden id="SEQ_APPR" name="SEQ_APPR"><input type=hidden id="ID_VOC" name="ID_VOC"><input type=hidden id="ID_SUB_VOC" name="ID_SUB_VOC"><input type=hidden id="TP_BIZ" name="TP_BIZ"    value="${paramMap.TP_BIZ}"></td>
</tr>
</tbody>
</table>
 
</div>
<div class="ub-layout button bottom"><span class="ub-control button bottom icon" id="btnAppr">
    <a href="#none" title="확인"><span></span>확인</a>
</span>
<span class="ub-control button bottom icon" id="btnCancel">
    <a href="#none" title="취소"><span></span>취소</a>
</span>
</div>
</form>

<!-- layout-1 End -->


<script type="text/javascript">

uxl.onLoad(function(){
	
	$('#ID_VOC').val($('#ID_VOC', opener.document).val());
	$('#ID_SUB_VOC').val($('#ID_SUB_VOC', opener.document).val());
	$('#SEQ_APPR').val($('#SEQ_APPR', opener.document).val());
	
	//'반려사유 등록' 확인버튼 (반려사유를 바로 이전 페이지의 의견에 추가반영하여 보이지 않고 바로 목록으로 빠져나감.)
	$('#btnAppr').click(function(){
		update();		
	});
		
	//'승인의견 등록' 취소버튼 (바로 이전 페이지 보여줌)
	$('#btnCancel').click(function(){		
		self.close();
	});
		
});

	//결재완료
	function update(){
		//필수정보 체크
		var url = uxl.getFunctionUrl(_SCREEN_ID,'MODIFY');
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
				, success:function(result){	
					opener.uxl.reload();
					self.close();
				}		
				
				, async:true
				, message : {
					 confirm : uxl.getMessage('@message.common.approval.confirm'),
					 success : uxl.getMessage('@message.common.approval.success'),
					 fail : uxl.getMessage('@message.common.approval.fail')
				  }
		};
		uxl.callSubmitFunction('apprForm' , url , option );	
	}


</script>