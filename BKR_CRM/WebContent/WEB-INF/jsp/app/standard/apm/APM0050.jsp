<%--
 *
 *  설    명 :  시스템관리 / 메뉴 관리 (다국어용)
 *  작 성 자 :  이창섭
 *  작 성 일 :  2016-09-30
 *  버    전 :  1.0
 *  기타사항 :
 *  Copyrights 2016 by ㈜ 유비원. All right reserved.
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
	DataList _dl_TP_MENU_STRUCTURE = ViewUtil.getResult().getDataList("Code.TP_MENU_STRUCTURE");
	DataList _dl_MENU_TYPE = ViewUtil.getResult().getDataList("Code.MENU_TYPE");
	DataList _dl_STATUS = ViewUtil.getResult().getDataList("Code.STATUS");
%>


<!--  ========================================================================
  This page is generated with the UB-META™ ver4.0 
 
   - PAGE ID : SYS0011R00
   - PAGE TYPE : JSP
 
  Copyright ⓒ UBONE Co., Ltd. All rights reserved.
 ========================================================================
--> 


<!-- layout-1 Start -->
<h1 class="ub-control title">메뉴관리</h1>
<div class="ub-layout details">
	<div class="ub-layout floatBox">
		<div class="ub-layout leftBox"   style="width:30%;">
			<h2 class="ub-control title">메뉴구조
				<div class="ub-layout button inner"  style="text-align:right;">
					<label class="ub-control label">구분 : </label>
					<ub:code-select codeCategory="TP_MENU_STRUCTURE" id="MENU_STRUCTURE" style="width:120px;" blankType="0"/>
				</div>
			</h2>
			<form id="treeForm" name="treeForm">
				<input type=hidden id="LAZY_KEY" name="LAZY_KEY">
			</form>
			<div class="ub-layout treeBox"   style="height:465px;">
				<div class="ub-control temp" style="border:2px solid gray;width:100px;height:100px;text-align:center;"><h3 style="padding-top:20px;">Tree Control</h3></div>
				<div id="menuTree" name="menuTree" class="ub-control tree"></div>
			</div>
			<div class="ub-layout button inner"  style="text-align:right;"></div>
			<div class="ub-layout button bottom">
				<span class="ub-control button bottom icon" id="addNewNode">
    				<a href="#none" title="Add"><span class="ico-add"></span>신규등록</a>
				</span>
			</div>
		</div>
		<div class="ub-layout rightBox"   style="width:69%;">
			<h2 class="ub-control title">기본구조</h2>
			<form id="detailForm" name="detailForm">
				<table class="ub-control table normal ">
					<colgroup>
					<col width="150px"/>
					<col />
					<col width="150px"/>
					<col />
					</colgroup>
					<tbody>
					<tr id="layout-1_1">
					<th id="layout-1_1_1"><label class="ub-control label"             for="MENU_ID">메뉴 ID</label></th>
					<td id="layout-1_1_2"><input type=text  class="ub-control input-text " id="MENU_ID" name="MENU_ID"         readonly   metaessential="0"           style="text-align:left;width:150px;"></td>
					<th id="layout-1_1_3"><label class="ub-control label"             for="MENU_NAME">메뉴명</label></th>
					<td id="layout-1_1_4"><ub:message-column id="MENU_NAME" table="AP_MENU" column="MENU_NAME_RES_ID" style="width:150px;" essential="true"/></td>
					</tr>
					<tr id="layout-1_2">
					<th id="layout-1_2_5"><label class="ub-control label"             for="MENU_TYPE">메뉴유형</label></th>
					<td id="layout-1_2_6"><ub:code-select codeCategory="MENU_TYPE" id="MENU_TYPE" style="width:150px;" blankType="0" essential="true"/></td>
					<th id="layout-1_2_7"><label class="ub-control label"             for="PARENT_MENU_ID">상위메뉴</label></th>
					<td id="layout-1_2_8"><ub:code-select codeCategory="PARENT_MENU_ID" id="PARENT_MENU_ID" style="width:150px;" blankType="0"/></td>
					</tr>
					<tr id="layout-1_3">
					<th id="layout-1_3_9"><label class="ub-control label"             for="DESCRIPTION">설명</label></th>
					<td id="layout-1_3_10" colspan=3><textarea class="ub-control textarea " id="DESCRIPTION" name="DESCRIPTION"       style="width:400px;" rows="5"                  rows="5"></textarea></td>
					</tr>
					<tr id="layout-1_4">
					<th id="layout-1_4_11"><label class="ub-control label"             for="CONNECT_URL">연결URL</label></th>
					<td id="layout-1_4_12"><input type=text  class="ub-control input-text " id="CONNECT_URL" name="CONNECT_URL"                       style="text-align:left;width:90%;"></td>
					<th id="layout-1_4_13"><label class="ub-control label"             for="TARGET">타겟</label></th>
					<td id="layout-1_4_14"><input type=text  class="ub-control input-text " id="TARGET" name="TARGET"                       style="text-align:left;width:150px;"></td>
					</tr>
					<tr id="layout-1_5">
					<th id="layout-1_5_15"><label class="ub-control label"             for="SORT_ORDER">순서</label></th>
					<td id="layout-1_5_16"><input type=text  class="ub-control input-text " id="SORT_ORDER" name="SORT_ORDER"            metaessential="1"           style="text-align:left;width:150px;"></td>
					<th id="layout-1_5_17"><label class="ub-control label"             for="DEPTH">레벨(DEPTH)</label></th>
					<td id="layout-1_5_18"><input type=text  class="ub-control input-text " id="DEPTH" name="DEPTH"         readonly              style="text-align:left;width:150px;"></td>
					</tr>
					<tr id="layout-1_6">
					<th id="layout-1_6_19"><label class="ub-control label"             for="STATUS">상태</label></th>
					<td id="layout-1_6_20"><ub:code-select codeCategory="STATUS" id="STATUS" style="width:150px;" blankType="0" essential="true" /></td>
					<th id="layout-1_6_21"></th>
					<td id="layout-1_6_22"></td>
					</tr>
					<tr id="layout-1_7">
					<th id="layout-1_7_23"><label class="ub-control label"             for="WIDTH">팝업사이즈(width)</label></th>
					<td id="layout-1_7_24"><input type=text  class="ub-control input-text " id="WIDTH" name="WIDTH"                       style="text-align:left;width:150px;"></td>
					<th id="layout-1_7_25"><label class="ub-control label"             for="HEIGHT">팝업사이즈(height)</label></th>
					<td id="layout-1_7_26"><input type=text  class="ub-control input-text " id="HEIGHT" name="HEIGHT"                       style="text-align:left;width:150px;"></td>
					</tr>
					</tbody>
				</table>
			</form>
			<div class="ub-layout button bottom">
				<span class="ub-control button bottom icon" id="updateBtn">
   					<a href="#none" title="Save"><span class="ico-save"></span>저장</a>
				</span>
				<span class="ub-control button bottom icon" id="deleteBtn">
				    <a href="#none" title="Delete"><span class="ico-delete"></span>삭제</a>
				</span>
			</div>
