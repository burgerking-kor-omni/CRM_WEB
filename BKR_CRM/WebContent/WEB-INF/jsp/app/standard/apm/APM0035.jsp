<%--
#*
 *  파 일 명 :  APM0035.jsp
 *  설    명 :  코드 조회
 *  작 성 자 :  유기태
 *  작 성 일 :  2015.02.23
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
 
   - PAGE ID : APM0035R00
   - PAGE TYPE : JSP
 
  Copyright ⓒ UBONE Co., Ltd. All rights reserved.
 ========================================================================
--> 


<!-- layout-1 Start -->
<h1 class="ub-control title">코드 조회</h1>
<div class="ub-layout details "><h2 class="ub-control title">코드 정보</h2>
</div>
<form id="listForm" name="listForm"><div class="ub-layout list"><div class="ub-control temp" style="border:2px solid gray;width:100%;height:300px;text-align:center;"><h3 style="padding-top:120px;">Grid Control</h3></div>
<table class="ub-control grid" id="list" name="list"></table> 
	
</div>
<div class="ub-layout pagging"><div class="ub-control temp" style="border:2px solid gray;width:100%;height:30px;text-align:center;"><h3 style="padding-top:3px;">Paging Navigation</h3></div>
<div class="ub-control pagging"></div>
</div>
<input type=hidden id="CODE_CATEGORY_ID" name="CODE_CATEGORY_ID"    value="${paramMap.CODE_CATEGORY_ID}">
<input type=hidden id="CODE_TP" name="CODE_TP"    value="${paramMap.CODE_TP}">
</form>
<div class="ub-layout button bottom"><span class="ub-control button bottom icon" id="btnClose"        title="닫기">
    <a href="#none" title="닫기"><span class="ico-save"></span>닫기</a>
</span>
</div>
<!-- layout-1 End -->


<script type="text/javascript">
uxl.onLoad(function(){
	
	// Dynamic 코드 조회
	var options = {
			//header name
			colNames:['코드','코드명','상위코드','상태'] 
			
			//mapping column
			, colModel:[
			           {name:'CODE',width:100} 
			          ,{name:'CODE_NAME',width:100}
			          ,{name:'PARENT_CODE',width:100}
			          ,{name:'STATUS',width:50}
			         ]
			, autowidth:true
			, height:231
		};
	uxl.grid('list', options);
	
	fnSearchCode();
	
	$('#btnClose').click(function(){
		self.close();
	});
	
});	

function fnSearchCode(){
	var url = uxl.getFunctionUrl(_SCREEN_ID,'INQUIRY');
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
				uxl.grid.appendData('list' ,result , true );
			}
			, async:true
	};
	uxl.callSubmitFunction('listForm' , url , option );
}


</script>