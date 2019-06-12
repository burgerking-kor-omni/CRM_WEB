<%--
#*
 *  파 일 명 :  SYS0155.jsp
 *  설    명 :  마스크관리 상세
 *  작 성 자 :  
 *  작 성 일 :  
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
	DataList _dl_MaskManage_getMaskDetail = ViewUtil.getResult().getDataList("MaskManage.getMaskDetail");
	DataList _dl_TP_MASK = ViewUtil.getResult().getDataList("Code.TP_MASK");
%>


<!--  ========================================================================
  This page is generated with the UB-META™ ver4.0 
 
   - PAGE ID : SYS0155R00
   - PAGE TYPE : JSP
 
  Copyright ⓒ UBONE Co., Ltd. All rights reserved.
 ========================================================================
--> 


<!-- layout-1 Start -->
<h1 class="ub-control title">마스크 상세</h1>
<div class="ub-layout button top"><span class="ub-control button top icon" id="btnList">
    <a href="#none" title="목록"><span class="ico-list"></span>목록</a>
</span>
</div>
<form id="detailForm" name="detailForm"><h2 class="ub-control title">기본정보</h2>
<div class="ub-layout details"><table class="ub-control table normal ">
<colgroup>
<col width="150px"/>
<col />
</colgroup>
<tbody>
<tr id="layout-1_1">
<th id="layout-1_1_1"><label class="ub-control label"             for="ID_MASK">마스크 ID</label></th>
<td id="layout-1_1_2"><input type=text  class="ub-control input-text " id="ID_MASK" name="ID_MASK"       value="<%=JspUtils.getDefaultValue(_dl_MaskManage_getMaskDetail, "ID_MASK") %>"  readonly   metaessential="1"           style="text-align:left;width:100px;"></td>
</tr>
<tr id="layout-1_2">
<th id="layout-1_2_3"><label class="ub-control label"             for="NM_MASK">마스크명</label></th>
<td id="layout-1_2_4"><input type=text  class="ub-control input-text " id="NM_MASK" name="NM_MASK"       value="<%=JspUtils.getDefaultValue(_dl_MaskManage_getMaskDetail, "NM_MASK") %>"     metaessential="1"           style="text-align:left;width:300px;"></td>
</tr>
<tr id="layout-1_3">
<th id="layout-1_3_5"><label class="ub-control label"             for="TP_MASK">마스크유형</label></th>
<td id="layout-1_3_6"><select id="TP_MASK" name="TP_MASK" class="ub-control select "     style="width:314px;" size="1" datacid="TP_MASK" defaultvalue="<%=JspUtils.getDefaultValue(_dl_MaskManage_getMaskDetail, "TP_MASK") %>"><%    if(!"".equals("")){        out.println("<OPTION VALUE=\"\"></OPTION>\r\n");    }    if(_dl_TP_MASK != null){        for(int codeIdx=0; codeIdx < _dl_TP_MASK.getRowCount(); codeIdx++){            String code = _dl_TP_MASK.getString(codeIdx, ConstantHolder.CODE_COLUMN_CODE);            String name = _dl_TP_MASK.getString(codeIdx, ConstantHolder.CODE_COLUMN_NAME);            String selected = code.equals(JspUtils.getDefaultValue(_dl_MaskManage_getMaskDetail, "TP_MASK"))?"selected":"";            out.println("<option VALUE=\""+code+"\" "+selected+">"+name+"</option>\r\n");        }    }%></select></td>
</tr>
<tr id="layout-1_4">
<th id="layout-1_4_7"><label class="ub-control label"             for="DS_INPUT">입력문자열</label></th>
<td id="layout-1_4_8"><input type=text  class="ub-control input-text " id="DS_INPUT" name="DS_INPUT"       value="<%=JspUtils.getDefaultValue(_dl_MaskManage_getMaskDetail, "DS_INPUT") %>"                style="text-align:left;width:300px;"></td>
</tr>
<tr id="layout-1_5">
<th id="layout-1_5_9"><label class="ub-control label"             for="DS_OUTPUT">출력문자열</label></th>
<td id="layout-1_5_10"><input type=text  class="ub-control input-text " id="DS_OUTPUT" name="DS_OUTPUT"       value="<%=JspUtils.getDefaultValue(_dl_MaskManage_getMaskDetail, "DS_OUTPUT") %>"                style="text-align:left;width:300px;"></td>
</tr>
<tr id="layout-1_6">
<th id="layout-1_6_11"><label class="ub-control label"             for="DS_CLASS">구현클래스</label></th>
<td id="layout-1_6_12"><input type=text  class="ub-control input-text " id="DS_CLASS" name="DS_CLASS"       value="<%=JspUtils.getDefaultValue(_dl_MaskManage_getMaskDetail, "DS_CLASS") %>"                style="text-align:left;width:300px;"></td>
</tr>
</tbody>
</table>
 
