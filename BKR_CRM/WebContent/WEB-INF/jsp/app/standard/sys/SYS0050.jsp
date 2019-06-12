<%--
 *
 *  설    명 :  시스템관리 / 프로그램 권한 관리
 *  작 성 자 :  관리자
 *  작 성 일 :  2013-05-15
 *  버    전 :  1.0
 *  기타사항 :
 *  Copyrights 2011 by ㈜ 유비원. All right reserved.
 * 
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/include/pageCommon.jsp"%>
<%@ page import="com.ubone.framework.util.ViewUtil"%>
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
	DataList _dl_TP_MENU_STRUCTURE = ViewUtil.getResult().getDataList("Code.TP_MENU_STRUCTURE");
%>


<!--  ========================================================================
  This page is generated with the UB-META™ ver4.0 
 
   - PAGE ID : SYS0050R00
   - PAGE TYPE : JSP
 
  Copyright ⓒ UBONE Co., Ltd. All rights reserved.
 ========================================================================
--> 


<!-- layout-1 Start -->
<h1 class="ub-control title">프로그램 권한 관리</h1>
<div class="ub-layout details"><div class="ub-layout search">
    <span class="search-ltbg"></span>
    <span class="search-rtbg"></span>
    <span class="search-lbbg"></span>
    <span class="search-rbbg"></span>
<form id="treeForm" name="treeForm"><table class="ub-control table normal ">
<colgroup>
<col width="80px"/>
<col width="250px"/>
<col width="80px"/>
<col />
</colgroup>
<tbody>
<tr id="layout-1_1">
<th id="layout-1_1_1"><label class="ub-control label">권한</label></th>
<td id="layout-1_1_2"><select id="ROLE_ID" name="ROLE_ID" class="ub-control select "     style="width:250px;" size="1" datacid="CD_ROLE"><%    if(!"선택안됨".equals("")){        out.println("<OPTION VALUE=\"\">선택안됨</OPTION>\r\n");    }    if(_dl_CD_ROLE != null){        for(int codeIdx=0; codeIdx < _dl_CD_ROLE.getRowCount(); codeIdx++){            String code = _dl_CD_ROLE.getString(codeIdx, ConstantHolder.CODE_COLUMN_CODE);            String name = _dl_CD_ROLE.getString(codeIdx, ConstantHolder.CODE_COLUMN_NAME);            out.println("<option VALUE=\""+code+"\">"+name+"</option>\r\n");        }    }%></select><input type=hidden id="LAZY_KEY" name="LAZY_KEY"></td>
<th id="layout-1_1_3"><label class="ub-control label">구분</label></th>
<td id="layout-1_1_4"><select id="MENU_STRUCTURE" name="MENU_STRUCTURE" class="ub-control select "     style="width:100px;" size="1" datacid="MENU_STRUCTURE">
<%	if(!"".equals("")){
		out.println("<OPTION VALUE=\"\"></OPTION>\r\n");
	}
	if(_dl_TP_MENU_STRUCTURE != null){
		for(int codeIdx=0; codeIdx < _dl_TP_MENU_STRUCTURE.getRowCount(); codeIdx++){
			String code = _dl_TP_MENU_STRUCTURE.getString(codeIdx, ConstantHolder.CODE_COLUMN_CODE);
			String name = _dl_TP_MENU_STRUCTURE.getString(codeIdx, ConstantHolder.CODE_COLUMN_NAME);
			out.println("<option VALUE=\""+code+"\">"+name+"</option>\r\n"); 
		}
	}
%>
</select></td>
</tr>
</tbody>
</table>
 
</form>

</div>
<div class="ub-layout floatBox"><div class="ub-layout leftBox"   style="width:30%;"><h2 class="ub-control title">Menu Structure</h2>
<div class="ub-layout treeBox"   style="height:400px;"><div class="ub-control temp" style="border:2px solid gray;width:100px;height:100px;text-align:center;"><h3 style="padding-top:20px;">Tree Control</h3></div>
<div id="menuTree" name="menuTree" class="ub-control tree"></div>
</div>
</div>
<div class="ub-layout rightBox"   style="width:69%;"><h2 class="ub-control title">Screen List<label id="screenTitle" name="screenTitle" class="ub-control label"></label>
<div class="ub-layout button inner"><span class="ub-control button inner icon" id="BTN_SCREEN_ADD">
    <a href="#none" title="Add"><span class="ico-add"></span>Add</a>
