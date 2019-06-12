<%--
#*
 *  파 일 명 :  APM0005.jsp
 *  설    명 :  서비스관리 목록
 *  작 성 자 :  유기태
 *  작 성 일 :  2015.02.23
 *  버    전 :  1.0
 *  기타사항 :
 *  수정이력 :  2016-10-07 다국어 호환 작업 - by 이창섭
 *  Copyrights 2013 by ㈜ 유비원. All right reserved.
*# 
--%>
<%@page import="com.ubone.framework.util.MessageUtils"%>
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
	DataList _dl_CALL_TYPE = ViewUtil.getResult().getDataList("Code.APMD_CALL_TYPE");
	DataList _dl_FLAG_YN = ViewUtil.getResult().getDataList("Code.FLAG_YN");
	DataList _dl_SERVICE_TYPE = ViewUtil.getResult().getDataList("Code.APMD_SERVICE_TYPE");
%>


<!--  ========================================================================
  This page is generated with the UB-META™ ver4.0 
 
   - PAGE ID : APM0005R00
   - PAGE TYPE : JSP
 
  Copyright ⓒ UBONE Co., Ltd. All rights reserved.
 ========================================================================
--> 


<!-- layout-1 Start -->
<h1 class="ub-control title"><ub:message code="title.APM0005.title" text="서비스 관리"/></h1>
<div class="ub-layout button top">
<span class="ub-control button top icon" id="btnServiceCache">
    <a href="#none" title="캐시제거"><span class="ico-register"></span><ub:message code="button.APM0005.service.cache.init" text="서비스캐시초기화"/></a>
</span>
<span class="ub-control button top icon" id="btnRegister">
    <a href="#none" title="신규등록"><span class="ico-register"></span><ub:message code="button.common.new" text="신규등록"/></a>
</span>
</div>
<div class="ub-layout search">
    <span class="search-ltbg"></span>
    <span class="search-rtbg"></span>
    <span class="search-lbbg"></span>
    <span class="search-rbbg"></span>
<form id="searchForm" name="searchForm"><table class="ub-control table normal ">
<colgroup>
<col width="120px"/>
<col />
<col width="120px"/>
<col />
<col width="120px"/>
<col />
</colgroup>
<tbody>
<tr id="layout-1_1">
<th id="layout-1_1_1"><label class="ub-control label"><ub:message code="label.APM.category" text="분류"/></label></th>
<td id="layout-1_1_2">
	<ub:code-select codeCategory="CATEGORY_CODE" id="CATEGORY_CODE" style="width:140px;" blankType="1" />
	<input type=hidden id="CATEGORY_CODE_VALUE" name="CATEGORY_CODE_VALUE"    value="${paramMap.CATEGORY_CODE}">
</td>
<th id="layout-1_1_3"><label class="ub-control label"><ub:message code="label.APM.service.id" text="서비스ID"/></label></th>
<td id="layout-1_1_4"><input type=text  class="ub-control input-text " id="SERVICE_ID" name="SERVICE_ID" maxLength="10" metalength="10"       value="${paramMap.SERVICE_ID}"                style="text-align:left;width:126px;"></td>
<th id="layout-1_1_5"><label class="ub-control label"><ub:message code="label.APM.service.name" text="서비스명"/></label></th>
<td id="layout-1_1_6"><input type=text  class="ub-control input-text " id="SERVICE_NAME" name="SERVICE_NAME"       value="${paramMap.SERVICE_NAME}"                style="text-align:left;width:126px;"></td>
</tr>
<tr id="layout-1_2">
<th id="layout-1_2_7"><label class="ub-control label"><ub:message code="label.APM.service.type" text="서비스유형"/></label></th>
<td id="layout-1_2_8">
	<ub:code-select codeCategory="APMD_SERVICE_TYPE" id="SERVICE_TYPE" style="width:140px;" blankType="1" defaultValue="${paramMap.SERVICE_TYPE}"/>
</td>
<th id="layout-1_2_9"><label class="ub-control label"><ub:message code="label.APM.call.type" text="호출유형"/></label></th>
<td id="layout-1_2_10">
	<ub:code-select codeCategory="APMD_CALL_TYPE" id="CALL_TYPE" style="width:140px;" blankType="1" defaultValue="${paramMap.CALL_TYPE}"/>
