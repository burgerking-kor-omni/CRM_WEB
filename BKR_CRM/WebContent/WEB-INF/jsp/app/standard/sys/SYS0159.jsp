<%--
 *
 *  설    명 :  시스템관리 / 부서 관리
 *  작 성 자 :  관리자
 *  작 성 일 :  2013-05-15
 *  버    전 :  1.0
 *  기타사항 :
 *  Copyrights 2011 by ㈜ 유비원. All right reserved.
 * 
--%>
<%@page import="com.ubone.framework.util.UserUtil"%>
<%@page import="com.ubone.framework.engine.domain.User"%>
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
	DataList _dl_MENU_TYPE = ViewUtil.getResult().getDataList("Code.MENU_TYPE");
	DataList _dl_STATUS = ViewUtil.getResult().getDataList("Code.STATUS");
%>


<!--  ========================================================================
  This page is generated with the UB-META™ ver4.0 
 
   - PAGE ID : SYS0159R00
   - PAGE TYPE : JSP
 
  Copyright ⓒ UBONE Co., Ltd. All rights reserved.
 ========================================================================
--> 


<!-- layout-1 Start -->
<h1 class="ub-control title">부서관리</h1>
<div class="ub-layout details"><div class="ub-layout floatBox"><div class="ub-layout leftBox"   style="width:30%;"><h2 class="ub-control title">부서트리</h2>
<form id="treeForm" name="treeForm"><input type=hidden id="LAZY_KEY" name="LAZY_KEY">
</form>
<div class="ub-layout treeBox"   style="height:370px;"><div class="ub-control temp" style="border:2px solid gray;width:100px;height:100px;text-align:center;"><h3 style="padding-top:20px;">Tree Control</h3></div>
<div id="deptTree" name="deptTree" class="ub-control tree"></div>
</div>
<div class="ub-layout button bottom"><span class="ub-control button bottom icon" id="addNewNode">
    <a href="#none" title="Add"><span class="ico-add"></span>신규등록</a>
