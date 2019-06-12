<%--
#*
 *  파 일 명 :  APM0001.jsp
 *  설    명 :  SCREEN 목록
 *  작 성 자 :  유기태
 *  작 성 일 :  2015-02-23
 *  버    전 :  1.0
 *  기타사항 :  
 *  수정이력 :  2016-10-07 다국어 호환 작업 - by 이창섭
 *  Copyrights 2013 by ㈜ 유비원. All right reserved.
*# 
--%>
<%@page import="com.ubone.framework.util.MessageUtils"%>
<%@page import="com.ubone.framework.util.CodeUtil"%>
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
	DataList _dl_FLAG_YN = ViewUtil.getResult().getDataList("Code.FLAG_YN");
	DataList _dl_SCREEN_TYPE = ViewUtil.getResult().getDataList("Code.APMD_SCREEN_TYPE");
	DataList _dl_SCREEN_VIEW_TYPE = ViewUtil.getResult().getDataList("Code.APMD_SCREEN_VIEW_TYPE");
%>


<!--  ========================================================================
  This page is generated with the UB-META™ ver4.0 
 
   - PAGE ID : APM0001R00
   - PAGE TYPE : JSP
 
  Copyright ⓒ UBONE Co., Ltd. All rights reserved.
 ========================================================================
--> 

<!-- layout-1 Start -->
<h1 class="ub-control title"><ub:message code="title.APM0001.title" text="화면"/></h1>
<div class="ub-layout button top">
<span class="ub-control button top icon" id="btnBuildMeta">
    <a href="#none" title="Build Meta Jsp"><ub:message code="button.APM0001.make.meta.jsp" text="MetaJSP생성"/></a>
</span>
<span class="ub-control button top icon" id="btnRemoveMeta">
    <a href="#none" title="Remove Meta Jsp"><ub:message code="button.APM0001.remove.meta.jsp" text="MetaJSP삭제"/></a>
</span>
<span class="ub-control button top icon" id="btnBuildXml">
    <a href="#none" title="Build All Xml"><ub:message code="button.APM0001.make.all.xml" text="전체XML생성"/></a>
</span>
<!-- <span class="ub-control button top icon" id="btnRemoveXml"> -->
<!--     <a href="#none" title="Remove All Xml"><ub:message code="button.APM0001.remove.all.xml" text="전체XML삭제"/></a> -->
<!-- </span> -->
<span class="ub-control button top icon" id="btnScreenCache">
    <a href="#none" title="Remove Screen Cache"><ub:message code="button.APM0001.screen.cache.init" text="화면캐시초기화"/></a>
</span>
<span class="ub-control button top icon" id="btnMeta">
    <a href="#none" title="Meta Sync"><span class="ico-register"></span><ub:message code="button.APM0001.link.meta" text="메타연동"/></a>
</span>
<span class="ub-control button top icon" id="register">
    <a href="#none" title="Register"><span class="ico-register"></span><ub:message code="button.common.new" text="신규등록"/></a>
</span>
</div>
<form id="searchForm" name="searchForm"><div class="ub-layout search">
    <span class="search-ltbg"></span>
    <span class="search-rtbg"></span>
    <span class="search-lbbg"></span>
    <span class="search-rbbg"></span>
<table class="ub-control table normal ">
<colgroup>
<col />
<col />
<col />
<col />
<col />
<col />
</colgroup>
<tbody>
<tr id="layout-1_1">
<th id="layout-1_1_1"><label class="ub-control label" for="CATEGORY_CODE"><ub:message code="label.APM.category" text="분류"/></label></th>
<td id="layout-1_1_2">
	<ub:code-select codeCategory="CATEGORY_CODE" id="CATEGORY_CODE" style="width:120px;" blankType="0"/>
	<input type=hidden id="CATEGORY_CODE_VALUE" name="CATEGORY_CODE_VALUE"    value="${paramMap.CATEGORY_CODE}">