</span>
</div>
</h2>
<div class="ub-control temp" style="border:2px solid gray;width:100%;height:300px;text-align:center;"><h3 style="padding-top:120px;">Grid Control</h3></div>
<table class="ub-control grid" id="screenList" name="screenList"></table> 
	
<h2 class="ub-control title">Function List<label id="functionTitle" name="functionTitle" class="ub-control label"></label>
</h2>
<div class="ub-control temp" style="border:2px solid gray;width:100%;height:300px;text-align:center;"><h3 style="padding-top:120px;">Grid Control</h3></div>
<table class="ub-control grid" id="functionList" name="functionList"></table> 
	
</div>
</div>
</div>

<!-- layout-1 End -->


<script type="text/javascript">
// 전역변수
var _SELECTED_MENU_ID = ''; 		// 선택된 메뉴 ID
var _SELECTED_SCREEN_ID = ''; 		// 선택된 SCREEN ID
var treeOption = null;

// 문서 준비 핸들러
uxl.onLoad(function() {

	/***************************************
	 * TreeOption
	 ****************************************/
	treeOption = {
			 treeDivId : 'menuTree'				//트리DIV 영역ID [선택 : 기본값 = tree ]
			,screenId : _SCREEN_ID				//화면아이디	 [필수]
			,functionAlias : 'USERDEFINED1'		//트리리스트 호출 Function Alais [필수]
			,formId:'treeForm'				    //트리리스트 호출시 전송할 FormID [선택]
			,checkbox : true
			,clickFolderMode : 1 				// 1:activate, 2:expand, 3:activate and expand
			,minExpandLevel: 2					//기본펼침 [선택 1~3 기본 1]
			,checkbox : true					//체크박스 표시여부 [기본값 : false ]
			,selectMode : 2						//체크박스 선택모드 [기본값 : 1] 1:single, 2:multi, 3:multi-hier
			//lazy 모드 -------------------------------------------------------------------------------
			,lazyFormId : 'treeForm'			//lazy 로딩시 전송할 formID [lazy모드시 선택]
			,lazyParam : {}						//lazy 로딩시 전송할 param	[lazy모드시 선택]
			,lazyKeyInputId : 'LAZY_KEY'		//lazy 로딩시 key값을 설정할 input ID [lazy모드시 선택]
			,lazyFunctionAlias : 'USERDEFINED2'	//lazy 전송시 [lazy모드시 필수]
			//lazy 모드 -------------------------------------------------------------------------------
			,onActivate : function(node){
				_SELECTED_MENU_ID = node.data.key;
				
				// 화면 타이틀 초기화
				$('#screenTitle').text(" - "+node.data.title);

				// 화면 그리드 로드
				loadScreenInfo(node.data.key);
				
				// Function 그리드 클리어
				$('#functionTitle').text('');
				$('#functionList').jqGrid('clearGridData');
			}
			,onSelect : function(flag, node){
				updateMenuRole(flag, node);
			}
		};
	
	$('#ROLE_ID').change(function(){
		$('#LAZY_KEY').val('');
		if($('#ROLE_ID').val() == ''){
			$('#menuTree').empty();			
		}else{
			uxl.treeDraw(treeOption);	

			// Screen 그리드 클리어
			$('#screenTitle').text('');
			$('#screenList').jqGrid('clearGridData');
			
			// Function 그리드 클리어
			$('#functionTitle').text('');
			$('#functionList').jqGrid('clearGridData');
		}
	});

	// 메뉴 권한 설정
	var updateMenuRole = function(flag, node){
		var url = uxl.getFunctionUrl(_SCREEN_ID,'MODIFY');
		var options = {
				 data : {MENU_ID:node.data.id, ROLE_ID:$('#ROLE_ID').val(), CHECKED: flag}
				,success	: function(data){
				}
				,async 		: false
		};

		uxl.callFunction(url, options);
	};
	
	// Screen List Grid
	var options = {
			//header name
			colNames:['Type','Screen Id','Screen Name','Check Count', 'Del'] 
			
			//mapping column
			, colModel:[
				       {name:'SCREEN_TYPE',width:40, align:'center', codeCategory:'APMD_SCREEN_TYPE'}
			          ,{name:'SCREEN_ID',width:50, align:'center'}
			          ,{name:'SCREEN_NAME'}
			          ,{name:'CHK_CNT',width:50, align:'center'}
			          ,{name:'DEL',width:40, align:'center'}
			         ]
			, autowidth:true
			, multiselect:true
			, height:150
			, onSelectAll: function(aRowids, status){
				for(var i=0; i<aRowids.length; i++){
					var rowdata = $('#screenList').jqGrid('getRowData',aRowids[i]);
					updateScreenRole(rowdata.SCREEN_ID, status);
				}
			}
			, beforeSelectRow : function(rowid, e){
				if(e.srcElement.tagName == 'TD'){
					// Function List 조회
					var rowdata = $('#screenList').jqGrid('getRowData',rowid);
					_SELECTED_SCREEN_ID = rowdata.SCREEN_ID;
					loadFunctionInfo(_SELECTED_SCREEN_ID);
					return false;
				}else{
					return true;
				}
			}
			, onSelectRow : function(rowid, status, e){
				var rowdata = $('#screenList').jqGrid('getRowData',rowid);
				updateScreenRole(rowdata.SCREEN_ID, status);
			}
			, afterInsertRow: function(rowid, rowdata, rowelem){
				var $grid = $("#screenList");
				var button = "<span class='ub-control button inner' onclick=deleteMenuScreen('"+rowdata.SCREEN_ID+"')><a href='#'>삭제</a></span>";
// 				var button = "<input style='height:20px;width:60px;' type='button' value='삭제' onclick=\"deleteMenuScreen('"+rowdata.SCREEN_ID+"');\"  />";
				$grid.jqGrid('setRowData', rowid, {DEL:button});
			}
		};
	uxl.grid('screenList', options);
	
	// 조회권한 선택
	var combo = "<select id='retrive_all' class='ub-control select'></select>"; 
	
	// Function List Grid
	var options = {
			//header name
			colNames:['Alias','Function Id','Function Name', combo] 
			
			//mapping column
			, colModel:[
			           {name:'FUNCTION_ALIAS_ID',width:40, align:'left'}
			          ,{name:'FUNCTION_ID',width:50, align:'center'}
			          ,{name:'FUNCTION_NAME'}
			          ,{name:'RETRIVE_LEVEL',width:50, align:'center', sortable:false}
			         ]
			, autowidth:true
			, height:150
			, multiselect:true
			, onSelectAll: function(aRowids, status){
				for(var i=0; i<aRowids.length; i++){
					var rowdata = $('#functionList').jqGrid('getRowData',aRowids[i]);
					updateFunctionRole(rowdata.FUNCTION_ID, status);
				}
			}
			, beforeSelectRow : function(rowid, e){
				if(e.srcElement.tagName == 'TD'){
					return false;
				}else{
					return true;
				}
			}
			, onSelectRow : function(rowid, status, e){
				var rowdata = $('#functionList').jqGrid('getRowData',rowid);
				updateFunctionRole(rowdata.FUNCTION_ID, status);
			}
			, afterInsertRow: function(rowid, rowdata, rowelem){
				var $grid = $("#functionList");
				var comboId = "retrive_"+rowdata.FUNCTION_ID;
					
				var combo = "<select id='"+comboId+"' class='retriveCombo'></select>"; 
				$grid.jqGrid('setRowData', rowid, {RETRIVE_LEVEL:combo});
					
				$('#'+comboId).append($("#retrive_all option").clone());
				$('#'+comboId).val(rowdata.RETRIVE_LEVEL);

				// 개별 조회 권한 바인딩
				$('#'+comboId).change(function(){
					var functionId = this.id.split('_')[1];
					updateFunctionRole(functionId, true);				
				});
			}
			, loadComplete : function(){
				// 조회권한 All - 코드 바인딩
				uxl.bindComboCode($("#retrive_all"), "AUTHORITY_LEVEL", {emptyOption:false});
				
				// 조회권한 All - Change 처리
				$("#retrive_all").change(function(){
					$('.retriveCombo').val($(this).val()).change();
					loadFunctionInfo(_SELECTED_SCREEN_ID);
				});				
			}
		};
	uxl.grid('functionList', options);

	//Search Screen Popup
	$('#BTN_SCREEN_ADD').bind("click", function() {
		uxl.openWindow('Search_Screen', uxl.getScreenURL('SYS0051'), { width:'850px' ,height:'500px' }, callbackScreenAdd);		
	});
	
	//구조 SelectBox 변경시 이벤트
	$('#MENU_STRUCTURE').change(function(event){
		fnTreeDraw();
	});
});