</span>
</div>
</div>
<div class="ub-layout rightBox"   style="width:69%;"><h2 class="ub-control title">기본정보</h2>
<form id="detailForm" name="detailForm"><table class="ub-control table normal ">
<colgroup>
<col width="150px"/>
<col />
<col width="150px"/>
<col />
</colgroup>
<tbody>
<tr id="layout-1_1">
<th id="layout-1_1_1"><label class="ub-control label"             for="DEPT_ID">부서 ID</label></th>
<td id="layout-1_1_2"><input type=text  class="ub-control input-text " id="DEPT_ID" name="DEPT_ID"            metaessential="1"           style="text-align:left;width:150px;"></td>
<th id="layout-1_1_3"><label class="ub-control label"             for="DEPT_NM">부서명</label></th>
<td id="layout-1_1_4"><input type=text  class="ub-control input-text " id="DEPT_NM" name="DEPT_NM"            metaessential="1"           style="text-align:left;width:150px;"></td>
</tr>
<tr id="layout-1_2">
<th id="layout-1_2_5"><label class="ub-control label"             for="DEPT_ID_UP">상위부서</label></th>
<td id="layout-1_2_6"><input type=text  class="ub-control input-text " id="DEPT_ID_UP" name="DEPT_ID_UP"                       style="text-align:left;width:150px;"></td>
<th id="layout-1_2_7"><label class="ub-control label"             for="LEVEL_DS">레벨(DEPTH)</label></th>
<td id="layout-1_2_8"><input type=text  class="ub-control input-text " id="LEVEL_DS" name="LEVEL_DS"                       style="text-align:left;width:150px;"></td>
</tr>
<tr id="layout-1_3">
<th id="layout-1_3_9"><label class="ub-control label"             for="ORDER_DS">순서</label></th>
<td id="layout-1_3_10"><input type=text  class="ub-control input-text " id="ORDER_DS" name="ORDER_DS"            metaessential="1"           style="text-align:left;width:150px;"></td>
<th id="layout-1_3_11"><label class="ub-control label"             for="STATUS">상태</label></th>
<td id="layout-1_3_12"><select id="STATUS" name="STATUS" class="ub-control select "     style="width:150px;" size="1" datacid="STATUS"N'"     metaessential="1"><%    if(!"".equals("")){        out.println("<OPTION VALUE=\"\"></OPTION>\r\n");    }    if(_dl_STATUS != null){        for(int codeIdx=0; codeIdx < _dl_STATUS.getRowCount(); codeIdx++){            String code = _dl_STATUS.getString(codeIdx, ConstantHolder.CODE_COLUMN_CODE);            String name = _dl_STATUS.getString(codeIdx, ConstantHolder.CODE_COLUMN_NAME);            String selected = code.equals('N')?"selected":"";            out.println("<option VALUE=\""+code+"\" "+selected+">"+name+"</option>\r\n");        }    }%></select></td>
</tr>
<tr id="layout-1_4">
<th id="layout-1_4_13"><label class="ub-control label"             for="FAX_NO">FAX</label></th>
<td id="layout-1_4_14"><input type=text  class="ub-control input-text " id="FAX_NO" name="FAX_NO"                       style="text-align:left;width:150px;"></td>
<th id="layout-1_4_15"></th>
<td id="layout-1_4_16"></td>
</tr>
<tr id="layout-1_5">
<th id="layout-1_5_17"><label class="ub-control label">전화번호</label></th>
<td id="layout-1_5_18"><input type=text  class="ub-control input-text " id="PHONE_NO" name="PHONE_NO"                       style="text-align:left;width:90%;"></td>
<th id="layout-1_5_19"><label class="ub-control label"             for="DEPT_TP">부서유형</label></th>
<td id="layout-1_5_20"><select id="DEPT_TP" name="DEPT_TP" class="ub-control select "     style="width:150px;" size="1" datacid="MENU_TYPE"N'"     metaessential="0"><%    if(!"".equals("")){        out.println("<OPTION VALUE=\"\"></OPTION>\r\n");    }    if(_dl_MENU_TYPE != null){        for(int codeIdx=0; codeIdx < _dl_MENU_TYPE.getRowCount(); codeIdx++){            String code = _dl_MENU_TYPE.getString(codeIdx, ConstantHolder.CODE_COLUMN_CODE);            String name = _dl_MENU_TYPE.getString(codeIdx, ConstantHolder.CODE_COLUMN_NAME);            String selected = code.equals('N')?"selected":"";            out.println("<option VALUE=\""+code+"\" "+selected+">"+name+"</option>\r\n");        }    }%></select></td>
</tr>
</tbody>
</table>
 
</form>
<div class="ub-layout button bottom"><span class="ub-control button bottom icon" id="updateBtn">
    <a href="#none" title="Save"><span class="ico-save"></span>저장</a>
</span>
<span class="ub-control button bottom icon" id="deleteBtn">
    <a href="#none" title="Delete"><span class="ico-delete"></span>삭제</a>
</span>
</div>
<div class="ub-layout button inner"  style="text-align:right;"></div>
<div class="ub-layout list"><div class="ub-control temp" style="border:2px solid gray;width:100%;height:300px;text-align:center;"><h3 style="padding-top:120px;">Grid Control</h3></div>
<table class="ub-control grid" id="list" name="list"></table> 
	
</div>
<!-- 
<div class="ub-layout button bottom"><span class="ub-control button bottom icon" id="regist">
    <a href="#none" title="Register"><span class="ico-register"></span>사용자등록</a>
</span>
</div>
 -->
</div>
</div>
</div>

<!-- layout-1 End -->


<script type="text/javascript">


var _SELECTED_SCREEN_ID = ''; 		// 선택된 SCREEN ID