</td>
<th id="layout-1_1_3"><label class="ub-control label" for="SCREEN_ID"><ub:message code="label.APM.screen.id" text="화면ID"/></label></th>
<td id="layout-1_1_4"><input type=text  class="ub-control input-text " id="SCREEN_ID" name="SCREEN_ID" maxLength="7" metalength="7"       value="${paramMap.SCREEN_ID}"                style="text-align:left;width:106px;"></td>
<th id="layout-1_1_5"><label class="ub-control label" for="SCREEN_NAME"><ub:message code="label.APM.screen.name" text="화면명"/></label></th>
<td id="layout-1_1_6"><input type=text  class="ub-control input-text " id="SCREEN_NAME" name="SCREEN_NAME"       value="${paramMap.SCREEN_NAME}"                style="text-align:left;width:106px;"></td>
</tr>
<tr id="layout-1_2">
<th id="layout-1_2_7"><label class="ub-control label" for="SCREEN_TYPE"><ub:message code="label.APM.screen.type" text="화면유형"/></label></th>
<td id="layout-1_2_8">
	<ub:code-select codeCategory="APMD_SCREEN_TYPE" id="SCREEN_TYPE" style="width:120px;" blankType="1" defaultValue="${paramMap.SCREEN_TYPE}"/>
</td>
<th id="layout-1_2_9"><label class="ub-control label" for="VIEW_TYPE"><ub:message code="label.APM.view.type" text="View유형"/></label></th>
<td id="layout-1_2_10">
	<ub:code-select codeCategory="APMD_SCREEN_VIEW_TYPE" id="VIEW_TYPE" style="width:120px;" blankType="1" defaultValue="${paramMap.VIEW_TYPE}"/>
</td>
<th id="layout-1_2_11"><label class="ub-control label" for="LOGIN_CHECK_YN"><ub:message code="label.APM.login.check.yn" text="로그인 체크여부"/></label></th>
<td id="layout-1_2_12">
	<ub:code-select codeCategory="FLAG_YN" id="LOGIN_CHECK_YN" style="width:120px;" blankType="1" defaultValue="${paramMap.LOGIN_CHECK_YN}"/>
</td>
</tr>
</tbody>
</table>
 
<span class="ub-control button search" id="search">
<a href="#none" title="Search"><ub:message code="button.common.search" text="검색"/></a>
</span>

</div>
</form>
<div class="ub-layout list"><div class="ub-control temp" style="border:2px solid gray;width:100%;height:300px;text-align:center;"><h3 style="padding-top:120px;">Grid Control</h3></div>
<table class="ub-control grid" id="list" name="list"></table> 
	
</div>
<div class="ub-layout pagging"><div class="ub-control temp" style="border:2px solid gray;width:100%;height:30px;text-align:center;"><h3 style="padding-top:3px;">Paging Navigation</h3></div>
<div id="page" name="page" class="ub-control pagging" for="list" formId="searchForm" function="fnSearch"></div>
</div>

<!-- layout-1 End -->


