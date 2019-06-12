<%--
#*
 *  파 일 명 :  APP0009.jsp
 *  설    명 :  결재선 등록
 *  작 성 자 :  김범수
 *  작 성 일 :  2013-11-27
 *  버    전 :  1.0
 *  기타사항 :
 *  Copyrights 2011 by ㈜ 유비원. All right reserved.
*# 
--%>
<%@page import="com.ubone.framework.data.DataList"%>
<%@page import="com.ubone.framework.util.ViewUtil"%>
<%@page import="java.util.Map"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/include/pageCommon.jsp" %>
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
 
   - PAGE ID : APP0009R00
   - PAGE TYPE : JSP
 
  Copyright ⓒ UBONE Co., Ltd. All rights reserved.
 ========================================================================
--> 


<!-- layout-1 Start -->
<h1 class="ub-control title">결재선 작성</h1>
<div class="ub-layout details"><div class="ub-layout floatBox"><div class="ub-layout leftBox"   style="width:40%;"><h2 class="ub-control title">부서</h2>
<form id="treeForm" name="treeForm"><input type=hidden id="LAZY_KEY" name="LAZY_KEY">
<table class="ub-control table normal ">
<colgroup>
<col width="22%"/>
<col />
</colgroup>
<tbody>
<tr id="layout-1_1">
<th id="layout-1_1_1"><label class="ub-control label"             for="DEPT_NM">부서</label></th>
<td id="layout-1_1_2"><input type=text  class="ub-control input-text " id="DEPT_NM" name="DEPT_NM"            metaessential="1"             style="ime-mode:active;text-align:left;width:100px;"><a href="#none" title="search" class="ub-control button imgBtn img-search" id="fnSearch_dept" name="fnSearch_dept"><span>@@</span></a><span class="ub-control button inner icon" id="showTree">    <a href="#none" title="조직도"><span></span>조직도</a></span></td>
</tr>
</tbody>
</table>
 
</form>
<div class="ub-layout treeBox" id="treeList" name="treeList"   style="height:400px;"><div class="ub-control temp" style="border:2px solid gray;width:100px;height:100px;text-align:center;"><h3 style="padding-top:20px;">Tree Control</h3></div>
<div id="deptTree" name="deptTree" class="ub-control tree"></div>
</div>
<div class="ub-layout list" id="deptList" name="deptList"    style="height:400px;" IsContainer="truewidth:300px;"><div class="ub-control temp" style="border:2px solid gray;width:100%;height:300px;text-align:center;"><h3 style="padding-top:120px;">Grid Control</h3></div>
<table class="ub-control grid" id="list_dept" name="list_dept"></table> 
	
</div>
</div>
<div class="ub-layout rightBox"   style="width:57%;"><h2 class="ub-control title">직원</h2>
<form id="searchForm" name="searchForm"><table class="ub-control table normal ">
<colgroup>
<col />
<col />
</colgroup>
<tbody>
<tr id="layout-1_1">
<th id="layout-1_1_1"><label class="ub-control label"             for="NM_USER">직원찾기</label></th>
<td id="layout-1_1_2"><input type=text  class="ub-control input-text " id="NM_USER" name="NM_USER"            metaessential="1"             style="ime-mode:active;text-align:left;width:120px;"><input type=hidden id="DEPT_ID_REAL" name="DEPT_ID_REAL"><a href="#none" title="search" class="ub-control button imgBtn img-search" id="fnSearch" name="fnSearch"><span>@@</span></a></td>
</tr>
</tbody>
</table>
 
</form>
<div class="ub-layout list"><div class="ub-control temp" style="border:2px solid gray;width:100%;height:300px;text-align:center;"><h3 style="padding-top:120px;">Grid Control</h3></div>
<table class="ub-control grid" id="list" name="list"></table> 
	
</div>
<h2 class="ub-control title"> 결재선 작성</h2>
<form id="registForm" name="registForm"><table class="ub-control table normal ">
<colgroup>
<col />
<col />
</colgroup>
<tbody>
<tr id="layout-1_1">
<th id="layout-1_1_1"><label class="ub-control label"             for="NM_APPR_LINE">결재라인 제목</label></th>
<td id="layout-1_1_2"><input type=text  class="ub-control input-text " id="NM_APPR_LINE" name="NM_APPR_LINE"            metaessential="1"           style="text-align:left;width:190px;"></td>
</tr>
<tr id="layout-1_2">
<th id="layout-1_2_3"><label class="ub-control label"             for="DS_REMARK">결재라인 설명</label></th>
<td id="layout-1_2_4"><textarea class="ub-control textarea " id="DS_REMARK" name="DS_REMARK"       style="width:200px;" rows="5"      metaessential="1"            rows="5"></textarea></td>
</tr>
</tbody>
</table>
 
