<%--
#*
 *  파 일 명 :  POP0002.jsp
 *  설    명 :  부서목록(공통) 검색
 *  작 성 자 :  이준철
 *  작 성 일 :  2013-05-28
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
 
   - PAGE ID : POP0002R00
   - PAGE TYPE : JSP
 
  Copyright ⓒ UBONE Co., Ltd. All rights reserved.
 ========================================================================
--> 


<!-- layout-1 Start -->
<h1 class="ub-control title">부서검색</h1>
<div class="ub-layout details"><form id="treeForm" name="treeForm"><input type=hidden id="LAZY_KEY" name="LAZY_KEY">
<table class="ub-control table normal ">
<colgroup>
<col width="20%"/>
<col />
</colgroup>
<tbody>
<tr id="layout-1_1">
<th id="layout-1_1_1"><label class="ub-control label"             for="DEPT_NM">부서</label></th>
<td id="layout-1_1_2"><input type=text  class="ub-control input-text " id="DEPT_NM" name="DEPT_NM"       value="${paramMap.DEPT_NM}"     metaessential="1"             style="ime-mode:active;text-align:left;width:100px;"><a href="#none" title="search" class="ub-control button imgBtn img-search" id="fnSearch_dept" name="fnSearch_dept"><span>@@</span></a><span class="ub-control button inner icon" id="showTree">    <a href="#none" title="조직도"><span></span>조직도</a></span></td>
</tr>
</tbody>
</table>
 
<input type=hidden id="ID_DEPT_TREE" name="ID_DEPT_TREE">
<input type=hidden id="NM_DEPT_TREE" name="NM_DEPT_TREE">
</form>
<div class="ub-layout treeBox" id="treeList" name="treeList"   style="height:400px;"><div class="ub-control temp" style="border:2px solid gray;width:100px;height:100px;text-align:center;"><h3 style="padding-top:20px;">Tree Control</h3></div>
<div id="deptTree" name="deptTree" class="ub-control tree"></div>
</div>
<div class="ub-layout list" id="deptList" name="deptList"    style="height:400px;" IsContainer="truewidth:380px;"><div class="ub-control temp" style="border:2px solid gray;width:100%;height:300px;text-align:center;"><h3 style="padding-top:120px;">Grid Control</h3></div>
<table class="ub-control grid" id="list_dept" name="list_dept"></table> 
	
</div>
</div>
<div class="ub-layout button bottom">
	<span class="ub-control button bottom icon" id="conFirm">
    	<a href="#none" title="Save"><span class="ico-save"></span>확인</a>
	</span>
</div>

<!-- layout-1 End -->


<script type="text/javascript">
uxl.onLoad(function(){
	
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
			,lazyFunctionAlias : 'USERDEFINED2'		//lazy 전송시 [lazy모드시 필수]
			//lazy 모드 -------------------------------------------------------------------------------
			,onActivate : function(node){ //node 선택시 이벤트
			    $('#LAZY_KEY').val(node.data.key);		//메뉴ID
			    $('#ID_DEPT_TREE').val(node.data.key);		//메뉴ID
			    $('#NM_DEPT_TREE').val(node.data.title);		//메뉴ID
			}
		};
 	uxl.treeDraw(treeOption , '');
	
	/*FNCPOP0008
		그리드 옵션
		colNames : 그리드 Header 정보,
		colModel : 그리드 Contents 의 바인딩 정보
	*/
	
	//부서목록 JqGrid (LeftBox)
	var options_dept = {
		//header name
		colNames:['부서코드','부서명','부서명'] 
		
		//mapping column
		,colModel:[
		           {name:'DEPT_ID' ,width:60,hidden:true}
		          ,{name:'DEPT_NM',width:348}
		          ,{name:'DEPT_NM_FULL' ,width:348,hidden:true}
		         ]
		,autowidth:true
		,multiselect:true
		,onSelectRow:function(rowid, status, e){
			    if($('#jqg_list_dept_'+rowid).is(":checked")){
	    			$(this).resetSelection();
			    	$(this).setSelection(rowid, false);
				}
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

		var url = uxl.getFunctionUrl(_SCREEN_ID,'USERDEFINED1');
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
	
		if (!$('#treeList').is(':hidden')) {
				var deptData = {
						nmDept				: 	$('#NM_DEPT_TREE').val()				//부서이름
					,	idDept					: 	$('#ID_DEPT_TREE').val()				//부서번호(현재)
				};
			
				uxl.pushToParent(deptData);
				//opener.callBack(UserData);
				self.close();
			}else{
				var rowid = $('#list_dept').jqGrid('getGridParam','selarrrow');
				//이슈리스트 항목에서 아무것도 선택하지 않으면 과제등록을 할 수 없다.
				if(rowid.length==0){
					alert("직원목록에서 선택해 주세요.");
					return;
				}
				selectedRow = $('#list_dept').jqGrid('getRowData',rowid);
				fnPushToOpener(selectedRow);
			}
		});
		
	//Enter Key 이벤트
	$('#DEPT_NM').keydown(function(event) {
		if(event.keyCode == '13') {
			fnSearch();
			return false;
		}
	});

		
});

//부모창으로 부서ID, 이름을 넘겨준다.
function fnPushToOpener(selectedRow){
	var deptData = {
					nmDept				: selectedRow.DEPT_NM					//부서이름
				,	idDept					: selectedRow.DEPT_ID					//부서번호(현재)
			};
			
			uxl.pushToParent(deptData);
			//opener.callBack(UserData);
			self.close();
}

	
	
//조회
function fnSearch(){
	//필수정보 체크
	var url = uxl.getFunctionUrl(_SCREEN_ID,'USERDEFINED1');
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
		 