<script type="text/javascript">
uxl.onLoad(function(){
// 	hsqlData.getCategoryCode("CATEGORY_CODE", {blankOption:"전체", selectValue:$("#CATEGORY_CODE_VALUE").val()});
	uxl.bindComboCode('CATEGORY_CODE', 'CATEGORY_CODE', {emptyOption:'전체'});
	
	var options = {
			//header name
			colNames:[  '<%=MessageUtils.getMessage("label.APM.category", "분류") %>'
			          , '<%=MessageUtils.getMessage("label.APM.screen.id", "화면ID") %>'
			          , '<%=MessageUtils.getMessage("label.APM.screen.name", "화면명") %>'
			          , '<%=MessageUtils.getMessage("label.APM.layout.type", "Layout 유형") %>'
			          , '<%=MessageUtils.getMessage("label.APM.screen.type", "화면 유형") %>'
			          , '<%=MessageUtils.getMessage("label.APM.view.type", "View 유형") %>'
			          , '<%=MessageUtils.getMessage("label.APM.login.check.yn", "로그인 체크여부") %>'
			          , '<%=MessageUtils.getMessage("label.APM.reg.date", "작성일") %>'
			          , '<%=MessageUtils.getMessage("label.APM.xml", "XML") %>'
			         ]
			
			//mapping column
			, colModel:[
				    {name:'CATEGORY_CODE',    width:10, align:'center'}
				  , {name:'SCREEN_ID',       width:15, align:'center'}
				  , {name:'SCREEN_NAME',       width:55, align:'left'}
				  , {name:'LAYOUT_TYPE', width:15, align:'center', codeCategory:'APMD_LAYOUT_TYPE'}
				  , {name:'SCREEN_TYPE',     width:15, align:'center', codeCategory:'APMD_SCREEN_TYPE'}
				  , {name:'VIEW_TYPE',  width:15, align:'center'}
				  , {name:'LOGIN_CHECK_YN',  width:15, align:'center'}
				  , {name:'REG_DATETIME',  width:30, align:'center'}
				  , {name:'downXmlBtn',  width:15, align:'center', formatter:setXmlDownBtn}
			]
			, autowidth:true
			, autoheight:true
			, sortname: 'REG_DATETIME'
			, sortorder: 'DESC'
			, height: 300
			, onSelectRow: function(rowid){
				var selectedRow = $(this).getRowData(rowid);
				var param = "?SCREEN_ID=" + selectedRow.SCREEN_ID;
				uxl.moveLocation(uxl.getScreenURL('APM0002') + param);
			}
		};
		uxl.grid('list', options);
		
		$('#register').click(function(){
			uxl.moveLocation(uxl.getScreenURL('APM0003'));
		});
		
		$('#search').click(function(){
			uxl.grid.init('list');
			fnSearch();
		});
		
		$('#btnMeta').click(function(){
			uxl.openWindow('metaPop', uxl.getScreenURL('APM0030'), {width:1000, height:517});
		});
		
		/* //Enter Key 이벤트
		$('#SCREEN_ID, #SCREEN_NAME').keydown(function(event) {
			if(event.keyCode == '13') {
				fnSearch();
				return false;
			}
		}); */
		
		uxl.autocomplete('SCREEN_ID', uxl.getFunctionUrl(_SCREEN_ID,'USERDEFINED1'), {
			minLength : 3,
			itemExtractor : function(row) {
				var item = {
					id : row.SCREEN_ID,
					value : row.SCREEN_NAME,
					label : '[' + row.SCREEN_ID + ']  ' + row.SCREEN_NAME
				};
				return item;
			},
			select: function(event, ui) {
				$("#SCREEN_ID").val(ui.item.id);
				$("#SCREEN_NAME").val(ui.item.value);
				uxl.moveLocation(uxl.getScreenURL('APM0002') + "?SCREEN_ID=" + ui.item.id);
				return false;
			}
		});
		
		uxl.autocomplete('SCREEN_NAME', uxl.getFunctionUrl(_SCREEN_ID,'USERDEFINED1'), {
			itemExtractor : function(row) {
				var item = {
					id : row.SCREEN_ID,
					value : row.SCREEN_NAME,
					label : row.SCREEN_NAME + ' [' + row.SCREEN_ID + ']'
				};
				return item;
			},
			select: function(event, ui) {
				$("#SCREEN_ID").val(ui.item.id);
				$("#SCREEN_NAME").val(ui.item.value);
				uxl.moveLocation(uxl.getScreenURL('APM0002') + "?SCREEN_ID=" + ui.item.id);
				return false;
			}
		});
		
		$("#metaLink").click(function(){
			uxl.openWindow('MetaPage', uxl.getScreenURL('APM0004'),  {width:780, height:410});	
		});
		
		//화면 캐시 초기화
		$('#btnScreenCache').click(function(){
			fnScreenCacheFlushAll();
		});
		
		//전체 JSP파일 생성
		$('#btnBuildMeta').click(function(){
			fnBuildMeta();
		});
		
		//전체 JSP파일 삭제
		$('#btnRemoveMeta').click(function(){
			fnRemoveMeta();
		});
		
		//전체 XML파일 생성
		$('#btnBuildXml').click(function(){
			fnBuildXml();
		});
		
		//전체 XML파일 삭제
// 		$('#btnRemoveXml').click(function(){
// 			fnRemoveXml();
// 		});
});

function setXmlDownBtn(cellValue, opts, rowObject) {
	var html = "<span class='ub-control button inner icon' name='btnDownXml'>";
	html += "<a href='javascript:fnDownloadXmlFile(\"" + rowObject.SCREEN_ID + "\");' title='다운로드'>";
	html += uxl.getMessage('label.common.download', '다운로드');
	html += "</a></span>";
	
	return html;
}

