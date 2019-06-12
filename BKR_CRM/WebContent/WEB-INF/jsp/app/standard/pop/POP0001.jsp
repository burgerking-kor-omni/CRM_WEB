<%--
#*
 *  파 일 명 :  POP0001.jsp
 *  설    명 :  직원목록(공통) 검색
 *  작 성 자 :  이준철
 *  작 성 일 :  2013-05-27
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
<%@ page import="org.apache.commons.lang.StringUtils"%>
<%@ page import="com.ubone.ubmeta.page.util.JspUtils"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core"   prefix="c" %>
<%
	DataList _dataList = null;		/* List Table default dataTable */ 
%>


<!--  ========================================================================
  This page is generated with the UB-META™ ver4.0 
 
   - PAGE ID : POP0001R00
   - PAGE TYPE : JSP
 
  Copyright ⓒ UBONE Co., Ltd. All rights reserved.
 ========================================================================
--> 


<!-- layout-1 Start -->
<h1 class="ub-control title">직원검색</h1>
<div class="ub-layout details"><div class="ub-layout floatBox"><div class="ub-layout leftBox"   style="width:41%;"><form id="treeForm" name="treeForm"><input type=hidden id="LAZY_KEY" name="LAZY_KEY">
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
<div class="ub-layout rightBox"   style="width:55%;"><form id="searchForm" name="searchForm"><table class="ub-control table normal ">
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
<div class="ub-layout pagging"><div class="ub-control temp" style="border:2px solid gray;width:100%;height:30px;text-align:center;"><h3 style="padding-top:3px;">Paging Navigation</h3></div>
<div class="ub-control pagging" for="list" formId="searchForm" function="fnSearch"></div>
</div>
</div>
</div>
</div>
<div class="ub-layout button bottom"><span class="ub-control button bottom icon" id="conFirm">
    <a href="#none" title="Save"><span class="ico-save"></span>확인</a>
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
		colNames:['직책','사번','이름','부서명','부서코드'] 
		
		//mapping column
		,colModel:[
				   {name:'DUTY_NM',width:30,align:'center'}
		          ,{name:'USER_ID',width:120,hidden:true}		          
		          ,{name:'USER_NM',width:30,align:'center'}
		          ,{name:'DEPT_NM',width:30}
		          ,{name:'DEPT_ID_REAL',width:40}
		         ]
		,autowidth:true
		,rowNum:10
		,multiselect:true
		,onSelectRow:function(rowid, status, e){
			    if($('#jqg_list_'+rowid).is(":checked")){
	    			$(this).resetSelection();
			    	$(this).setSelection(rowid, false);
				}
			}
		,onSelectAll: function(aRowids,status) { 
				jQuery("#list").jqGrid('resetSelection');
			}
			, ondblClickRow: function(rowid){
			var selectedRow = $(this).getRowData(rowid);

			fnPushToOpener(selectedRow);
		}	
	};
	uxl.grid('list', options);
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
		,multiselect:true
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
		var a= $('#list',opener.document).jqGrid('getGridParam','data');
	
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
	$('#conFirm').click(function(){
		var rowid = $('#list').jqGrid('getGridParam','selarrrow');
			//이슈리스트 항목에서 아무것도 선택하지 않으면 과제등록을 할 수 없다.
			if(rowid.length==0){
				alert("직원목록에서 선택해 주세요.");
				return;
			}
			selectedRow = $('#list').jqGrid('getRowData',rowid);
			
			fnPushToOpener(selectedRow);
			
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

function fnPushToOpener(selectedRow){
	var userData = {
					idPosition			: selectedRow.POSITION_CD			//직급코드
				,	idUser					: selectedRow.USER_ID					//사용자코드
// 				,	nmUser				: '('+selectedRow.DUTY_NM+')'+selectedRow.USER_NM					//사용자이름
				,	nmUser				: selectedRow.USER_NM					//사용자이름
				,	nmDept				: selectedRow.DEPT_NM					//부서이름
				,	idDept					: selectedRow.DEPT_ID_REAL			//부서번호(현재)
			}
			
			uxl.pushToParent(userData);
			//opener.callBack(UserData);
			self.close();
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
		 