// 문서 준비 핸들러
uxl.onLoad(function() {

	var treeOption = {
			treeDivId : 'deptTree'				//트리DIV 영역ID [선택 : 기본값 = tree ]
			,screenId : _SCREEN_ID				//화면아이디	 [필수]
			,functionAlias : 'INQUIRY'			//트리리스트 호출 Function Alais [필수]
			,formId:'treeForm'				    //트리리스트 호출시 전송할 FormID [선택]
			,param : {DEPTH:'1'}				//전송할 인자값 [선택]
			,clickFolderMode :  3 				// 1:activate, 2:expand, 3:activate and expand
			,minExpandLevel:2						//기본펼침 [선택 1~3 기본 1]
			,checkbox : false					//체크박스 표시여부 [기본값 : false ]
			,selectMode : 1						//체크박스 선택모드 [기본값 : 1] 1:single, 2:multi, 3:multi-hier
			//lazy 모드 -------------------------------------------------------------------------------
			,lazyFormId : 'treeForm'			//lazy 로딩시 전송할 formID [lazy모드시 선택]
			,lazyParam : {}						//lazy 로딩시 전송할 param	[lazy모드시 선택]
			,lazyKeyInputId : 'LAZY_KEY'		//lazy 로딩시 key값을 설정할 input ID [lazy모드시 선택]
			,lazyFunctionAlias : 'USERDEFINED1'		//lazy 전송시 [lazy모드시 필수]
			//lazy 모드 -------------------------------------------------------------------------------
			,onActivate : function(node){ //node 선택시 이벤트
				
				fnGetDtail( node );
				fnSearch(node);
			}		
		};
 	uxl.treeDraw(treeOption , '');
 	
 	/***************************************
	* Update Menu
	***************************************/
	$('#updateBtn').click(function(){
		var node = uxl.getActivateNode('deptTree');
		
		if("New-Dept" == node.data.id){
			deptIdCheck();	
		}else if("ROOT" == node.data.id){
			alert("해당 ROOT는 변경할 수 없습니다.");
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
	* 사용자등록
	***************************************/
	$('#regist').click(function(){
		var node = uxl.getActivateNode('deptTree');
		if("ROOT" == node.data.id){	
			alert("ROOT	에 사용자를 추가할 수 없습니다.");
			return;
		}
		
		uxl.openWindow('Popup', uxl.getScreenURL('SYS0213'), { width:'950px' ,height:'380px' }, callBackList);	
	});
	
	/***************************************
	* Create New Menu
	***************************************/
	$('#addNewNode').click(function(){
		var node = uxl.getActivateNode('deptTree');
		
		if( !node ) {
			alert("팀을 선택해 주세요.");
			return;	
		}
		
//		if(node.data.depth < 2){
//			alert("부서는 팀단위 이하로 등록할 수 있습니다.");
//			return;	
//		}
		
		var newObj = [{
			"key":"New-Dept"
			,"id":"New-Dept"
			,"children":[]
			,"title":"New Dept"
			,"parentId":node.data.id
			,"toolTip":"New Dept"
			,"sortOrder":node.countChildren()+1
			,"depth":eval(node.data.depth) + 1
			,"extendData1":""
			,"extendData2":""
			,"extendData3":""
			,"extendData4":""
			,"extendData5":""}];
		
		$('#DEPT_ID').attr('readonly',false);
		$('#DEPT_ID').attr('class','ub-control input-text');
		
		node.data.isFolder = true;
		node.data.isLazy = true;
		node.bExpanded = true;
		var newNode = node.addChild(newObj);
		newNode.activate();
	});
	
	/***************************************
	* Change parent Dept
	***************************************/
	$('#PARENT_MENU_ID').change(function(){
		var node = uxl.getActivateNode('deptTree');
		
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
	* Change parent Menu
	***************************************/
//	$('#DEPT_TP').change(function(){
//		if('N' == this.value){
//			$('.ub-control.table tr:last-child').hide();
//			$('.ub-control.table tr:last-child input[type=text]').val('').setRequired(false);
//			
//		}else{
//			$('.ub-control.table tr:last-child').show();
//			$('.ub-control.table tr:last-child input[type=text]').setRequired(true);
//			
//		}
//	}).change();
	$('#layout-1_4').hide();
	$('#layout-1_5').hide();
	
	/***************************************
	* 부서 사용자
	***************************************/
	var options = {
			
		//header name
		colNames:['ID','이름', '부서', '핸드폰 번호', '이메일', '재직여부']

		//mapping column
		,colModel:[
				  {name:'USER_ID',width:50, align:'center'}
				 ,{name:'USER_NM',width:50, align:'center'}
				 /* ,{name:'CD_BRANCH',width:50, align:'center' , codeCategory:'CD_BRANCH' } */
				 ,{name:'DEPT_NM',width:50, align:'center'}
				 ,{name:'MOBILE_NO',width:50, align:'center'}
				 ,{name:'EMAIL_DS',width:50, align:'center'}
				 ,{name:'INCUMBENT_CD',width:50, codeCategory:'INCUMBENT_USER_CD', align:'center'}
			]
		,autowidth:true
		,rowNum: 10
		,height:231
	};
	uxl.grid('list', options);
	
});


function selectNode(result){
	data = result.getDetail();
	
    $('#DEPT_ID').val(data.DEPT_ID);		//부서명
    $('#DEPT_NM').val(data.DEPT_NM);		//부서명
	$('#DEPT_ID_UP').val(data.DEPT_ID_UP);	//상위부서
	$('#DEPT_TP').val(data.DEPT_TP);		//부서유형
	$('#LEVEL_DS').val(data.LEVEL_DS);			//깊이
	$('#PHONE_NO').val(data.PHONE_NO);		//전화번호
	$('#FAX_NO').val(data.FAX_NO);		//FAX
	$('#ORDER_DS').val(data.ORDER_DS);		//순서
	$('#STATUS').val(data.STATUS);			//상태
	
	$('#DEPT_ID').attr('readonly',true);
	$('#DEPT_ID').attr('class','ub-control input-text readonly');
		
	$('#DEPT_TP').change();
}


//상위메뉴ID 콤보박스를 세팅한다.
function setParentComboBox(node){
	var menuId = node.data.key;
    var parentId = node.data.parentId;
	var url = uxl.getFunctionUrl(_SCREEN_ID,'USERDEFINED2');
	var option = {
			  data:{}
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
				
				
				if(node.data.key=="New-Dept"){
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
				var activeNode = uxl.getActivateNode("deptTree");
				activeNode.setTitle($('DEPT_NM').val());
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
 * 메뉴상세를 조회한다.
 */
function fnGetDtail(node){
	
	$('#LAZY_KEY').val(node.data.key);		//메뉴ID
	
	//setParentComboBox(node);
	
	if(node.data.key=="ROOT"){
		$('#DEPT_ID').val("");		//부서명
	    $('#DEPT_NM').val("");		//부서명
		$('#DEPT_ID_UP').val("");	//상위부서
		$('#DEPT_TP').val("");		//부서유형
		$('#LEVEL_DS').val("");			//깊이
		$('#PHONE_NO').val("");		//전화번호
		$('#FAX_NO').val("");		//FAX
		$('#ORDER_DS').val("");		//순서
		$('#STATUS').val("");			//상태	
	}else if(node.data.key=="New-Dept"){
		
		$('#DEPT_ID').val("");		//부서명
	    $('#DEPT_NM').val(node.data.title);		//부서명
		$('#DEPT_ID_UP').val(node.data.parentId);	//상위부서
		$('#DEPT_TP').val("");		//부서유형
		$('#LEVEL_DS').val(node.data.depth);			//깊이
		$('#PHONE_NO').val("");		//전화번호
		$('#FAX_NO').val("");		//FAX
		$('#ORDER_DS').val(node.data.sortOrder);		//순서
		$('#STATUS').val(data.STATUS);			//상태
		
	}else{
		$('#DEPT_ID').val(node.data.key);
		var url = uxl.getFunctionUrl(_SCREEN_ID,'USERDEFINED2');
		var option = {
				success:function(result){
					selectNode(result);
				}
		};
		uxl.callSubmitFunction('detailForm' , url , option );
	}
}

/*
 * 메뉴를 등록한다.
 */
function fnInsert(){
	var url = uxl.getFunctionUrl(_SCREEN_ID,'REGIST');
	var option = {
			validator:function(data,targetForm){
				return uxl.checkRequiredFields(targetForm);
			}
			, success:function(result){
				var activeNode = uxl.getActivateNode("deptTree");
				activeNode.data.id = result.getResultKey();
				activeNode.data.key = result.getResultKey();
				activeNode.setTitle($('#DEPT_NM').val());
				$('#DEPT_ID').val(result.getResultKey());
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
 * 메뉴삭제를 조회한다.
 */
function fnDelete(){
	
	var node = uxl.getActivateNode('deptTree');
	if( !node ) return;
	
	if(node.countChildren() != 0) return;
	
	if(node.data.key=="New-Dept"){
		if(node.getParent().countChildren() == 1){
			node.getParent().data.isFolder = false;
		} 
		node.remove();	
		$('#DEPT_ID').val("");		//부서명
	    $('#DEPT_NM').val("");		//부서명
		$('#DEPT_ID_UP').val("");	//상위부서
		$('#DEPT_TP').val("");		//부서유형
		$('#LEVEL_DS').val("");			//깊이
		$('#PHONE_NO').val("");		//전화번호
		$('#FAX_NO').val("");		//FAX
		$('#ORDER_DS').val("");		//순서
		$('#STATUS').val("A");			//상태
	}else if(node.data.key == "ROOT"){
		alert("ROOT 노드는 삭제할 수 없습니다.");
	}else{
		
		$('#DEPT_ID').val(node.data.key);
		var url = uxl.getFunctionUrl(_SCREEN_ID,'REMOVE');
		var option = {
				success:function(result){
					if(node.getParent().countChildren() == 1) {
						node.getParent().data.isFolder = false;
					} 
					node.remove();
					$('#DEPT_ID').val("");		//부서명
				    $('#DEPT_NM').val("");		//부서명
					$('#DEPT_ID_UP').val("");	//상위부서
					$('#DEPT_TP').val("");		//부서유형
					$('#LEVEL_DS').val("");			//깊이
					$('#PHONE_NO').val("");		//전화번호
					$('#FAX_NO').val("");		//FAX
					$('#ORDER_DS').val("");		//순서
					$('#STATUS').val("A");			//상태
					
				}
		};
		uxl.callSubmitFunction('detailForm' , url , option );
	}
}

//조회
function fnSearch(node){
	//필수정보 체크
	$('#DEPT_ID').val(node.data.key);
	var url = uxl.getFunctionUrl(_SCREEN_ID,'USERDEFINED3');
	var option = {
			  data: uxl.grid.getParam('list')
			/* , validator:function(data,targetForm){
					var returnVal = false;
					//필수항목체크
					if(uxl.checkRequiredFields(targetForm)){
						returnVal = true;
					}
					
					return returnVal;
			} */
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
	uxl.callSubmitFunction('detailForm' , url , option );
}

function callBackList(successFlag){
	if(successFlag == "Y"){
		var node = uxl.getActivateNode('deptTree');
		fnSearch(node);
	}
}

function deptIdCheck(){
	if($('#DEPT_ID').val() == 'New-Dept'){
		alert("부서 ID를 변경해 주세요.");
		$('#DEPT_ID').focus();
		return;
	}
	
	var url = uxl.getFunctionUrl(_SCREEN_ID,'CHECK');
	var option = {
			  data: {}
			, validator:function(data,targetForm){
					var returnVal = false;
					if($('#DEPT_ID').val().length > 0){
						returnVal = true;
					}else{
						$('#DEPT_ID').focus();
					}
					return returnVal;
			}
			, success:function(result){
				var duplicationCnt = result.getDataList(0).rows[0].CHECK_COUNT;
				if( duplicationCnt > 0 ){
					alert("이미 사용중인 부서ID입니다.");
					$('#DEPT_ID').focus();
				}else{
					fnInsert();
				}
			}
			, async:true
	};
	uxl.callSubmitFunction('detailForm' , url , option );		
}

</script>