function fnDownloadXmlFile(screenId){
	var url = uxl.getFunctionUrl(_SCREEN_ID,'EXPORT');
	var option = {
			  data:{SCREEN_ID:screenId}		
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
			  data:{}		
			, success:function(result){
				uxl.grid.appendData('list' ,result , true );
			}
			, async:true
	};
	uxl.callSubmitFunction('searchForm' , url , option );		
}

//화면캐시 초기화
function fnScreenCacheFlushAll(){
	//필수정보 체크
	var url = uxl.getFunctionUrl(_SCREEN_ID,'USERDEFINED2');
	var option = {
			  data:{}		
			, async:true
			, message : {
			  	confirm : uxl.getMessage('@message.common.confirm', uxl.getMessage('@message.APM0001.screen.cache.init', '화면캐시 초기화')),
				success : uxl.getMessage('@message.common.success', uxl.getMessage('@message.APM0001.screen.cache.init', '화면캐시 초기화')),
				fail : uxl.getMessage('@message.common.fail', uxl.getMessage('@message.APM0001.screen.cache.init', '화면캐시 초기화'))
			}
	};
	uxl.callFunction( url , option );		
}

//전체 JSP 생성
function fnBuildMeta(){
	//필수정보 체크
	var url = uxl.getFunctionUrl(_SCREEN_ID,'USERDEFINED3');
	var option = {
			  data:{}		
			, async:true
			, message : {
			  	confirm : uxl.getMessage('@message.common.confirm', uxl.getMessage('@message.APM0001.meta.jsp.make', 'Meta JSP 생성')),
				success : uxl.getMessage('@message.common.success', uxl.getMessage('@message.APM0001.meta.jsp.make', 'Meta JSP 생성')),
				fail : uxl.getMessage('@message.common.fail', uxl.getMessage('@message.APM0001.meta.jsp.make', 'Meta JSP 생성'))
			}
	};
	uxl.callFunction( url , option );	
}

//전체 JSP 삭제
function fnRemoveMeta(){
	//필수정보 체크
	var url = uxl.getFunctionUrl(_SCREEN_ID,'USERDEFINED4');
	var option = {
			  data:{}		
			, async:true
			, message : {
			  	confirm : uxl.getMessage('@message.common.confirm', uxl.getMessage('@message.APM0001.meta.jsp.remove', 'Meta JSP 삭제')),
				success : uxl.getMessage('@message.common.success', uxl.getMessage('@message.APM0001.meta.jsp.remove', 'Meta JSP 삭제')),
				fail : uxl.getMessage('@message.common.fail', uxl.getMessage('@message.APM0001.meta.jsp.remove', 'Meta JSP 삭제'))
			}
	};
	uxl.callFunction( url , option );	
}

//전체 XML 생성
function fnBuildXml(){
	//필수정보 체크
	var url = uxl.getFunctionUrl(_SCREEN_ID,'USERDEFINED5');
	var option = {
			  data:{}		
			, async:true
			, message : {
			  	confirm : uxl.getMessage('@message.common.confirm', uxl.getMessage('@message.APM0001.whole.xml.file.make', '전체 XML파일 생성')),
				success : uxl.getMessage('@message.common.success', uxl.getMessage('@message.APM0001.whole.xml.file.make', '전체 XML파일 생성')),
				fail : uxl.getMessage('@message.common.fail', uxl.getMessage('@message.APM0001.whole.xml.file.make', '전체 XML파일 생성'))
			}
	};
	uxl.callFunction( url , option );		
}

//전체 XML 삭제
// function fnRemoveXml(){
// 	//필수정보 체크
// 	var url = uxl.getFunctionUrl(_SCREEN_ID,'USERDEFINED6');
// 	var option = {
// 			  data:{}		
// 			, async:true
// 			, message : {
// 			  	confirm : uxl.getMessage('@message.common.confirm', '전체 XML파일 삭제'),
// 				success : uxl.getMessage('@message.common.success', '전체 XML파일 삭제'),
// 				fail : uxl.getMessage('@message.common.fail', '전체 XML파일 삭제')
// 			}
// 	};
// 	uxl.callFunction( url , option );	
// }

</script>