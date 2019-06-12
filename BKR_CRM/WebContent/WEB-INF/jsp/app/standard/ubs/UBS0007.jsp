<%--
#*
 *  파 일 명 :  SYS0308.jsp
 *  설    명 :  게시판관리 게시판상세 접근권한설정 (TabContent)
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
	DataList _dl_CD_ROLE = ViewUtil.getResult().getDataList("Code.CD_ROLE");
%>


<!--  ========================================================================
  This page is generated with the UB-META™ ver4.0 
 
   - PAGE ID : SYS0308R00
   - PAGE TYPE : JSP
 
  Copyright ⓒ UBONE Co., Ltd. All rights reserved.
 ========================================================================
--> 


<h2 class="ub-control title">접근권한

</h2>

<div class="ub-layout floatBox">
	<div class="ub-layout leftBox"   style="width:30%;">
		<input type="checkbox" value="Y" name="ckbRoleActive" id="ckbRoleActive" class="ub-control input-checkbox" ><label class="ub-control label">활성화</label>			
	</div>
	<div class="ub-layout rightBox"   style="width:69%; text-align:right;">
		<select id="ID_ROLE" name="ID_ROLE" class="ub-control select " style="width:120px;" size="1">
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
		    <a href="#none" title="Add"><span class="ico-add"></span>권한추가</a>
		</span>
		<span class="ub-control button inner icon" id="delete">
		    <a href="#none" title="Delete"><span class="ico-delete"></span>권한삭제</a>
		</span>
	</div>
</div>


<div class="ub-layout button inner"  style="text-align:right;">
		
	</div>
<div class="ub-layout details">
<form id="roleForm" name="roleForm">
	<input type=hidden id="ID_BOARD" name="ID_BOARD" value="${paramMap.ID_BOARD}">
</form>
<div class="ub-control temp" style="border:2px solid gray;width:100%;height:300px;text-align:center;"><h3 style="padding-top:120px;">Grid Control</h3></div>
<table class="ub-control grid" id="list" name="list"></table> 
<div class="ub-layout pagging"><div class="ub-control temp" style="border:2px solid gray;width:100%;height:30px;text-align:center;"><h3 style="padding-top:3px;">Paging Navigation</h3></div>
	<div id="paging" name="paging" class="ub-control pagging" for="list" formId="adminForm" function="fnSearch"></div>
</div>
</div>




<script type="text/javascript">
uxl.onLoad(function(){

	if('${paramMap.FG_AUTH_ACTIVE}' == 'Y'){
		$('#ckbRoleActive')[0].checked = true;
	}
	
	var options = {
		//header name
		colNames : [ '권한코드', '권한명', '등록자', '등록일' ]
		//mapping column
		, colModel:[
				{name:'ID_ROLE'		, width:80, align:'center'}
			  , {name:'NM_ROLE'		, width:80, align:'center'}	
			  , {name:'NM_REG_USER'	, width:80, align:'center'}
			  , {name:'DT_REG'		, width:80, align:'center'}
		]
		, autowidth : true
		, multiselect : true
		, height : 231
		, rowNum : 10
	};
	uxl.grid('list', options);

	fnSearchRole();
	
	//직원 팝업으로 이동
	$('#add').click(function() {
		callBackRoleAdd($('#ID_ROLE').val());
	});

	//권한자 삭제
	$('#delete').click(function() {
		fnDeleteRole();
	});
	
	$('#ckbRoleActive').click(function(){
		fnUpdateRoleActive(this.checked);
	});
});

//조회
function fnSearchRole() {
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
	uxl.callSubmitFunction('roleForm', url, option);
}

function callBackRoleAdd(roleId) {
	var url = uxl.getFunctionUrl(_SCREEN_ID, 'REGIST');
	var option = {
		  data : {ID_ROLE : roleId}
		, success : function(result) {
			result.getServiceMessage();
			fnSearchRole();
		  }
		, async : true
	};
	uxl.callSubmitFunction('roleForm', url, option);
}

//권한관련자 삭제
function fnDeleteRole() {
	var rowIds = $('#list').jqGrid('getGridParam', 'selarrrow');

	//체크박스에 선택된 rowdata가 없을 경우 예외처리
	if (rowIds.length == null || rowIds.length == '0') {
		uxl.showMessage("삭제할 권한정보를 선택하세요");
		return;
	}
	var rowDatas = new Array(rowIds.length);
	var roleValue = new Array(rowIds.length);
	for ( var i = 0; i < rowIds.length; i++) {
		rowDatas[i] = $('#list').jqGrid('getRowData', rowIds[i]);
		roleValue[i] = rowDatas[i].ID_ROLE;
	}

	var url = uxl.getFunctionUrl(_SCREEN_ID, 'REMOVE');
	var option = {
		  data : {
			ROLE_VALUES : roleValue
		}
		, success : function(result) {
			fnSearchRole();
		}
		, async : true
		, message : {
			confirm : uxl.getMessage('@message.common.delete.confirm'),
			success : uxl.getMessage('@message.common.delete.success'),
			fail : uxl.getMessage('@message.common.delete.fail')
		}
	};
	uxl.callSubmitFunction('roleForm', url, option);
}

function fnUpdateRoleActive(checked){
	var data = {};
	if(checked){
		data = {FG_AUTH_ACTIVE:'Y'};
	}else{
		data = {FG_AUTH_ACTIVE:'N'};
	}
	
	var url = uxl.getFunctionUrl(_SCREEN_ID, 'MODIFY');
	var option = {
		  data : data
		, success : function(result) {
			alert('success');
		  }
		, async : true
	};
	uxl.callSubmitFunction('roleForm', url, option);
	
}

</script>