</div>
</form>
<h2 class="ub-control title">마스킹 제외 권한</h2>
<div class="ub-layout list"><div class="ub-control temp" style="border:2px solid gray;width:100%;height:300px;text-align:center;"><h3 style="padding-top:120px;">Grid Control</h3></div>
<table class="ub-control grid" id="authList" name="authList"></table> 
	
</div>
<h2 class="ub-control title">적용된 서비스</h2>
<div class="ub-layout list"><div class="ub-control temp" style="border:2px solid gray;width:100%;height:300px;text-align:center;"><h3 style="padding-top:120px;">Grid Control</h3></div>
<table class="ub-control grid" id="serviceList" name="serviceList"></table> 
	
</div>
<div class="ub-layout button bottom"><span class="ub-control button bottom icon" id="btnUpdate">
    <a href="#none" title="Save"><span class="ico-save"></span>수정</a>
</span>
<span class="ub-control button bottom icon" id="btnDelete">
    <a href="#none" title="Delete"><span class="ico-delete"></span>삭제</a>
</span>
</div>

<!-- layout-1 End -->


<script type="text/javascript">
uxl.onLoad(function(){
	$('#btnUpdate').click(function() {
		updateMask();
	});
	
	$('#btnDelete').click(function() {
		deleteMask();
	});
	
	$('#btnList').click(function() {
		uxl.returnToList(uxl.getScreenURL('SYS0154'));
	});
	
	var authOptions = {
			//header name
			colNames:['권한 ID','권한명'] 
			
			//mapping column
			, colModel:[
			           {name:'ROLE_ID',width:20, align:'center'}
			          ,{name:'ROLE_NAME',width:30, align:'center'}
			         ]
			, autowidth:true
			, multiselect:true
			, height:208
			, onSelectAll: function(aRowids, status){
				for(var i=0; i<aRowids.length; i++){
					var rowdata = $('#authList').jqGrid('getRowData',aRowids[i]);
					updateAuth(rowdata.ROLE_ID, status);
				}
			}, onSelectRow : function(rowid, status, e){
				var rowdata = $('#authList').jqGrid('getRowData',rowid);
				updateAuth(rowdata.ROLE_ID, status);
			}
			, gridComplete: function(){
					
			}
	};
	uxl.grid('authList', authOptions);
	loadAuthInfo();
	
	var svcOptions = {
			//header name
			colNames:['서비스ID', '서비스명', '서비스유형', '호출유형']

			//mapping column
		  , colModel:[
				{name:'SERVICE_ID',       width:10, align:'center'}
			  , {name:'SERVICE_NAME',       width:25, align:'left'}
			  , {name:'SERVICE_TYPE',     width:10, align:'center'}
			  , {name:'CALL_TYPE',    width:15, align:'center'}
			]
		  , autowidth:true
		  , multiselect:false
		  , onSelectRow: function(rowid){
				var selectedRow = $(this).getRowData(rowid);
				var param = "?SERVICE_ID=" + selectedRow.SERVICE_ID;
				uxl.openWindow('servicePop', uxl.getScreenURL('SYS0105') + param, {width:'1000px', height:'660px'});
			}
	};			
	uxl.grid('serviceList', svcOptions);
	loadServiceInfo();
});

function updateMask() {
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
	uxl.callSubmitFunction("detailForm", url, option);
}

function deleteMask() {
	var maskId = $("#ID_MASK").val();
	var url = uxl.getFunctionUrl(_SCREEN_ID, 'REMOVE');
	var option = {
		data:{"ID_MASK" : maskId}
	  , success:function(result) {
		  uxl.moveLocation(uxl.getScreenURL('SYS0154'));
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

function loadAuthInfo(){
	var maskId = $("#ID_MASK").val();
	var url = uxl.getFunctionUrl(_SCREEN_ID,'USERDEFINED1');
	var data = {ID_MASK:maskId};
		data = $.extend(data, uxl.grid.getParam('authList'));
	var options = {
			 data : data 
			,success	: function(result){
				uxl.grid.appendData('authList' ,result , true );
			 }
			,async : true
	};

	uxl.callFunction(url, options);
};

function updateAuth(ROLE_ID, CHECKED){
	var url = uxl.getFunctionUrl(_SCREEN_ID,'USERDEFINED2');
	var options = {
		 data : {ROLE_ID:ROLE_ID, ID_MASK:$('#ID_MASK').val(), CHECKED:CHECKED}
		,success	: function(data){
		}
		,async 		: false
	};
	uxl.callFunction(url, options);
};
	
function loadServiceInfo(){
	var maskId = $("#ID_MASK").val();
	var url = uxl.getFunctionUrl(_SCREEN_ID,'USERDEFINED3');
	var data = {ID_MASK:maskId};
		data = $.extend(data, uxl.grid.getParam('serviceList'));
	var options = {
			 data : data 
			,success	: function(result){
				uxl.grid.appendData('serviceList' ,result , true );
			 }
			,async : true
	};

	uxl.callFunction(url, options);
}
</script>