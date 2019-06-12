<%--
#*
 *  파 일 명 :  SYS0309.jsp
 *  설    명 :  게시판관리 게시판상세 알림메세지정보 (TabContent)
 *  작 성 자 :  유기태
 *  작 성 일 :  2015.06.24
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
 
   - PAGE ID : SYS0309R00
   - PAGE TYPE : JSP
 
  Copyright ⓒ UBONE Co., Ltd. All rights reserved.
 ========================================================================
--> 

<!-- layout-1 Start -->

<h2 class="ub-control title">알림정보</h2>
<div class="ub-layout details">
<form id="messageForm" name="messageForm">
	<input type=hidden id="ID_BOARD" name="ID_BOARD" value="${paramMap.ID_BOARD}">	
	<table class="ub-control table list ">
		<colgroup>
			<col width="80px"/>
			<col width="150px"/>
			<col />
		</colgroup>
		<thead>
		<tr>
			<th>사용여부</th>
			<th>이벤트</th>
			<th>템플릿</th>
		</tr>
	</thead>
		<tbody>
			<tr>
				<td style="text-align:center;"><input id="TP_ARTICLE" name="TP_ARTICLE" class="ub-control input-checkbox" type="checkbox" value="Y"></td>
				<td style="text-align:center;"><label>새글 등록</label></td>
				<td><textarea class="ub-control textarea " id="DS_ARTICLE" name="DS_ARTICLE" style="width:99%;" rows="3" ></textarea></td>
			</tr>
			<tr>
				<td style="text-align:center;"><input id="TP_REPLY" name="TP_REPLY" class="ub-control input-checkbox" type="checkbox" value="Y"></td>
				<td style="text-align:center;"><label>댓글 등록</label></td>
				<td><textarea class="ub-control textarea " id="DS_REPLY" name="DS_REPLY" style="width:99%;" rows="3" ></textarea></td>
			</tr>
			<tr>
				<td style="text-align:center;"><input id="TP_ANSWER" name="TP_ANSWER" class="ub-control input-checkbox" type="checkbox" value="Y"></td>
				<td style="text-align:center;"><label>답글 등록</label></td>
				<td><textarea class="ub-control textarea " id="DS_ANSWER" name="DS_ANSWER" style="width:99%;" rows="3" ></textarea></td>
			</tr>
			<tr>
				<td style="text-align:center;"><input id="TP_NOTICE" name="TP_NOTICE" class="ub-control input-checkbox" type="checkbox" value="Y"></td>
				<td style="text-align:center;"><label>공지글 등록</label></td>
				<td><textarea class="ub-control textarea " id="DS_NOTICE" name="DS_NOTICE" style="width:99%;" rows="3" ></textarea></td>
			</tr>
		</tbody>
	</table>
</form>
</div>

<div class="ub-layout button bottom"><span class="ub-control button bottom icon" id="messageUpdateBtn" title="수정">
    <a href="#none" title="수정"><span class="ico-save"></span>알림저장</a>
</span>
</div>

<!-- layout-1 End -->


<script type="text/javascript">
uxl.onLoad(function(){

	fnSearch();
	
	$('#messageUpdateBtn').click(function(){
		fnUpdateMessage();
	});
	
});

function fnSearch(){
	var url = uxl.getFunctionUrl(_SCREEN_ID,'INQUIRY');
	var option = {
			  data:{}		
			, success:function(result){
				var dataList = result.getDataList(0);
				if(dataList.rowCount != 0){
					fnSetMessageInfo(dataList);
				}
			}
			, async:true
	};
	uxl.callSubmitFunction('messageForm' , url , option );	
}

function fnSetMessageInfo(dataList){
	for(var i = 0 ; i < dataList.rowCount ; i++){
		var dataSet = dataList.rows[i];
		if(dataSet.TP_MESSAGE == 'NOTICE'){
			if(dataSet.FG_USE == 'Y'){
				$('#TP_NOTICE')[0].checked = true;
			}
			$('#DS_NOTICE').val(dataSet.DS_MESSAGE);
		}else if(dataSet.TP_MESSAGE == 'REPLY'){
			if(dataSet.FG_USE == 'Y'){
				$('#TP_REPLY')[0].checked = true;
			}
			$('#DS_REPLY').val(dataSet.DS_MESSAGE);
		}else if(dataSet.TP_MESSAGE == 'ARTICLE'){
			if(dataSet.FG_USE == 'Y'){
				$('#TP_ARTICLE')[0].checked = true;
			}
			$('#DS_ARTICLE').val(dataSet.DS_MESSAGE);
		}else if(dataSet.TP_MESSAGE == 'ANSWER'){
			if(dataSet.FG_USE == 'Y'){
				$('#TP_ANSWER')[0].checked = true;
			}
			$('#DS_ANSWER').val(dataSet.DS_MESSAGE);
		}
	}
}

function fnUpdateMessage(){
	var url = uxl.getFunctionUrl(_SCREEN_ID,'MODIFY');
	var option = {
			  data:{}		
			, success:function(result){
				
			}
			, async:true
			, message : {
			  	confirm : uxl.getMessage('@message.common.update.confirm'),
				success : uxl.getMessage('@message.common.update.success'),
				fail : uxl.getMessage('@message.common.update.fail')
			}
	};
	uxl.callSubmitFunction('messageForm' , url , option );	
}

</script>