function fnTreeDraw(){
	uxl.treeDraw(treeOption , '');
	
	// Screen 그리드 클리어
	$('#screenTitle').text('');
	$('#screenList').jqGrid('clearGridData');
	
	// Function 그리드 클리어
	$('#functionTitle').text('');
	$('#functionList').jqGrid('clearGridData');
}

// 화면 정보 로드
var loadScreenInfo = function(MENU_ID){
	var url = uxl.getFunctionUrl(_SCREEN_ID,'USERDEFINED3');
	var data = {MENU_ID:MENU_ID, ROLE_ID:$('#ROLE_ID').val()};
		data = $.extend(data, uxl.grid.getParam('screenList'));
	var options = {
			 data : data 
			,success	: function(result){
				uxl.grid.appendData('screenList' ,result , true );
			 }
			,async 		: false
	};

	uxl.callFunction(url, options);
};

//Callback Function Search Screen Popup
var callbackScreenAdd = function(data){
	var url = uxl.getFunctionUrl(_SCREEN_ID,'REGIST');
	
	var screenIds = "";
	for(var i=0; i<data.length; i++){
		screenIds += ","+data[i].SCREEN_ID;
	}
	
	var options = {
		 data : {MENU_ID:_SELECTED_MENU_ID, SCREEN_IDS:screenIds}
		,success	: function(data){
			loadScreenInfo(_SELECTED_MENU_ID);
		}
		,async 		: false
	};

	uxl.callFunction(url, options);
};

