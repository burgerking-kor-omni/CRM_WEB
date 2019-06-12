<%--
#*
 *  파 일 명 :  APP0003.jsp
 *  설    명 :  
 *  작 성 자 :  
 *  작 성 일 :  
 *  버    전 :  1.0
 *  기타사항 :
 *  Copyrights 2011 by ㈜ 유비원. All right reserved.
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
%>


<!--  ========================================================================
  This page is generated with the UB-META™ ver4.0 
 
   - PAGE ID : APP0008R00
   - PAGE TYPE : JSP
 
  Copyright ⓒ UBONE Co., Ltd. All rights reserved.
 ========================================================================
--> 


<!-- layout-1 Start -->
<h1 class="ub-control title">결재선관리</h1>
<div class="ub-layout button top"><span class="ub-control button top icon" id="resist">
    <a href="#none" title="Register"><span class="ico-register"></span>신규등록</a>
</span>
</div>
<div class="ub-layout details"><div class="ub-layout floatBox"><div class="ub-layout leftBox"   style="width:45%;"><form id="searchForm" name="searchForm"><div class="ub-layout search">
    <span class="search-ltbg"></span>
    <span class="search-rtbg"></span>
    <span class="search-lbbg"></span>
    <span class="search-rbbg"></span>
<table class="ub-control table normal ">
<colgroup>
<col />
<col />
</colgroup>
<tbody>
<tr id="layout-1_1">
<th id="layout-1_1_1"><label class="ub-control label">결재선명</label></th>
<td id="layout-1_1_2"><input type=text  class="ub-control input-text " id="NM_APPR_LINE" name="NM_APPR_LINE"                       style="text-align:left;width:194px;"></td>
<!-- <td id="layout-1_1_3"><span class="ub-control button search" id="search"><a href="#none" title="Search">검색</a></span></td> -->
</tr>
</tbody>
</table>
 <span class="ub-control button search" id="search"><a href="#none" title="Search">검색</a></span>

</div>
</form>
<div class="ub-layout list"><div class="ub-control temp" style="border:2px solid gray;width:100%;height:300px;text-align:center;"><h3 style="padding-top:120px;">Grid Control</h3></div>
<table class="ub-control grid" id="list" name="list"></table> 
	
</div>
</div>
<div class="ub-layout rightBox"   style="width:50%;"><form id="detailForm" name="detailForm"><table class="ub-control table normal ">
<colgroup>
<col width="25%"/>
<col />
</colgroup>
<tbody>
<tr id="layout-1_1">
<th id="layout-1_1_1"><label class="ub-control label"             for="NM_APPR_LINE2">결재라인 제목</label></th>
<td id="layout-1_1_2"><input type=text  class="ub-control input-text " id="NM_APPR_LINE2" name="NM_APPR_LINE2"            metaessential="1"           style="text-align:left;width:258px;"></td>
</tr>
<tr id="layout-1_2">
<th id="layout-1_2_3"><label class="ub-control label"             for="DS_REMARK">결재라인 설명</label></th>
<td id="layout-1_2_4"><textarea class="ub-control textarea " id="DS_REMARK" name="DS_REMARK"       style="width:270px;" rows="3"      metaessential="1"            rows="3"></textarea></td>
</tr>
</tbody>
</table>
 
</form>
<div class="ub-layout button inner"><div class="ub-layout floatBox"><div class="ub-layout rightBox"><span class="ub-control button inner icon" id="addAppval">
    <a href="#none" title="결재자추가"><span></span>결재자추가</a>
</span>
</div>
</div>
</div>
<div class="ub-layout list"><div class="ub-control temp" style="border:2px solid gray;width:100%;height:300px;text-align:center;"><h3 style="padding-top:120px;">Grid Control</h3></div>
<table class="ub-control grid" id="list2" name="list2"></table> 
	
</div>
</div>
</div>
</div>
<div class="ub-layout button bottom"><span class="ub-control button bottom icon" id="save">
    <a href="#none" title="수정"><span></span>수정</a>
</span>
<span class="ub-control button bottom icon" id="delete">
    <a href="#none" title="삭제"><span></span>삭제</a>
</span>
</div>

<!-- layout-1 End -->