</form>
<div class="ub-layout list"><div class="ub-control temp" style="border:2px solid gray;width:100%;height:300px;text-align:center;"><h3 style="padding-top:120px;">Grid Control</h3></div>
<table class="ub-control grid" id="list2" name="list2"></table> 
	
</div>
</div>
</div>
</div>
<div class="ub-layout button bottom"><span class="ub-control button bottom icon" id="save">
    <a href="#none" title="저장"><span></span>저장</a>
</span>
<span class="ub-control button bottom icon" id="close">
    <a href="#none" title="닫기"><span></span>닫기</a>
</span>
</div>

<!-- layout-1 End -->


<script type="text/javascript">
uxl.onLoad(function() {

	//초기 화면 셋팅에서 부서목록 조회화면은 감춘다.
	$('#deptList').hide();

	var treeOption = {
			treeDivId : 'deptTree'				//트리DIV 영역ID [선택 : 기본값 = tree ]
			,screenId : _SCREEN_ID				//화면아이디	 [필수]
			,functionAlias : 'INQUIRY'			//트리리스트 호출 Function Alais [필수]
			,formId:'treeForm'				    //트리리스트 호출시 전송할 FormID [선택]
			,param : {DEPTH:'1'}				//전송할 인자값 [선택]
			,clickFolderMode :  3 				// 1:activate, 2:expand, 3:activate and expand
			,minExpandLevel:1					//기본펼침 [선택 1~3 기본 1]
			,checkbox : false					//체크박스 표시여부 [기본값 : false ]
			,selectMode : 1						//체크박스 선택모드 [기본값 : 1] 1:single, 2:multi, 3:multi-hier
			//lazy 모드 -------------------------------------------------------------------------------
			,lazyFormId : 'treeForm'			//lazy 로딩시 전송할 formID [lazy모드시 선택]
			,lazyParam : {}						//lazy 로딩시 전송할 param	[lazy모드시 선택]
			,lazyKeyInputId : 'LAZY_KEY'		//lazy 로딩시 key값을 설정할 input ID [lazy모드시 선택]
			,lazyFunctionAlias : 'USERDEFINED3'		//lazy 전송시 [lazy모드시 필수]
			//lazy 모드 -------------------------------------------------------------------------------
			,onActivate : function(node){ //node 선택시 이벤트
			    $('#LAZY_KEY').val(node.data.key);		//메뉴ID
			    //검색할 부서의 정보를 hidden값에 맵핑
			    $('#DEPT_ID_REAL').val(node.data.key);		//메뉴ID
				//고객이름은 검색에서 제외
				$('#NM_USER').val('');		//메뉴ID
				fnSearch(node);
			}		
		};
 	uxl.treeDraw(treeOption , '');
 	
 	//직원목록 JqGrid (RightBox)
 	var options = {
		//header name
		colNames:['직책코드','직책','사번','이름','부서명','부서코드'] 
		
		//mapping column
		,colModel:[
		           {name:'DUTY_CD' ,width:30,hidden:true}
		          ,{name:'DUTY_NM', width:30, align:'center'}
		          ,{name:'USER_ID',width:120,hidden:true}
		          ,{name:'USER_NM',width:30, align:'center'}
		          ,{name:'DEPT_NM',width:30}
		          ,{name:'DEPT_ID_REAL',width:40, align:'center'}
		         ]
		,autowidth:true
		,height:100/*
		,onSelectRow:function(rowid, status, e){
			    if($('#jqg_list_'+rowid).is(":checked")){
	    			$(this).resetSelection();
			    	$(this).setSelection(rowid, false);
				}
			}
		,onSelectAll: function(aRowids,status) { 
				jQuery("#list").jqGrid('resetSelection');
			}*/
			
		, onSelectRow: function(rowid){
			var selectedRow = $(this).getRowData(rowid);

			fnPushToGrid02(selectedRow);
		}	
	};
	uxl.grid('list', options);
	
	
	//결재선직원목록 JqGrid (RightBox)
 	var options = {
		//header name
		colNames:['결재형태코드', '결재형태', '부서코드','순서','부서','직책코드','직책','성명코드','성명','기능'] 
		
		//mapping column
		,colModel:[
		          /*  {name:'TP_APPR_LINE' ,sortable: false,align:'center',width:20,editable: true
		           						,formatter: 'select'
		           						,edittype: 'select'
		           						,editoptions: {
		           							value: {'01': '결재','02': '협의'} 
		           						   ,dataEvents: [{ type: 'change'
		           										, fn: function(e) {
		           											var tempRow = $(e.target).closest('tr.jqgrow').get(0);
		           											$('#list2').saveRow(tempRow.id);
														}
													  }]
				    }} */
				   {name:'TP_APPR_LINE',width:0,hidden:true,sortable: false}
				  ,{name:'TP_APPR_LINE_NM',width:29,align:'center',sortable: false,hidden:true}
		          ,{name:'ID_DEPT',width:0,hidden:true,sortable: false}
		          ,{name:'ID_ORDER',width:29,align:'center',sortable: false}
		          ,{name:'NM_DEPT',width:40,align:'center',sortable: false}
		          ,{name:'DUTY_CD',width:0,hidden:true,sortable: false}
		          ,{name:'DUTY_NM',width:30,align:'center',sortable: false}
		          ,{name:'ID_EMP',width:0,hidden:true,sortable: false}
		          ,{name:'NM_EMP',width:30,align:'center',sortable: false}
		          ,{name:'EDIT_ROW',width:70, fixed:true,align:'center',formatter:formatOpt1,sortable: false}
		         ]
		,autowidth:true
		,height:100
		,editurl: 'clientArray'		
		, onSelectRow: function(rowid){
			var selectedRow = $(this).getRowData(rowid);
		}
	};
	uxl.grid('list2', options);
	
	$('#cb_list').hide();
	
	//부서목록 JqGrid (LeftBox)
	var options_dept = {
		//header name
		colNames:['부서코드','부서명'] 
		
		//mapping column
		,colModel:[
		           {name:'DEPT_ID' ,width:60,hidden:true}
		          ,{name:'DEPT_NM_FULL',width:286}
		         ]
		,autowidth:true
		,onSelectRow:function(rowid, status, e){
			    if($('#jqg_list_dept_'+rowid).is(":checked")){
	    			$(this).resetSelection();
			    	$(this).setSelection(rowid, false);
				}
				
				var selectedRow = $(this).getRowData(rowid);
				//선택한 검색 부서 리스트 결과의 부서ID를 맵핑
				$('#DEPT_ID_REAL').val(selectedRow.DEPT_ID);		//메뉴ID
				//고객이름은 검색에서 제외
				$('#NM_USER').val('');		//메뉴ID
				fnSearch();
			}
		,onSelectAll: function(aRowids,status) { 
				jQuery("#list_dept").jqGrid('resetSelection');
			}	
		
	};
	uxl.grid('list_dept', options_dept);
 	
 	
 	/***************************************
	* 부서검색 (getDeptList)
	***************************************/
	$('#fnSearch_dept').click(function(){
		//부서검색 시 직원목록 Grid는 초기화를 해준다.
		$("#list").clearGridData();
		
		var url = uxl.getFunctionUrl(_SCREEN_ID,'USERDEFINED2');
		var option = {
			  data:uxl.grid.getParam('list_dept')
			, validator:function(data,targetForm){
					var returnVal = false;
					//필수항목체크
					if(uxl.checkRequiredFields(targetForm)){
						returnVal = true;
					}
					
					return returnVal;
			}
			/*
			 * 조회한 데이터를 그리드에 추가함.
			 * @param {String} 그리드로 변환할 테이블ID
			 * @param {Result} 조회된 데이터 객체 result
			 * @param {boolean} 데이터 추가시 기존데이터의 clear 여부
			 */
			, success:function(result){
				$('#treeList').hide();		//조직트리는 숨긴다.
				$('#deptList').show();	//부서리스트  Grid를 보여준다.
				uxl.grid.appendData('list_dept' ,result , true );
			}
			, async:true
		};
	uxl.callSubmitFunction('treeForm' , url , option );	
	});
 	
	/***************************************
	* 직원 찾기 검색
	***************************************/
	$('#fnSearch').click(function(){
		
		//부서의 정보는 공백으로 처리해서 검색조건에 해당하지 않게함.
		$('#DEPT_ID_REAL').val('');
		fnSearch();	
	});
	
	/***************************************
	* 조직도
	***************************************/
	$('#showTree').click(function(){
		$('#deptList').hide(); // 부서검색 결과LIST 화면을 숨긴다.
		$('#treeList').show(); // 조직 트리를 보여준다.
	});
	
	/***************************************
	* 확인
	***************************************/
	$('#save').click(function(){
		var rowid = $('#list2').jqGrid('getRowData');
		//이슈리스트 항목에서 아무것도 선택하지 않으면 과제등록을 할 수 없다.
		if(rowid.length==0){
			alert("결재선을 등록하세요.");
			return;
		}			
		fnSave();
	});
	$('#close').click(function(){
		self.close();
	});
	//Enter Key 이벤트
	$('#DEPT_NM').keydown(function(event) {
		if(event.keyCode == '13') {
			fnSearch_dept();
			return false;
		}
	});
	
	//Enter Key 이벤트
	$('#NM_USER').keydown(function(event) {
		if(event.keyCode == '13') {
			fnSearch();
			return false;
		}
	});	
});