// 메뉴 연결 화면 삭제
var deleteMenuScreen = function(SCREEN_ID){
	if(confirm('삭제하시겠습니까?')){
		_SELECTED_SCREEN_ID = '';
		
		var url = uxl.getFunctionUrl(_SCREEN_ID,'REMOVE');
		var options = {
				 data : {MENU_ID:_SELECTED_MENU_ID, SCREEN_ID:SCREEN_ID}
				,success	: function(data){
					loadScreenInfo(_SELECTED_MENU_ID);
					loadFunctionInfo(_SELECTED_SCREEN_ID);
				}
				,async 		: false
		};
		uxl.callFunction(url, options);
	}
	event.stopPropagation();
};

// 메뉴권한 설정
var updateScreenRole = function(SCREEN_ID, CHECKED){
	var url = uxl.getFunctionUrl(_SCREEN_ID,'USERDEFINED4');
	var options = {
		 data : {SCREEN_ID:SCREEN_ID, ROLE_ID:$('#ROLE_ID').val(), CHECKED:CHECKED}
		,success	: function(data){
		}
		,async 		: false
	};
	uxl.callFunction(url, options);
};

// Function List 조회
var loadFunctionInfo = function(SCREEN_ID){
	updateFunctionTitle(SCREEN_ID);
//	$('#cb_functionList').attr('checked', false);
	
	var url = uxl.getFunctionUrl(_SCREEN_ID,'USERDEFINED5');
	var data = {SCREEN_ID:SCREEN_ID, ROLE_ID:$('#ROLE_ID').val()};
		data = $.extend(data, uxl.grid.getParam('functionList'));
	var options = {
			 data : data 
			,success	: function(result){
				uxl.grid.appendData('functionList' ,result , true );
			 }
			,async 		: false
	};

	uxl.callFunction(url, options);	
};

//Function권한 설정
var updateFunctionRole = function(FUNCTION_ID, CHECKED){
	var url = uxl.getFunctionUrl(_SCREEN_ID,'USERDEFINED6');
	var options = {
		 data : {
			   SCREEN_ID:_SELECTED_SCREEN_ID
			 , FUNCTION_ID:FUNCTION_ID
			 , ROLE_ID:$('#ROLE_ID').val()
			 , RETRIVE_LEVEL:$('#retrive_'+FUNCTION_ID).val()
			 , CHECKED:CHECKED
		}
		,success	: function(data){
			loadScreenInfo(_SELECTED_MENU_ID);
		}
		,async 		: false
	};
	uxl.callFunction(url, options);
};

var updateFunctionTitle = function(SCREEN_ID, Title){
	if(uxl.isNotNull(SCREEN_ID)){
		if(uxl.isNotNull(Title)){
			$('#functionTitle').text(" - ["+SCREEN_ID+"]::"+Title);
		}else{
			$('#functionTitle').text(" - ["+SCREEN_ID+"]");
		}
	}else{
		$('#functionTitle').text("");
	}
};
</script>
