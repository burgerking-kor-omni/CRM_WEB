<%--
#*
 *  파 일 명 :  SYS0303.jsp
 *  설    명 :  게시판관리 게시판 생성
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
	DataList _dl_BOARD_TYPE_CD = ViewUtil.getResult().getDataList("Code.BOARD_TYPE_CD");
%>


<!--  ========================================================================
  This page is generated with the UB-META™ ver4.0 
 
   - PAGE ID : SYS0303R00
   - PAGE TYPE : JSP
 
  Copyright ⓒ UBONE Co., Ltd. All rights reserved.
 ========================================================================
--> 

<!-- layout-1 Start -->
<h1 class="ub-control title">게시판 관리 등록</h1>
<div class="ub-layout button top"><span class="ub-control button top icon" id="listBtn"        title="목록">
    <a href="#none" title="목록"><span class="ico-list"></span>목록</a>
</span>
</div>
<div class="ub-layout details"><form id="registForm" name="registForm"><table class="ub-control table normal ">
<colgroup>
	<col width="150px"/>
	<col />
</colgroup>
<tbody>
<tr id="layout-1_1">
	<th id="layout-1_1_1"><label class="ub-control label"             for="ID_BOARD">게시판 ID</label></th>
	<td id="layout-1_1_2">
		<input type=text  class="ub-control input-text " id="ID_BOARD" name="ID_BOARD" value="" maxLength="20" metaessential="1" style="text-align:left;width:100px;">
		<label id="lblMessage" name="lblMessage" class="ub-control label" style="display: none;">사용가능여부메세지</label>
	</td>
</tr>
<tr id="layout-1_2">
	<th id="layout-1_2_3"><label class="ub-control label"             for="DS_TITLE">게시판 타이틀</label></th>
	<td id="layout-1_2_4"><input type=text  class="ub-control input-text " id="DS_TITLE" name="DS_TITLE" value="" metaessential="1" style="text-align:left;width:400px;"></td>
</tr>
<tr id="layout-1_3">
	<th id="layout-1_3_5"><label class="ub-control label"             for="ID_BOARD_TYPE">게시판 유형</label></th>
	<td id="layout-1_3_6">
		<select id="ID_BOARD_TYPE" name="ID_BOARD_TYPE" class="ub-control select " style="width:200px;" size="1" datacid="BOARD_TYPE_CD"      metaessential="1">
			<%    if(!"선택안됨".equals("")){        out.println("<OPTION VALUE=\"\">선택안됨</OPTION>\r\n");    }    if(_dl_BOARD_TYPE_CD != null){        for(int codeIdx=0; codeIdx < _dl_BOARD_TYPE_CD.getRowCount(); codeIdx++){            String code = _dl_BOARD_TYPE_CD.getString(codeIdx, ConstantHolder.CODE_COLUMN_CODE);            String name = _dl_BOARD_TYPE_CD.getString(codeIdx, ConstantHolder.CODE_COLUMN_NAME);            out.println("<option VALUE=\""+code+"\">"+name+"</option>\r\n");        }    }%>
		</select>
	</td>
</tr>
<tr id="layout-1_4">
	<th id="layout-1_4_7"><label class="ub-control label"             for="CD_CATEGORY">게시판 분류</label></th>
	<td id="layout-1_4_8">
		<input type=text  class="ub-control input-text " id="CD_CATEGORY" name="CD_CATEGORY" value="" style="text-align:left;width:186px;">
		<label class="ub-control label">'|' 로 구분   EX) 질문|요청|문의</label>
	</td>
</tr>
</tbody>
</table>
 
</form>
</div>
<div class="ub-layout button bottom"><span class="ub-control button bottom icon" id="registBtn"        title="등록">
    <a href="#none" title="등록"><span class="ico-save"></span>등록</a>
</span>
</div>

<!-- layout-1 End -->


<script type="text/javascript">
var registFlag = false;
uxl.onLoad(function(){
	
	//목록버튼 클릭 이벤트 바인딩
	$('#listBtn').click(function(event){
		uxl.returnToList("UBS0001");
	});
	
	//등록버튼 클릭 이벤트 바인딩
	$('#registBtn').click(function(event){
		fnRegist();
	});
	
	//게시판ID 포커스아웃 이벤트 바인딩
	$('#ID_BOARD').focusout(function(event){
		var boardId = $(this).val();
		if(boardId == null || boardId == ""){
			registFlag = false;
		}else{
			fnSearch();	
		}
	});
	
});

//ID중복조회
function fnSearch() {
	var boardId = $("#ID_BOARD").val();
	var url = uxl.getFunctionUrl(_SCREEN_ID, 'INQUIRY');
	var option = {
		data:{"ID_BOARD" : boardId}
	  , success:function(result) {
			var rowCount = result.getDataList(0).rowCount;
			
			if (rowCount > 0) {
				$("#lblMessage").html('<strong class="tcolor1">이미 존재하는 게시판 ID 입니다.</strong>');
				registFlag = false;
			} else {
				$("#lblMessage").html('<strong class="tcolor2">사용가능한 게시판 ID 입니다.</strong>');
				registFlag = true;
			}
			$("#lblMessage").show();
	    }
	  , async:true
	};
	uxl.callFunction(url, option);
}

//등록
function fnRegist() {	
	var boardId = $.trim($("#ID_BOARD").val());
	var url = uxl.getFunctionUrl(_SCREEN_ID, 'REGIST');
	var option = {
		data:{}
	  , validator:function(data,targetForm) {
			var returnVal = false;
			//필수항목체크
			if(uxl.checkRequiredFields(targetForm)) {
				if(registFlag){
					returnVal = true;
				}else{
					uxl.showMessage('게시판 ID를 확인해 주세요.');
					$('#ID_BOARD').focus();
				}
			}
			return returnVal;
		}
	  , success:function(result) {
		  	uxl.moveLocation(uxl.getScreenURL('UBS0004') + '?ID_BOARD=' + boardId);
		}
	  , async:true
	  , message : {
			confirm : uxl.getMessage('@message.common.insert.confirm'),
			success : uxl.getMessage('@message.common.insert.success'),
			fail : uxl.getMessage('@message.common.insert.fail')
		}
	  
	};
	uxl.callSubmitFunction('registForm', url, option);
}

</script>