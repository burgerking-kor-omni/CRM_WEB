<%--
#*
 *  파 일 명 :  SYS0302.jsp
 *  설    명 :  게시판 복제 팝업
 *  작 성 자 :  유기태
 *  작 성 일 :  2015.05.11
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
%>


<!--  ========================================================================
  This page is generated with the UB-META™ ver4.0 
 
   - PAGE ID : SYS0302R00
   - PAGE TYPE : JSP
 
  Copyright ⓒ UBONE Co., Ltd. All rights reserved.
 ========================================================================
--> 


<!-- layout-1 Start -->
<h1 class="ub-control title">게시판 복제</h1>
<form id="registForm" name="registForm"><div class="ub-layout details"><table class="ub-control table normal ">
<colgroup>
<col width="100px"/>
<col />
</colgroup>
<tbody>
<tr id="layout-1_1">
	<th id="layout-1_1_1"><label class="ub-control label" for="NEW_ID_BOARD">게시판 ID</label></th>
	<td id="layout-1_1_2">
		<input type=text  class="ub-control input-text " id="NEW_ID_BOARD" name="NEW_ID_BOARD" maxLength="10" metaessential="1" style="text-align:left;width:120px;">
		<input type=hidden id="ID_BOARD" name="ID_BOARD" value="${paramMap.boardId}">
	</td>
</tr>
</tbody>
</table>
 
<div class="ub-layout button bottom"><span class="ub-control button bottom icon" id="registBtn"        title="저장">
    <a href="#none" title="저장"><span class="ico-save"></span>저장</a>
</span>
</div>
</div>
</form>

<!-- layout-1 End -->


<script type="text/javascript">
uxl.onLoad(function(){

	// 저장버튼 이벤트 바인딩
	$('#registBtn').click(function() {
		fnRegist();
	});
	
});

// 등록
function fnRegist() {	
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
		  	uxl.pushToParent();
		  	self.close();
		}
	  , async:true
	  , message : {
			confirm : uxl.getMessage('@message.common.confirm', '게시판복제'),
			success : uxl.getMessage('@message.common.success', '게시판복제'),
			fail : uxl.getMessage('@message.common.fail', '게시판복제')
		}
	};
	uxl.callSubmitFunction('registForm', url, option);
}

</script>