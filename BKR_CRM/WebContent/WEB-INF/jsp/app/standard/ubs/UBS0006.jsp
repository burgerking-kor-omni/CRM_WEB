<%--
#*
 *  파 일 명 :  SYS0307.jsp
 *  설    명 :  게시판관리 게시판상세 관리자정보 (TabContent)
 *  작 성 자 :  유기태
 *  작 성 일 :  2015.06.09
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
	DataList _dl_BOARD_ADMIN_TYPE = ViewUtil.getResult().getDataList("Code.BOARD_ADMIN_TYPE");
	DataList _dl_CD_ROLE = ViewUtil.getResult().getDataList("Code.CD_ROLE");
%>

<!--  ========================================================================
  This page is generated with the UB-META™ ver4.0 
 
   - PAGE ID : SYS0307R00
   - PAGE TYPE : JSP
 
  Copyright ⓒ UBONE Co., Ltd. All rights reserved.
 ========================================================================
--> 

<!-- layout-1 Start -->
<h2 class="ub-control title">게시판 관리자 설정
	<div class="ub-layout button inner"  style="text-align:right;">
		<form id="adminForm" name="adminForm">
			<input type=hidden id="ID_BOARD" name="ID_BOARD" value="${paramMap.ID_BOARD}">
		</form>

		<select id="ADMIN_TYPE" name="ADMIN_TYPE" class="ub-control select "     style="width:120px;" size="1" datacid="BOARD_ADMIN_TYPE">
		<%
		    if(!"".equals("")){
		        out.println("<OPTION VALUE=\"\"></OPTION>\r\n");
		    }
		    if(_dl_BOARD_ADMIN_TYPE != null){
		        for(int codeIdx=0; codeIdx < _dl_BOARD_ADMIN_TYPE.getRowCount(); codeIdx++){
		            String code = _dl_BOARD_ADMIN_TYPE.getString(codeIdx, ConstantHolder.CODE_COLUMN_CODE);
		            String name = _dl_BOARD_ADMIN_TYPE.getString(codeIdx, ConstantHolder.CODE_COLUMN_NAME);
		            String selected = code.equals('U')?"selected":"";
		            out.println("<option VALUE=\""+code+"\" "+selected+">"+name+"</option>\r\n");
		        }
		    }
		%>
		</select>
		<select id="ROLE_ID" name="ROLE_ID" class="ub-control select "     style="width:120px;" size="1" datacid="CD_ROLE">
		<%
		    if(!"".equals("")){
		        out.println("<OPTION VALUE=\"\"></OPTION>\r\n");
		    }
		    if(_dl_CD_ROLE != null){
		        for(int codeIdx=0; codeIdx < _dl_CD_ROLE.getRowCount(); codeIdx++){
		            String code = _dl_CD_ROLE.getString(codeIdx, ConstantHolder.CODE_COLUMN_CODE);
		            String name = _dl_CD_ROLE.getString(codeIdx, ConstantHolder.CODE_COLUMN_NAME);
		            out.println("<option VALUE=\""+code+"\">"+name+"</option>\r\n");
		        }
		    }
		%>
		</select>

		<span class="ub-control button inner icon" id="add">
		    <a href="#none" title="Add"><span class="ico-add"></span>추가</a>
		</span>
		<span class="ub-control button inner icon" id="delete">
		    <a href="#none" title="Delete"><span class="ico-delete"></span>삭제</a>
		</span>	
	</div>
</h2>
<div class="ub-control temp" style="border:2px solid gray;width:100%;height:300px;text-align:center;"><h3 style="padding-top:120px;">Grid Control</h3></div>
<table class="ub-control grid" id="list" name="list"></table> 
<div class="ub-layout pagging"><div class="ub-control temp" style="border:2px solid gray;width:100%;height:30px;text-align:center;"><h3 style="padding-top:3px;">Paging Navigation</h3></div>
	<div id="paging" name="paging" class="ub-control pagging" for="list" formId="adminForm" function="fnSearch"></div>
</div>

<!-- layout-1 End -->