</td>
<th id="layout-1_2_11"><label class="ub-control label"><ub:message code="label.APM.login.check.yn" text="로그인 체크여부"/></label></th>
<td id="layout-1_2_12">
	<ub:code-select codeCategory="FLAG_YN" id="LOGIN_CHECK_YN" style="width:140px;" blankType="1" defaultValue="${paramMap.LOGIN_CHECK_YN}"/>
</td>
</tr>
</tbody>
</table>
 
<span class="ub-control button search" id="btnSearch"        title="검색">
<a href="#none" title="Search"><ub:message code="button.common.search" text="검색"/></a>
</span>
</form>

</div>
<div class="ub-layout list"><div class="ub-control temp" style="border:2px solid gray;width:100%;height:300px;text-align:center;"><h3 style="padding-top:120px;">Grid Control</h3></div>
<table class="ub-control grid" id="list" name="list"></table> 
	
</div>
<div class="ub-layout pagging"><div class="ub-control temp" style="border:2px solid gray;width:100%;height:30px;text-align:center;"><h3 style="padding-top:3px;">Paging Navigation</h3></div>
<div class="ub-control pagging" for="list" formId="searchForm" function="fnSearch"></div>
</div>

<!-- layout-1 End -->


<script type="text/javascript">
uxl.onLoad(function(){
// 	hsqlData.getCategoryCode("CATEGORY_CODE", {blankOption:"전체", selectValue:$("#CATEGORY_CODE_VALUE").val()});
	uxl.bindComboCode('CATEGORY_CODE', 'CATEGORY_CODE', {emptyOption:'전체'});
	
	var options = {
			//header name
			colNames:[
						'<%=MessageUtils.getMessage("label.APM.screen.category", "분류") %>'
					  , '<%=MessageUtils.getMessage("label.APM.service.id", "서비스ID") %>'
					  , '<%=MessageUtils.getMessage("label.APM.service.name", "서비스명") %>'
					  , '<%=MessageUtils.getMessage("label.APM.service.type", "서비스유형") %>'
					  , '<%=MessageUtils.getMessage("label.APM.call.type", "호출유형") %>'
					  , '<%=MessageUtils.getMessage("label.APM.login.check.yn", "로그인체크여부") %>'
					  , '<%=MessageUtils.getMessage("label.APM.reg.date", "작성일") %>'
					  , '<%=MessageUtils.getMessage("label.APM.error", "오류") %>'
					  , '<%=MessageUtils.getMessage("label.APM.error.count", "오류카운트") %>'
					  , '<%=MessageUtils.getMessage("label.APM.xml", "XML") %>'
					 ]
			
			//mapping column
			, colModel:[
				    {name:'CATEGORY_CODE',    width:20, align:'center'}
				  , {name:'SERVICE_ID',       width:15, align:'center'}
				  , {name:'SERVICE_NAME',       width:55, align:'left'}
				  , {name:'SERVICE_TYPE', width:20, align:'center', codeCategory:'APMD_SERVICE_TYPE'}
				  , {name:'CALL_TYPE',     width:20, align:'center', codeCategory:'APMD_CALL_TYPE'}
				  , {name:'LOGIN_CHECK_YN',  width:15, align:'center'}
				  , {name:'REG_DATETIME',  width:30, align:'center'}
				  , {name:'error',  width:5, align:'center'}
				  , {name:'ERROR_COUNT', hidden:true}
				  , {name:'downXmlBtn',  width:15, align:'center', formatter:setXmlDownBtn}
			]
			, autowidth:true
			, autoheight:true
			, height:261
			, sortname: 'REG_DATETIME'
			, sortorder: 'DESC'
			, onSelectRow: function(rowid){
				var selectedRow = $(this).getRowData(rowid);
				var param = "?SERVICE_ID=" + selectedRow.SERVICE_ID;
				uxl.moveLocation(uxl.getScreenURL('APM0015') + param);
			},gridComplete: function(){
				var $grid = $("#list");
				var ids = $grid.jqGrid('getDataIDs');
				for(var i=0;i < ids.length;i++){
					var cl = ids[i];
					var data = $grid.jqGrid('getRowData',cl);
					if(data.ERROR_COUNT != 0){
						$grid.jqGrid('setRowData',ids[i],{error:'O'});						
					} 				
				}	
			},loadComplete: function (gridData) {
				 $("#jqgh_list_error").css("cursor", "default");
				 $("#jqgh_list_error").removeClass("ui-jqgrid-sortable");
			}
		};
		uxl.grid('list', options);
		
		//fnSearch();
		
		//자동완성 기능
		uxl.autocomplete('SERVICE_ID', uxl.getFunctionUrl(_SCREEN_ID, 'USERDEFINED1') ,{
			minLength : 2
		  , itemExtractor : function(row) {
				var item = {
					id : row.SERVICE_ID
				  , value : row.SERVICE_NAME
				  , label : '[' + row.SERVICE_ID + ']  ' + row.SERVICE_NAME
				};
				return item;
			}
		  , select: function(event, ui) {
				$("#SERVICE_ID").val(ui.item.id);
				$("#SERVICE_NAME").val(ui.item.value);
				uxl.moveLocation(uxl.getScreenURL('APM0015') + "?SERVICE_ID=" + ui.item.id);
				return false;
			}
		});

		//자동완성 기능
		uxl.autocomplete('SERVICE_NAME', uxl.getFunctionUrl(_SCREEN_ID, 'USERDEFINED1') ,{
			minLength : 2
		  , itemExtractor : function(row) {
				var item = {
					id : row.SERVICE_ID
				  , value : row.SERVICE_NAME
				  , label : '[' + row.SERVICE_ID + ']  ' + row.SERVICE_NAME
				};
				return item;
			}
		  , select: function(event, ui) {
				$("#SERVICE_ID").val(ui.item.id);
				$("#SERVICE_NAME").val(ui.item.value);
				uxl.moveLocation(uxl.getScreenURL('APM0015') + "?SERVICE_ID=" + ui.item.id);
				return false;
			}
		});
		
		$('#btnRegister').click(function() {
			uxl.moveLocation(uxl.getScreenURL('APM0007'));
		});
		
		$('#btnSearch').click(function() {
			uxl.grid.init('list');
			fnSearch();
		});
		
		/* //Enter Key 이벤트
		$('#SERVICE_ID, #SERVICE_NAME').keydown(function(event) {
			if(event.keyCode == '13') {
				fnSearch();
				return false;
			}
		}); */
		
		//화면 캐시 초기화
		$('#btnServiceCache').click(function(){
			fnServiceCacheFlushAll();
		});
});