<h2 class="ub-control title" id="screenTitle" name="screenTitle">Screen List<div class="ub-layout button inner"><span class="ub-control button inner icon" id="BTN_SCREEN_ADD">
    <a href="#none" title="Add"><span class="ico-add"></span>Add</a>
</span>
</div>
</h2>
<div class="ub-layout list"><div class="ub-control temp" style="border:2px solid gray;width:100%;height:300px;text-align:center;"><h3 style="padding-top:120px;">Grid Control</h3></div>
<table class="ub-control grid" id="screenList" name="screenList"></table> 
	
</div>
</div>
</div>
</div>

<!-- layout-1 End -->


<style type="text/css">
	.ub-layout.button.bottom {margin-bottom:2px;}
	.ub-control.title .ub-layout.button.inner{position:absolute; top:4px; right:0;}
</style>

<script type="text/javascript">

//전역변수
var _SELECTED_MENU_ID = ''; 		// 선택된 메뉴 ID
var _SELECTED_SCREEN_ID = ''; 		// 선택된 SCREEN ID
var treeOptions = null;

// 문서 준비 핸들러
uxl.onLoad(function() {
	treeOption = {
		treeDivId : 'menuTree'				//트리DIV 영역ID [선택 : 기본값 = tree ]
		,screenId : _SCREEN_ID				//화면아이디	 [필수]
		,functionAlias : 'INQUIRY'			//트리리스트 호출 Function Alais [필수]
		,formId:'treeForm'				    //트리리스트 호출시 전송할 FormID [선택]
		,param : {}							//전송할 인자값 [선택]
		,clickFolderMode :  3 				// 1:activate, 2:expand, 3:activate and expand
		,minExpandLevel:2						//기본펼침 [선택 1~3 기본 1]
		,checkbox : false					//체크박스 표시여부 [기본값 : false ]
		,selectMode : 1						//체크박스 선택모드 [기본값 : 1] 1:single, 2:multi, 3:multi-hier
		//lazy 모드 -------------------------------------------------------------------------------
		,lazyFormId : 'treeForm'			//lazy 로딩시 전송할 formID [lazy모드시 선택]
		,lazyParam : {}						//lazy 로딩시 전송할 param	[lazy모드시 선택]
		,lazyKeyInputId : 'LAZY_KEY'		//lazy 로딩시 key값을 설정할 input ID [lazy모드시 선택]
		,lazyFunctionAlias : 'USERDEFINED4'		//lazy 전송시 [lazy모드시 필수]
		//lazy 모드 -------------------------------------------------------------------------------
		,onActivate : function(node){ //node 선택시 이벤트
			
			fnGetDtail( node );
			_SELECTED_MENU_ID = node.data.key;
			loadScreenInfo(node.data.key);
		}		
	};
	
	treeOption.param = {MENU_STRUCTURE:$('#MENU_STRUCTURE').val()};
	uxl.treeDraw(treeOption , '');
 	
 	/***************************************
	* Update Menu
	***************************************/
	$('#updateBtn').click(function(){
		if(uxl.isEmpty($('#MENU_ID').val())){
			fnInsert();	
		}else{
			fnUpdate();	
		}
	});
 	
	/***************************************
	* Delete Menu
	***************************************/
	$('#deleteBtn').click(function(){
		fnDelete();	
	});
	
	/***************************************
	* Create New Menu
	***************************************/
	$('#addNewNode').click(function(){
		var node = uxl.getActivateNode('menuTree');
		
		if( !node ) {
			return;	
		}
		
		var menuMaxLevel = parseInt('<%=com.ubone.framework.ConfigHolder.MENU_MAX_LEVEL%>', 10);
		if(menuMaxLevel < parseInt($('#DEPTH').val(), 10)+1){
			uxl.showMessage("메뉴는 "+ menuMaxLevel +"단계 로 제한 되어 더 이상 하위 메뉴를 생성할 수 없습니다.");
			return false;
		}
		
		var newObj = [{
			"key":"New-Menu"
			,"id":"New-Menu"
			,"children":[]
			,"title":"New Menu"
			,"parentId":node.data.id
			,"toolTip":"New Menu"
			,"sortOrder":node.countChildren()+1
			,"depth":eval(node.data.depth) + 1
			,"extendData1":""
			,"extendData2":""
			,"extendData3":""
			,"extendData4":""
			,"extendData5":""}];
		
		node.data.isFolder = true;
		node.data.isLazy = true;
		node.bExpanded = true;
		var newNode = node.addChild(newObj);
		newNode.activate();
	});
	
	/***************************************
	* Change parent Menu
	***************************************/
	$('#PARENT_MENU_ID').change(function(){
		var node = uxl.getActivateNode('menuTree');
		
		if( !node ) return;
		
		if('' == this.value){
			$('#DEPTH').val(1); // Root에 세팅
		}else{
			if('1' == node.data.depth){
				$('#DEPTH').val(parseInt(node.data.depth, 10)+1); //초기값으로 세팅
			}else{
				$('#DEPTH').val(node.data.depth); //초기값으로 세팅
			}
		}
		
	});
	
	/***************************************
	* 메뉴유형 변경
	***************************************/
	$('#MENU_TYPE').change(function(){
		if('P'== this.value || 'L'== this.value){
			$('.ub-control.table tr:last-child').show();
			$('.ub-control.table tr:last-child input[type=text]').setRequired(true);
		}else{
			$('.ub-control.table tr:last-child').hide();
			$('.ub-control.table tr:last-child input[type=text]').val('').setRequired(false);
		}

		// 단구분자유형은 메뉴명을 데쉬로 처리한다.
		if('S'==this.value){
			$('#MENU_NAME').val('------------------------------');			
			$('#MENU_NAME_RES_ID').val('');
		}
	}).change();
	
	
	
	/***************************************
	* screen List 그리드
	***************************************/
	var options = {
			//header name
			colNames:['Type','Screen Id','Screen Name', 'Del'] 
			
			//mapping column
			, colModel:[
				       {name:'SCREEN_TYPE',width:40, align:'center'}//, codeCategory:'APMD_SCREEN_TYPE'
			          ,{name:'SCREEN_ID',width:50, align:'center'}
			          ,{name:'SCREEN_NAME'}
			          ,{name:'DEL',width:40, align:'center'}
			         ]
			, autowidth:true
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
			, gridComplete: function(){
				var $grid = $("#screenList");
				var ids = $grid.jqGrid('getDataIDs');
				for(var i=0;i < ids.length;i++){
					var cl = ids[i];
					var data = $grid.jqGrid('getRowData',cl);
					button = "<input style='height:20px;width:60px;' type='button' value='삭제' onclick=\"deleteMenuScreen('"+data.SCREEN_ID+"');\"  />"; 
					$grid.jqGrid('setRowData',ids[i],{DEL:button});
				}	
			}
		};
	uxl.grid('screenList', options);
	
	
	//Search Screen Popup
	$('#BTN_SCREEN_ADD').bind("click", function() {
// 		uxl.openWindow('Search_Screen', uxl.getScreenURL('SYS0051'), { width:'850px' ,height:'500px' }, callbackScreenAdd);
		uxl.openWindow('Search_Screen', uxl.getScreenURL('APM0051'), { width:'400px' ,height:'550px' }, callbackScreenAdd);
	});
	
	//메뉴구조 SelectBox 변경시 이벤트
	$('#MENU_STRUCTURE').change(function(event){
		treeOption.param = {MENU_STRUCTURE:$(this).val()};
		uxl.treeDraw(treeOption , '');
		fnClearMenuDetail();
	});
	
});