//위로가기 버튼 클릭시
function upLine(index){
	
	var rowids = $('#list2').jqGrid('getRowData');
	var data=new Array(rowids.legnth);
	//jqgrid 안의 데이터를 저장
	for(var i=0;i<rowids.length;i++){
		data[i]=rowids[i];
	}
	
	//row가 1번째 줄이 아닐경우만
	if(index>1){
	
		//해당 데이터와 윗줄의 데이터를 바꾼다.
		data[index-2] = {
						TP_APPR_LINE	: rowids[index-1].TP_APPR_LINE
					,	TP_APPR_LINE_NM	: rowids[index-1].TP_APPR_LINE_NM
					,   ID_ORDER		: rowids[index-2].ID_ORDER
					,	ID_DEPT			: rowids[index-1].ID_DEPT				//부서코드
					,	NM_DEPT			: rowids[index-1].NM_DEPT				//부서명
					,	DUTY_CD			: rowids[index-1].DUTY_CD			//직책코드
					,	DUTY_NM			: rowids[index-1].DUTY_NM			//직책명
					,	ID_EMP			: rowids[index-1].ID_EMP				//아이디
					,	NM_EMP			: rowids[index-1].NM_EMP				//이름
					,	EDIT_ROW		: rowids[index-2].EDIT_ROW
				};
		data[index-1] = {
						TP_APPR_LINE	: rowids[index-2].TP_APPR_LINE
					,	TP_APPR_LINE_NM	: rowids[index-2].TP_APPR_LINE_NM
					,   ID_ORDER		: rowids[index-1].ID_ORDER
					,	ID_DEPT			: rowids[index-2].ID_DEPT				//부서코드
					,	NM_DEPT			: rowids[index-2].NM_DEPT				//부서명
					,	DUTY_CD			: rowids[index-2].DUTY_CD		//직책코드
					,	DUTY_NM			: rowids[index-2].DUTY_NM			//직책명
					,	ID_EMP			: rowids[index-2].ID_EMP				//아이디
					,	NM_EMP			: rowids[index-2].NM_EMP				//이름
					,	EDIT_ROW		: rowids[index-1].EDIT_ROW
				};
				
	
		//grid 안의 데이터를 모두 삭제
		for(var i=0;i<rowids.length;i++){
			$("#list2").jqGrid('delRowData', i+1);
		}
		//grid 안의 데이터를 정렬된 값으로 다시 셋팅
		for(var i=0;i<rowids.length;i++){
			$("#list2").jqGrid('addRowData', i+1 , data[i]);
		}
	}		
}