<script type="text/javascript">
//결재선 ID
var idApprLine;
uxl.onLoad(function(){
	/*
	그리드 옵션
	colNames : 그리드 Header 정보,
	colModel : 그리드 Contents 의 바인딩 정보
	*/
	var options = {
		//header name
		colNames:['결재선ID','결재선명','작성일']

		//mapping column
		,colModel:[
				  {name:'ID_APPR_LINE' ,width:0, hidden:true}
				 ,{name:'NM_APPR_LINE',width:40}
				 ,{name:'DT_REG' ,width:10,align:'center'}
		]
		, autowidth:true
		, height:303
		, onSelectRow: function(rowid){
			var selectedRow = $(this).getRowData(rowid);
			idApprLine=selectedRow.ID_APPR_LINE;
			fnDetail();
		}
	};
	uxl.grid('list', options);
	
	
	//결재자 목록
	var options = {
		//header name
		colNames:['결재형태코드', '결재형태', '부서코드','순서','부서','직책코드','직책','성명코드','성명','기능'] 
		
		//mapping column
		,colModel:[
		           /* {name:'TP_APPR_LINE' ,sortable: false,align:'center',width:20,editable: true
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
				  ,{name:'TP_APPR_LINE_NM',align:'center',hidden:true,width:20,sortable: false}
		          ,{name:'ID_DEPT',width:0,hidden:true,sortable: false}
		          ,{name:'ID_ORDER',width:29,align:'center',sortable: false}
		          ,{name:'NM_DEPT',width:40,align:'center',sortable: false}
		          ,{name:'DUTY_CD',width:0,hidden:true,sortable: false}
		          ,{name:'DUTY_NM',width:25,align:'center',sortable: false}
		          ,{name:'ID_EMP',width:0,hidden:true,sortable: false}
		          ,{name:'NM_EMP',width:20,align:'center',sortable: false}
		          ,{name:'EDIT_ROW',width:70, fixed:true,align:'center',formatter:formatOpt1,sortable: false}
		         ]
		, autowidth:true
		, height:229
		, editurl: 'clientArray'		
		, onSelectRow: function (id) {
            $('#list2').editRow(id, true);
        }
	};
	uxl.grid('list2', options);
	
	//조회 이벤트
	$('#search').css("z-index",200);
	fnSearch();
	$('#search').click(function(event){
		fnSearch();
	});
	
	//결재선 신규등록
	$('#resist').click(function(event){
		uxl.openWindow('PopupApp', uxl.getScreenURL('APP0009'),{ width:'980px' ,height:'630px' },reload);
	});
	
	//결재선 수정
	$('#save').click(function(event){
		fnUpdate();
	});
	
	//결재선 삭제
	$('#delete').click(function(event){
		fnDelete();
	});
	
	//결재자 추가
	$('#addAppval').click(function(event){
		if(idApprLine == null || idApprLine == ''){
			uxl.showMessage(uxl.getMessage('@message.voc.apprAdd.fail'));
			return;
		}
		uxl.openWindow('PopupApp', uxl.getScreenURL('APP0004'),{ width:'980px' ,height:'630px' },callBackApp);
	});
	
	$('#DT_REG_START').dblclick(function(){
		$('#DT_REG_START').val('');
	});
	
	$('#DT_REG_END').dblclick(function(){
		$('#DT_REG_END').val('');
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
					,   TP_APPR_LINE_NM	: rowids[index-1].TP_APPR_LINE_NM
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
					,	DUTY_CD			: rowids[index-2].DUTY_CD			//직책코드
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
				    ,   TP_APPR_LINE_NM : rowids[index-1].TP_APPR_LINE_NM
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
					,   TP_APPR_LINE_NM	: rowids[index].TP_APPR_LINE_NM
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

//jqgrid삭제버튼
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
				,	DUTY_CD			: rowids[i+1].DUTY_CD			//직책코드
				,	DUTY_NM			: rowids[i+1].DUTY_NM			//직책명
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


//조회
function fnSearch(){
	
	//필수정보 체크
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

function fnDetail(){
	//필수정보 체크
	var url = uxl.getFunctionUrl(_SCREEN_ID,'USERDEFINED1');
	var option = {
			  data:{ID_APPR_LINE:idApprLine}
			, success:function(result){
				$('#list2').jqGrid('clearGridData');
				$('#NM_APPR_LINE2').val('');
				$('#DS_REMARK').val('');
	
				var data = result.getDataList("ApprovalInquiry.getApprovalLineDetail");
				var data_cnt = data.rowCount;
				if(data.rows[0].ID_EMP != null && data.rows[0].ID_EMP != ""){
					$('#NM_APPR_LINE2').val(data.rows[0].NM_APPR_LINE);
					$('#DS_REMARK').val(data.rows[0].DS_REMARK);
					for(var i=0; i<data_cnt;i++){
						var userData = {
									TP_APPR_LINE	: data.rows[i].TP_APPR_LINE
							    ,   TP_APPR_LINE_NM : data.rows[i].TP_APPR_LINE_NM
							    ,	ID_ORDER		: i+1
								,	ID_DEPT			: data.rows[i].ID_DEPT
								,	NM_DEPT			: data.rows[i].NM_DEPT		
								,	DUTY_CD			: data.rows[i].DUTY_CD
								,	DUTY_NM			: data.rows[i].DUTY_NM
								,	ID_EMP			: data.rows[i].ID_EMP	
								,	NM_EMP			: data.rows[i].NM_EMP	
							};
						var ids = $("#list2").getGridParam("records");
						$("#list2").jqGrid('addRowData',ids+1, userData);
					}
				}
			}
			, async:true
	};
	uxl.callSubmitFunction('searchForm' , url , option );
}

function callBackApp(apprList){
	var listcount = $("#list2").getGridParam("reccount");
	for(var i=0; i<apprList.SEQ_APPR.length;i++){
		var userData = {
					TP_APPR_LINE	: apprList.TP_APPR_LINE[i]
				,	TP_APPR_LINE_NM	: apprList.TP_APPR_LINE_NM[i]
				, 	ID_ORDER		: listcount+(i+1)
				,	ID_DEPT			: apprList.ID_DEPT[i]
				,	NM_DEPT			: apprList.NM_DEPT[i]		
				,	DUTY_CD			: apprList.DUTY_CD[i]
				,	DUTY_NM			: apprList.DUTY_NM[i]
				,	ID_EMP			: apprList.ID_EMP[i]	
				,	NM_EMP			: apprList.NM_EMP[i]	
			};
		var ids = $("#list2").getGridParam("records");
		$("#list2").jqGrid('addRowData',ids+1, userData);
	}
}

//수정
function fnUpdate(){
	if(idApprLine ==null || idApprLine =='' ){
		uxl.showMessage(uxl.getMessage('@message.voc.apprAdd.fail'));
		return;
	}
	
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
	
	//필수정보 체크
	var url = uxl.getFunctionUrl(_SCREEN_ID,'MODIFY');
	var option = {
			  data:{ID_APPR_LINE:idApprLine,SEQ_APPR2:seqAppr,TP_APPR_LINE2:tpApprLine,ID_DEPT2:idDept,CD_DUTY:cdDuty,ID_EMP2:idEmp}
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
				reload();
			}
			, async:true
			, message : {
				 confirm : uxl.getMessage('@message.common.update.confirm'),
				 success : uxl.getMessage('@message.common.update.success'),
				 fail 	 : uxl.getMessage('@message.common.update.fail')
			  }
			
	};
	uxl.callSubmitFunction('detailForm' , url , option );		
}

//수정
function fnDelete(){
	
	if(idApprLine ==null || idApprLine =='' ){
		uxl.showMessage(uxl.getMessage('@message.voc.apprAdd.fail'));
		return;
	}
	//필수정보 체크
	var url = uxl.getFunctionUrl(_SCREEN_ID,'REMOVE');
	var option = {
			  data:{ID_APPR_LINE:idApprLine}
			, validator:function(data,targetForm){
					var returnVal = true;
					//필수항목체크
					
					return returnVal;
				}
			/*
			 * 조회한 데이터를 그리드에 추가함.
			 * @param {String} 그리드로 변환할 테이블ID
			 * @param {Result} 조회된 데이터 객체 result
			 * @param {boolean} 데이터 추가시 기존데이터의 clear 여부
			 */
			, success:function(result){
				reload();
			}
			, async:true
			, message : {
				 confirm : uxl.getMessage('@message.common.delete.confirm'),
				 success : uxl.getMessage('@message.common.delete.success'),
				 fail 	 : uxl.getMessage('@message.common.delete.fail')
			  }
			
	};
	uxl.callSubmitFunction('detailForm' , url , option );		
}

function reload(){
	fnSearch();
	idApprLine="";
	$('#list2').jqGrid('clearGridData');
	$('#NM_APPR_LINE2').val('');
	$('#DS_REMARK').val('');
}
</script>