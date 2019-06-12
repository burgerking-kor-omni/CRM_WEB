<%--
#*
 *  파 일 명 :  APM0067.jsp
 *  설    명 :  Screen 조회 팝업 (XML용)
 *  작 성 자 :  김병기
 *  작 성 일 :  2016-10-10
 *  버    전 :  1.0
 *  기타사항 :
 *  Copyrights 2016 by ㈜ 유비원. All right reserved.
*# 
--%>
<%@page import="com.ubone.framework.util.ViewUtil"%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/include/pageCommon.jsp" %>
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
	DataList _dl_SCREEN_TYPE = ViewUtil.getResult().getDataList("Code.APMD_SCREEN_TYPE");
	DataList _dl_SCREEN_VIEW_TYPE = ViewUtil.getResult().getDataList("Code.APMD_SCREEN_VIEW_TYPE");
%>


<!--  ========================================================================
  This page is generated with the UB-META™ ver5.0 
 
   - PAGE ID : APM0067R00
   - PAGE TYPE : JSP
 
  Copyright ⓒ UBONE Co., Ltd. All rights reserved.
 ========================================================================
--> 

<!-- layout-1 Start -->
<h1 class="ub-control title">Screen 검색</h1>
<div class="ub-layout details">
	<form id="treeForm" name="treeForm">
		<input type=hidden id="LAZY_KEY" name="LAZY_KEY">
	</form>
	<div class="ub-layout treeBox" id="treeList" name="treeList"   style="height:400px;">
		<div class="ub-control temp" style="border:2px solid gray;width:100px;height:100px;text-align:center;">
			<h3 style="padding-top:20px;">Tree Control</h3>
		</div>
		<div id="tree" name="tree" class="ub-control tree"></div>
	</div>
</div>
<div class="ub-layout button bottom">
	<span class="ub-control button bottom icon" id="btnSelect">
    	<a href="#none" title="Save"><span class="ico-save"></span>선택</a>
	</span>
</div>

<!-- layout-1 End -->

<script type="text/javascript">

var activeNodes = new Array();

uxl.onLoad(function(){
	
	var treeOption = {
		 treeDivId : 'tree'					//트리DIV 영역ID [선택 : 기본값 = tree ]
		,screenId : _SCREEN_ID				//화면아이디	 [필수]
		,functionAlias : 'INQUIRY'			//트리리스트 호출 Function Alais [필수]
		,formId:'treeForm'				    //트리리스트 호출시 전송할 FormID [선택]
		,param : {}							//전송할 인자값 [선택]
		,clickFolderMode :  3 				// 1:activate, 2:expand, 3:activate and expand
		,minExpandLevel:2					//기본펼침 [선택 1~3 기본 1]
		,checkbox : true					//체크박스 표시여부 [기본값 : false ]
		,selectMode : 2						//체크박스 선택모드 [기본값 : 1] 1:single, 2:multi, 3:multi-hier
		//lazy 모드 -------------------------------------------------------------------------------
		,lazyFormId : 'treeForm'			//lazy 로딩시 전송할 formID [lazy모드시 선택]
		,lazyParam : {}						//lazy 로딩시 전송할 param	[lazy모드시 선택]
		,lazyKeyInputId : 'LAZY_KEY'		//lazy 로딩시 key값을 설정할 input ID [lazy모드시 선택]
		,lazyFunctionAlias : 'USERDEFINED1'		//lazy 전송시 [lazy모드시 필수]
		//lazy 모드 -------------------------------------------------------------------------------
		,onActivate : function(node){ //node 선택시 이벤트
		    $('#LAZY_KEY').val(node.data.key);		//메뉴ID
// 		    activeNode = node;
		}
		,onSelect: function(flag,node) {
			if(node.data.folderYn == "Y"){
				if(flag){
					uxl.showMessage("폴더는 선택할 수 없습니다.");
					node.select(false);	
				}
			}else if(flag){
				activeNodes.push(node);	
			}else{
				for(var i = 0 ; i < activeNodes.length ; i ++){
					if(activeNodes[i] == node){
						activeNodes.splice(i,1);
						break;
					}
				}
			}
		}
	};
 	uxl.treeDraw(treeOption , '');
	
 	$('#btnSelect').click(function(event){
		fnSetReturnData();
	});
 	
 	
	
});

function fnSetReturnData(){
	if(activeNodes.length == 0){
		alert("선택된 항목이 없습니다. 확인후 다시 실행하십시오.");
		return;
	}
	
	var selectData = [];
	for(var i=0; i<activeNodes.length; i++){
		var data = {
				SCREEN_ID			: activeNodes[i].data.id			// 화면ID
			,	SCREEN_NAME			: activeNodes[i].data.title			// 화면명
// 			,	SCREEN_TYPE			: rowdata.SCREEN_TYPE				// 화면유형
		};
		selectData.push(data);		
	}
	uxl.pushToParent(selectData);				
	self.close();

// 	var data = {
// 			SCREEN_ID			: activeNode.data.key
// 		,	SCREEN_NAME			: activeNode.data.title
// 		,	SCREEN_TYPE			: rowdata.SCREEN_TYPE				// 화면유형
// 	};

// 	uxl.pushToParent(data);				
// 	self.close();
}

</script>
		 