//아래로 가기 버튼 클릭시
function downLine(index){
	
	var rowids = $('#list2').jqGrid('getRowData');
	var data=new Array(rowids.legnth);
	//jqgrid 안의 데이터를 저장
	for(var i=0;i<rowids.length;i++){
		data[i]=rowids[i];
	}
	
	//row가 마지막줄이 아닐경우만
	if(rowids.length > index){
		//해당 데이터와 아랫줄의 데이터를 바꾼다.
		data[index] = {
						TP_APPR_LINE	: rowids[index-1].TP_APPR_LINE
					,	TP_APPR_LINE_NM	: rowids[index-1].TP_APPR_LINE_NM
					,   ID_ORDER		: rowids[index].ID_ORDER
					,	ID_DEPT			: rowids[index-1].ID_DEPT				//부서코드
					,	NM_DEPT			: rowids[index-1].NM_DEPT				//부서명
					,	DUTY_CD			: rowids[index-1].DUTY_CD			//직책코드
					,	DUTY_NM			: rowids[index-1].DUTY_NM			//직책명
					,	ID_EMP			: rowids[index-1].ID_EMP				//아이디
					,	NM_EMP			: rowids[index-1].NM_EMP				//이름
					,	EDIT_ROW		: rowids[index].EDIT_ROW
				};
		data[index-1] = {
						TP_APPR_LINE	: rowids[index].TP_APPR_LINE
					,	TP_APPR_LINE_NM	: rowids[index].TP_APPR_LINE_NM
					,   ID_ORDER		: rowids[index-1].ID_ORDER
					,	ID_DEPT			: rowids[index].ID_DEPT				//부서코드
					,	NM_DEPT			: rowids[index].NM_DEPT				//부서명
					,	DUTY_CD			: rowids[index].DUTY_CD			//직책코드
					,	DUTY_NM			: rowids[index].DUTY_NM			//직책명
					,	ID_EMP			: rowids[index].ID_EMP				//아이디
					,	NM_EMP			: rowids[index].NM_EMP				//이름
					,	EDIT_ROW		: rowids[index-1].EDIT_ROW
				};
			
	
		//grid 안의 데이터를 모두 삭제
		for(var i=0;i<rowids.length;i++){
			$("#list2").jqGrid('delRowData', i+1);
		}
		//grid 안의 데이터를 정렬된 값으로 다시 셋팅
		for(var i=0;i<rowids.length;i++){
			$("#list2").jqGrid('addRowData', i+1 , data[i]);
		}
	}		
}