<script type="text/javascript">
uxl.onLoad(function(){
	
	$('#ADMIN_TYPE').change(function(){
		if(this.value == 'R'){
			$('#ROLE_ID').show();
		}else{
			$('#ROLE_ID').hide();
		}
	}).change();
	
	/*
	그리드 옵션
	colNames : 그리드 Header 정보,
	colModel : 그리드 Contents 의 바인딩 정보
	 */
	var options = {
		//header name
		colNames : [ '구성유형', '구성유형명', '구성값', '구성명', '등록자ID', '등록자', '등록일' ]
		//mapping column
		, colModel:[
				{name:'ADMIN_TYPE'		, hidden:true}
			  , {name:'ADMIN_TYPE_NM'	, width:80, align:'center'}	
			  , {name:'ADMIN_VALUE'		, hidden:true}
			  , {name:'ADMIN_VALUE_NM'	, width:80, align:'center'}
			  , {name:'REG_USER_ID'		, hidden:true}
			  , {name:'REG_USER_NM'		, width:80, align:'center'}
			  , {name:'REG_DATETIME'	, width:80, align:'center', formatter:'date'}
		]
		, autowidth : true
		, multiselect : true
		, height : 231
		, rowNum : 10
	};
	uxl.grid('list', options);
	
	fnSearchAdmin();
	
	//직원 팝업으로 이동
	$('#add').click(function() {
		var adminType = $('#ADMIN_TYPE').val();
		if(adminType == 'U'){
			uxl.openWindow('empSearch', uxl.getScreenURL('POP0001'), {width : 750 ,height : 592 }, callBackUser);
		}else if(adminType == 'R'){
			callBackRole($('#ROLE_ID').val());
		}
	});
	
	//권한자 삭제
	$('#delete').click(function() {
		fnDeleteComposer();
	});
	
});

//조회
function fnSearchAdmin() {
	//필수정보 체크
	var url = uxl.getFunctionUrl(_SCREEN_ID, 'INQUIRY');
	var option = {
		data : uxl.grid.getParam('list')

		/*
		 * 조회한 데이터를 그리드에 추가함.
		 * @param {String} 그리드로 변환할 테이블ID
		 * @param {Result} 조회된 데이터 객체 result
		 * @param {boolean} 데이터 추가시 기존데이터의 clear 여부
		 */
		,
		success : function(result) {
			uxl.grid.appendData('list', result, true);
		},
		async : true
	};
	uxl.callSubmitFunction('adminForm', url, option);
}

//직원검색 callback Function
function callBackUser(userData) {
	var url = uxl.getFunctionUrl(_SCREEN_ID, 'REGIST');
	var option = {
		//사용자 ID를 파라미터에 담는다.
		data : {
			 "ADMIN_TYPE"  : 'U'
			,"ADMIN_VALUE" : userData.idUser
		},
		success : function(result) {
			result.getServiceMessage();
			fnSearchAdmin();
		},
		async : true
	};
	uxl.callSubmitFunction('adminForm', url, option);
}

function callBackRole(roleId) {
	var url = uxl.getFunctionUrl(_SCREEN_ID, 'REGIST');
	var option = {
		//사용자 ID를 파라미터에 담는다.
		data : {
			 "ADMIN_TYPE" : 'R'
			,"ADMIN_VALUE" : roleId
		},
		success : function(result) {
			result.getServiceMessage();
			fnSearchAdmin();
		},
		async : true
	};
	uxl.callSubmitFunction('adminForm', url, option);
}

//권한관련자 삭제
function fnDeleteComposer() {
	var rowIds = $('#list').jqGrid('getGridParam', 'selarrrow');

	//체크박스에 선택된 rowdata가 없을 경우 예외처리
	if (rowIds.length == null || rowIds.length == '0') {
		uxl.showMessage("삭제할 관리자정보를 선택하세요");
		return;
	}
	var rowDatas = new Array(rowIds.length);
	var adminValue = new Array(rowIds.length);
	for ( var i = 0; i < rowIds.length; i++) {
		rowDatas[i] = $('#list').jqGrid('getRowData', rowIds[i]);
		adminValue[i] = rowDatas[i].ADMIN_VALUE;
	}

	var url = uxl.getFunctionUrl(_SCREEN_ID, 'REMOVE');
	var option = {
		data : {
			'ADMIN_VALUES' : adminValue
		},
		success : function(result) {
			fnSearchAdmin();
		},
		async : true,
		message : {
			confirm : uxl.getMessage('@message.common.delete.confirm'),
			success : uxl.getMessage('@message.common.delete.success'),
			fail : uxl.getMessage('@message.common.delete.fail')
		}

	};
	uxl.callSubmitFunction('adminForm', url, option);
}

</script>