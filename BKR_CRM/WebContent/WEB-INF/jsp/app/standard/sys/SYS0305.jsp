<%--
#*
 *  파 일 명 :  SYS0305.jsp
 *  설    명 :  게시판관리 게시판상세 기본정보 (TabContent)
 *  작 성 자 :  유기태
 *  작 성 일 :  2015.05.12
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
	DataList _dl_BoardManage_getDetail = ViewUtil.getResult().getDataList("BoardManage.getDetail");
// 	DataList _dl_BOARD_TYPE_CD = ViewUtil.getResult().getDataList("Code.BOARD_TYPE_CD");
%>


<!--  ========================================================================
  This page is generated with the UB-META™ ver4.0 
 
   - PAGE ID : SYS0305R00
   - PAGE TYPE : JSP
 
  Copyright ⓒ UBONE Co., Ltd. All rights reserved.
 ========================================================================
--> 


<!-- layout-1 Start -->

<h2 class="ub-control title">기본정보</h2>
<div class="ub-layout details"><form id="detailForm" name="detailForm"><table class="ub-control table normal ">
<colgroup>
	<col width="150px"/>
	<col />
</colgroup>
<tbody>
<tr id="layout-1_1">
	<th id="layout-1_1_1"><label class="ub-control label"             for="ID_BOARD">게시판 ID</label></th>
	<td id="layout-1_1_2">
		<input type=text  class="ub-control input-text " id="ID_BOARD" name="ID_BOARD" value="${paramMap.ID_BOARD}" readonly style="text-align:left;width:100px;">
		<label id="lblMessage" name="lblMessage" class="ub-control label" style="display: none;">사용가능여부메세지</label>
	</td>
</tr>
<tr id="layout-1_2">
	<th id="layout-1_2_3"><label class="ub-control label"             for="DS_TITLE">게시판 타이틀</label></th>
	<td id="layout-1_2_4"><input type=text  class="ub-control input-text " id="DS_TITLE" name="DS_TITLE" value="<%=JspUtils.getDefaultValue(_dl_BoardManage_getDetail, "DS_TITLE") %>" metaessential="1" style="text-align:left;width:400px;"></td>
</tr>
<tr id="layout-1_3">
	<th id="layout-1_3_5"><label class="ub-control label"             for="CD_CATEGORY">게시판 분류</label></th>
	<td id="layout-1_3_6">
		<input type=text  class="ub-control input-text " id="CD_CATEGORY" name="CD_CATEGORY" value="<%=JspUtils.getDefaultValue(_dl_BoardManage_getDetail, "CD_CATEGORY") %>" style="text-align:left;width:186px;">
		<label class="ub-control label">'|' 로 구분   EX) 질문|요청|문의</label>
	</td>
</tr>
<tr id="layout-1_4">
	<th id="layout-1_4_7"><label class="ub-control label"             for="">게시판 테마</label></th>
	<td id="layout-1_4_8"></td>
</tr>
</tbody>
</table>
 
</form>
</div>
<div class="ub-layout button bottom">
<span class="ub-control button bottom icon" id="basicUpdateBtn"        title="저장">
    <a href="#none" title="저장"><span class="ico-save"></span>저장</a>
</span>
<span class="ub-control button bottom icon" id="deleteBoardBtn"        title="삭제">
    <a href="#none" title="삭제">삭제</a>
</span>
</div>

<!-- layout-1 End -->


<script type="text/javascript">
uxl.onLoad(function(){
	
	//등록버튼 클릭 이벤트 바인딩
	$('#basicUpdateBtn').click(function(event){
		fnBasicUpdate();
	});
	
	//게시판 삭제버튼 이벤트 바인등
	$('#deleteBoardBtn').click(function(event){
		fnDeleteBoard();
	});
	
});

//등록
function fnBasicUpdate() {	
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
			uxl.reload();
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

// 게시판 삭제
function fnDeleteBoard(){
	var boardId = $('#ID_BOARD').val();
	var url = uxl.getFunctionUrl(_SCREEN_ID, 'REMOVE');
	var option = {
		data:{ID_BOARD:boardId}
	  , success:function(result) {
		  parent.uxl.returnToList('SYS0301');
		}
	  , async:true
	  , message : {
			confirm : uxl.getMessage('@message.common.delete.confirm'),
			success : uxl.getMessage('@message.common.delete.success'),
			fail : uxl.getMessage('@message.common.delete.fail')
		}
	  
	};
	uxl.callFunction(url, option);
}

</script>