//삭제버튼
function deleteBtn(index){
	var rowids = $('#list2').jqGrid('getRowData');
	
	var data=new Array(rowids.legnth);
	//jqgrid 안의 데이터를 저장
	for(var i=0;i<rowids.length;i++){
		data[i]=rowids[i];
	}
	
	for(var i=(index-1);i<(rowids.length-1);i++){
		data[i] = {
					TP_APPR_LINE	: rowids[i+1].TP_APPR_LINE
				,	TP_APPR_LINE_NM	: rowids[i+1].TP_APPR_LINE_NM
				, 	ID_ORDER		: rowids[i].ID_ORDER
				,	ID_DEPT			: rowids[i+1].ID_DEPT				//부서코드
				,	NM_DEPT			: rowids[i+1].NM_DEPT				//부서명
				,	DUTY_CD			: rowids[i+1].DUTY_CD				//직책코드
				,	DUTY_NM			: rowids[i+1].DUTY_NM				//직책명
				,	ID_EMP			: rowids[i+1].ID_EMP				//아이디
				,	NM_EMP			: rowids[i+1].NM_EMP				//이름
				,	EDIT_ROW		: rowids[i].EDIT_ROW
			};
	}
	//grid 안의 데이터를 모두 삭제
	for(var i=0;i<rowids.length;i++){
		$("#list2").jqGrid('delRowData', i+1);
	}
	//grid 안의 데이터를 정렬된 값으로 다시 셋팅
	for(var i=0;i<(rowids.length-1);i++){
		$("#list2").jqGrid('addRowData', i+1 , data[i]);
	}
}

//jqgrid 안의 버튼 구현
function formatOpt1(cellvalue, options, rowObject){
	var str = "";

	str += '<div class="ub-layout rightBox" value="'+options.rowId+'"><a href="javaScript:upLine('+(options.rowId)+')" title="위" class="ub-control button imgBtn img-up" id="UP_LINE" name="UP_LINE"><span></span></a><a href="javaScript:downLine('+(options.rowId)+')" title="아래" class="ub-control button imgBtn img-down" id="DOWN_LINE" name="DOWN_LINE"><span></span></a><a href="javaScript:deleteBtn('+(options.rowId)+')" title="삭제" class="ub-control button imgBtn img-minus" id="DELETE_LINE" name="DELETE_LINE"><span></span></a></div>';    
  	
	return str;
}
function fnPushToGrid02(selectedRow){
	var listcount = $("#list2").getGridParam("reccount");
   	var list2IdEmp = new Array(listcount);
   	for (var i = 0; i <= listcount; i++) {
		var selectedRow2 = $("#list2").getRowData(i);
		list2IdEmp[i] = selectedRow2.ID_EMP;
	}
   	var idEmp = selectedRow.USER_ID;
  	//선택한 결재자가 이미 등록되어 있는지 확인한다.
	for(var i=0; i<list2IdEmp.length; i++)
		{ 
			if(list2IdEmp[i] == idEmp){ 
			alert("동일한 결재자를 추가할 수  없습니다.");
			return;
	   	}
	}
	  		     
	var userData = {
					TP_APPR_LINE	: '02'
				,	TP_APPR_LINE_NM	: '결재'
				,   ID_ORDER		: listcount+1
				,	ID_DEPT			: selectedRow.DEPT_ID_REAL			//부서코드
				,	NM_DEPT			: selectedRow.DEPT_NM				//부서명
				,	DUTY_CD			: selectedRow.DUTY_CD			//직책코드
				,	DUTY_NM			: selectedRow.DUTY_NM			//직책명
				,	ID_EMP			: selectedRow.USER_ID				//아이디
				,	NM_EMP			: selectedRow.USER_NM				//이름
			};
	var ids = $("#list2").getGridParam("records");
	$("#list2").jqGrid('addRowData',ids+1, userData);
}