function setXmlDownBtn(cellValue, opts, rowObject) {
	var html = "<span class='ub-control button inner icon' name='btnDownXml'>";
	html += "<a href='javascript:fnDownloadXmlFile(\"" + rowObject.SERVICE_ID + "\");' title='다운로드'>";
	html += uxl.getMessage('button.common.download', '다운로드');
	html += "</a></span>";
	
	return html;
}

function fnDownloadXmlFile(serviceId){
	var url = uxl.getFunctionUrl(_SCREEN_ID,'EXPORT');
	var option = {
			  data:{SERVICE_ID:serviceId}		
			, success:function(result){
				var filelink = result.getResultKey();
				var url = uxl.getContextURL('/file/view.do');
				url = uxl.addQueryToUrl(url, 'filePath', filelink[0]);
				window.location.href=url;
			}
			, async:true
	};
	uxl.callFunction( url , option );	
}

function fnSearch(){		
	//필수정보 체크
	var url = uxl.getFunctionUrl(_SCREEN_ID,'INQUIRY');
	var option = {
			  data:uxl.grid.getParam('list')
			, success:function(result){
				uxl.grid.appendData('list' ,result , true );
			}
			, async:true
	};
	uxl.callSubmitFunction('searchForm' , url , option );		
}

function fnServiceCacheFlushAll(){
	//필수정보 체크
	var url = uxl.getFunctionUrl(_SCREEN_ID,'USERDEFINED2');
	var option = {
			  data:{}		
			, async:true
			, message : {
			  	confirm : uxl.getMessage('@message.common.confirm', uxl.getMessage('@message.APM0005.service.cache.init', '서비스캐쉬 초기화')),
				success : uxl.getMessage('@message.common.success', uxl.getMessage('@message.APM0005.service.cache.init', '서비스캐쉬 초기화')),
				fail : uxl.getMessage('@message.common.fail', uxl.getMessage('@message.APM0005.service.cache.init', '서비스캐쉬 초기화'))
			}
	};
	uxl.callFunction( url , option );		
}

</script>