//Callback Function Search Screen Popup
var callbackScreenAdd = function(data){
	var url = uxl.getFunctionUrl(_SCREEN_ID,'USERDEFINED5');
	
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


function selectNode(result){
	data = result.getDetail();
	$('#MENU_NAME').val(data.MENU_NAME);		//메뉴명
	$('#MENU_NAME_RES_ID').val(data.MENU_NAME_RES_ID).change();		//메뉴명리소스ID
	$('#DESCRIPTION').val(data.DESCRIPTION);	//설명
	$('#HEIGHT').val(data.HEIGHT);		//높이
	$('#WIDTH').val(data.WIDTH);		//너비
	$('#PARENT_MENU_ID').val(data.PARENT_MENU_ID);	//상위메뉴ID
	$('#SORT_ORDER').val(data.SORT_ORDER);		//정렬순서
	$('#DEPTH').val(data.DEPTH);			//깊이
	$('#STATUS').val(data.STATUS);			//상태
	$('#MENU_TYPE').val(data.MENU_TYPE);		//메뉴유형
	$('#CONNECT_URL').val(data.CONNECT_URL);	//연결URL
	$('#TARGET').val(data.TARGET);			//Target
	
	$('#MENU_TYPE').change();
}


//상위메뉴ID 콤보박스를 세팅한다.
function setParentComboBox(node){
	var menuId = node.data.key;
    var parentId = node.data.parentId;
	var url = uxl.getFunctionUrl(_SCREEN_ID,'USERDEFINED2');
	var option = {
			  data:{MENU_STRUCTURE:$('#MENU_STRUCTURE').val()}
			, validator:function(data,targetForm){
				if(uxl.isEmpty(menuId)){
					return false;
				}
				return true;
			}
			, success:function(result){
				var combo = $('#PARENT_MENU_ID');
				
				var dataSet = result.getDataList(0).rows;
				var rowCount = result.getDataList(0).rowCount;
				
				
				if(node.data.key=="New-Menu"){
					combo.empty();
					combo.addOption(node.getParent().data.title ,node.getParent().data.key);
					
				}else{
					combo.emptySelect("");
					for( var i=0 ; i < rowCount ;  i++){
						combo.addOption(dataSet[i].MENU_NAME ,dataSet[i].MENU_ID);
					}
					combo.val(parentId);	
				}
				
				 
			}
			, async:false
			
	};
	uxl.callSubmitFunction('treeForm' , url , option );
}

/*
 * 메뉴를 수정한다.
 */
function fnUpdate(){
	var url = uxl.getFunctionUrl(_SCREEN_ID,'MODIFY');
	var option = {
			validator:function(data,targetForm){
				return uxl.checkRequiredFields(targetForm);
			}
			, success:function(result){
				var activeNode = uxl.getActivateNode("menuTree");
				activeNode.setTitle($('#MENU_NAME').val());
			}
			, async:false
			, message : {
				 confirm : uxl.getMessage('@message.common.update.confirm'),
				 success : uxl.getMessage('@message.common.update.success'),
				 fail : uxl.getMessage('@message.common.update.fail')
			  }
			
	};
	uxl.callSubmitFunction('detailForm' , url , option );
}


/*
 * 메뉴를 등록한다.
 */
function fnInsert(){
	var url = uxl.getFunctionUrl(_SCREEN_ID,'REGIST');
	var option = {
			  data : {MENU_STRUCTURE:$('#MENU_STRUCTURE').val()} 
			, validator:function(data,targetForm){
				return uxl.checkRequiredFields(targetForm);
			}
			, success:function(result){
				var activeNode = uxl.getActivateNode("menuTree");
				activeNode.data.id = result.getResultKey();
				activeNode.data.key = result.getResultKey();
				activeNode.setTitle($('#MENU_NAME').val());
				$('#MENU_ID').val(result.getResultKey());
			}
			, async:false
			, message : {
				 confirm : uxl.getMessage('@message.common.insert.confirm'),
				 success : uxl.getMessage('@message.common.insert.success'),
				 fail : uxl.getMessage('@message.common.insert.fail')
			  }
			
	};
	uxl.callSubmitFunction('detailForm' , url , option );
}
/*
 * 메뉴상세를 조회한다.
 */
function fnGetDtail(node){
	
	$('#LAZY_KEY').val(node.data.key);		//메뉴ID
	setParentComboBox(node);
	
	if(node.data.key=="ROOT"){
		$('#MENU_ID').val(node.data.id);		//메뉴ID
		$('#MENU_NAME').val(node.data.title);		//메뉴명
		$('#MENU_NAME_RES_ID').val('');				// 메뉴명 다국어 리소스 ID
		$('#DESCRIPTION').val(node.data.toolTip);	//설명
		$('#PARENT_MENU_ID').val("");	//상위메뉴ID
		$('#SORT_ORDER').val(node.data.sortOrder);		//정렬순서
		$('#DEPTH').val(node.data.depth);			//깊이
		$('#MENU_TYPE').val("N");		//메뉴유형
		$('#CONNECT_URL').val("");	//연결URL
		$('#TARGET').val("");			//Target
		
	}else if(node.data.key=="New-Menu"){
		$('#MENU_ID').val("");		//메뉴ID
		$('#MENU_NAME').val(node.data.title);		//메뉴명
		$('#MENU_NAME_RES_ID').val('');				// 메뉴명 다국어 리소스 ID
		$('#MENU_NAME_ID').val('');				//메뉴명리소스ID
		$('#DESCRIPTION').val(node.data.toolTip);	//설명
		$('#PARENT_MENU_ID').val(node.data.parentId);	//상위메뉴ID
		$('#SORT_ORDER').val(node.data.sortOrder);		//정렬순서
		$('#DEPTH').val(node.data.depth);			//깊이
		$('#MENU_TYPE').val("N");		//메뉴유형
		$('#CONNECT_URL').val("");	//연결URL
		$('#TARGET').val("");			//Target
	}else{
		$('#MENU_ID').val(node.data.key);		//메뉴ID
		var url = uxl.getFunctionUrl(_SCREEN_ID,'USERDEFINED3');
		var option = {
				success:function(result){
					selectNode(result);
				}
		};
		uxl.callSubmitFunction('detailForm' , url , option );
	}
}


/*
 * 메뉴삭제를 조회한다.
 */
function fnDelete(){
	
	var node = uxl.getActivateNode('menuTree');
	if( !node ) return;
	
	if(node.countChildren() != 0) return;
	
	if(node.data.key=="New-Menu"){
		if(node.getParent().countChildren() == 1){
			node.getParent().data.isFolder = false;
		} 
		node.remove();	
	}else{		
		$('#MENU_ID').val(node.data.key);
		var url = uxl.getFunctionUrl(_SCREEN_ID,'REMOVE');
		var option = {
				success:function(result){
					if(node.getParent().countChildren() == 1) {
						node.getParent().data.isFolder = false;
					} 
					node.remove();
					$('#MENU_ID').val("");		//메뉴ID
					$('#MENU_NAME').val("");		//메뉴명
					$('#MENU_NAME_RES_ID').val("");	//메뉴명리소스ID
					$('#DESCRIPTION').val("");		//설명
					$('#PARENT_MENU_ID').val("");	//상위메뉴ID
					$('#SORT_ORDER').val("");		//정렬순서
					$('#DEPTH').val("");			//깊이
					$('#MENU_TYPE').val("N");		//메뉴유형
					$('#CONNECT_URL').val("");	//연결URL
					$('#TARGET').val("");			//Target
					
				}
				, message : {
				  	confirm : uxl.getMessage('@message.common.delete.confirm'),
					success : uxl.getMessage('@message.common.delete.success'),
					fail : uxl.getMessage('@message.common.delete.fail')
				}
		};
		uxl.callSubmitFunction('detailForm' , url , option );
	}
}

function fnClearMenuDetail(){
	$('#MENU_ID').val("");		//메뉴ID
	$('#MENU_NAME').val("");		//메뉴명
	$('#MENU_NAME_RES_ID').val("");	//메뉴명리소스ID
	$('#DESCRIPTION').val("");	//설명
	$('#PARENT_MENU_ID').val("");	//상위메뉴ID
	$('#SORT_ORDER').val("");		//정렬순서
	$('#DEPTH').val("");			//깊이
	$('#MENU_TYPE').val("N");		//메뉴유형
	$('#CONNECT_URL').val("");	//연결URL
	$('#TARGET').val("");			//Target
	
	uxl.grid.clearGridData('screenList');
}

//화면 정보 로드
var loadScreenInfo = function(MENU_ID){
	var url = uxl.getFunctionUrl(_SCREEN_ID,'USERDEFINED6');
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

//화면 정보 로드
var loadScreenInfo = function(MENU_ID){
	var url = uxl.getFunctionUrl(_SCREEN_ID,'USERDEFINED7');
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

//메뉴 연결 화면 삭제
var deleteMenuScreen = function(SCREEN_ID){
	if(confirm('삭제하시겠습니까?')){
		var url = uxl.getFunctionUrl(_SCREEN_ID,'USERDEFINED8');
		var options = {
				 data : {MENU_ID:_SELECTED_MENU_ID, SCREEN_ID:SCREEN_ID}
				,success	: function(data){
					loadScreenInfo(_SELECTED_MENU_ID);
				}
				,async 		: false
		};
		uxl.callFunction(url, options);
	}
	event.stopPropagation();
};


</script>