function fnSave(){
	var rowids = $('#list2').jqGrid('getRowData');
	var tpApprLine = new Array(rowids.length);
	var tpApprLine_nm = new Array(rowids.length);
	var idDept = new Array(rowids.length);
	var cdDuty = new Array(rowids.length);
	var idEmp = new Array(rowids.length); 
	var seqAppr = new Array(rowids.length);
	  
	for ( var i = 0; i < rowids.length; i++) {
		if(rowids[i].TP_APPR_LINE == null || rowids[i].TP_APPR_LINE == ''){
			alert('결재형태를 지정해주세요.');
			return;
		}
		tpApprLine[i] = rowids[i].TP_APPR_LINE;
		tpApprLine_nm[i] = rowids[i].TP_APPR_LINE_NM;
		idDept[i] = rowids[i].ID_DEPT;
		cdDuty[i] = rowids[i].DUTY_CD;
		idEmp[i] = rowids[i].ID_EMP;
		seqAppr[i] = i+1;
	}
	
	var url = uxl.getFunctionUrl(_SCREEN_ID,'REGIST');
	var option = {
			  data:{SEQ_APPR2:seqAppr,TP_APPR_LINE2:tpApprLine,ID_DEPT2:idDept,CD_DUTY:cdDuty,ID_EMP2:idEmp}
			, validator:function(data,targetForm){
					var returnVal = false;
					//필수항목체크
					if(uxl.checkRequiredFields(targetForm)){
						returnVal = true;
					}
					
					return returnVal;
			}
			, success:function(result){
				uxl.pushToParent();
				self.close();
			}
			, async:true
			, message : {
				 confirm : uxl.getMessage('@message.common.confirm','등록'),
				 success : uxl.getMessage('@message.common.success','등록'),
				 fail : uxl.getMessage('@message.common.fail','등록')
			  }
	};
	uxl.callSubmitFunction('registForm' , url , option );
}

/*
 * 직원찾기 검색버튼
 */
function fnSearch(node){
	//필수정보 체크
	var url = uxl.getFunctionUrl(_SCREEN_ID,'USERDEFINED1');
	var option = {
			  data:uxl.grid.getParam('list')
			/*
			 * 조회한 데이터를 그리드에 추가함.
			 * @param {String} 그리드로 변환할 테이블ID
			 * @param {Result} 조회된 데이터 객체 result
			 * @param {boolean} 데이터 추가시 기존데이터의 clear 여부
			 */
			, success:function(result){
				uxl.grid.appendData('list' ,result , true );
			}
			, async:true
	};
	uxl.callSubmitFunction('searchForm' , url , option );	
}

/*
 * 부서찾기 검색버튼
 */
function fnSearch_dept(){
	//필수정보 체크
	var url = uxl.getFunctionUrl(_SCREEN_ID,'USERDEFINED2');
	var option = {
		  data:uxl.grid.getParam('list_dept')
		, validator:function(data,targetForm){
				var returnVal = false;
				//필수항목체크
				if(uxl.checkRequiredFields(targetForm)){
					returnVal = true;
				}
				
				return returnVal;
		}
		/*
		 * 조회한 데이터를 그리드에 추가함.
		 * @param {String} 그리드로 변환할 테이블ID
		 * @param {Result} 조회된 데이터 객체 result
		 * @param {boolean} 데이터 추가시 기존데이터의 clear 여부
		 */
		, success:function(result){
			$('#treeList').hide();		//조직트리는 숨긴다.
			$('#deptList').show();	//부서리스트  Grid를 보여준다.
			uxl.grid.appendData('list_dept' ,result , true );
		}
		, async:true
	};
	
uxl.callSubmitFunction('treeForm' , url , option );	
}
</script>
		 