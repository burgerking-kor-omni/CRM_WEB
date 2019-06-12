<%--
#*
 *  파 일 명 :  APP0010.jsp
 *  설    명 :  결재선 선택 팝업
 *  작 성 자 :  김희연
 *  작 성 일 :  2014-04-01
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
 
   - PAGE ID : APP0010R00
   - PAGE TYPE : JSP
 
  Copyright ⓒ UBONE Co., Ltd. All rights reserved.
 ========================================================================
--> 


<!-- layout-1 Start -->
<h1 class="ub-control title">결재선 조회</h1>
<div class="ub-layout button top"></div>
<div class="ub-layout details"><div class="ub-layout search">
    <span class="search-ltbg"></span>
    <span class="search-rtbg"></span>
    <span class="search-lbbg"></span>
    <span class="search-rbbg"></span>
<span class="ub-control button search" id="search">
<a href="#none" title="Search">검색</a>
</span>
<form id="searchForm" name="searchForm"><table class="ub-control table normal ">
<colgroup>
<col width="16%"/>
<col width="80%"/>
</colgroup>
<tbody>
<tr id="layout-1_1">
<th id="layout-1_1_1"><label class="ub-control label">결재선명</label></th>
<td id="layout-1_1_2"><input type=text  class="ub-control input-text " id="NM_APPR_LINE" name="NM_APPR_LINE"                       style="text-align:left;width:180px;"></td>
</tr>
</tbody>
</table>
 
</form>

</div>
<div class="ub-layout floatBox"><div class="ub-layout leftBox"   style="width:49%;"><div class="ub-layout list"><div class="ub-control temp" style="border:2px solid gray;width:100%;height:300px;text-align:center;"><h3 style="padding-top:120px;">Grid Control</h3></div>
<table class="ub-control grid" id="list" name="list"></table> 
	
</div>
</div>
<div class="ub-layout rightBox"   style="width:49%;"><div class="ub-layout list"><div class="ub-control temp" style="border:2px solid gray;width:100%;height:300px;text-align:center;"><h3 style="padding-top:120px;">Grid Control</h3></div>
<table class="ub-control grid" id="list2" name="list2"></table> 
	
</div>
</div>
</div>
</div>
<div class="ub-layout button bottom"><span class="ub-control button bottom icon" id="select">
    <a href="#none" title="확인"><span></span>확인</a>
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
			colNames:['결재선ID','결재선명']
	
			//mapping column
			,colModel:[
					  {name:'ID_APPR_LINE' ,width:0, hidden:true}
					 ,{name:'NM_APPR_LINE',width:40}
			]
		    , multiselect:true
			, autowidth:true
			, height:219
			, ondblClickRow: function(rowid){
				var selectedRow = $(this).getRowData(rowid);
				idApprLine=selectedRow.ID_APPR_LINE;
				fnDetail();
			}
		    ,onSelectRow:function(rowid, status, e){
			    if($('#jqg_list_'+rowid).is(":checked")){
	    			$(this).resetSelection();
			    	$(this).setSelection(rowid, false);
				}
		    	idApprLine=$(this).getRowData(rowid).ID_APPR_LINE;
		    	fnSelect(idApprLine);
			}
		};
		uxl.grid('list', options);
		
		//결재자 목록
		var options = {
			//header name
			colNames:['결재형태코드','부서코드','부서','직책코드','직책','성명코드','성명'] 
			
			//mapping column
			,colModel:[
					  {name:'TP_APPR_LINE',width:0,hidden:true,sortable: false}
					  /* ,{name:'TP_APPR_LINE_NM',width:20,sortable: false,align:'center'} */ 
			          ,{name:'ID_DEPT',width:0,hidden:true,sortable: false}
			          ,{name:'NM_DEPT',width:40,align:'center',sortable: false}
			          ,{name:'DUTY_CD',width:0,hidden:true,sortable: false}
			          ,{name:'DUTY_NM',width:25,align:'center',sortable: false}
			          ,{name:'ID_EMP',width:0,hidden:true,sortable: false}
			          ,{name:'NM_EMP',width:20,align:'center',sortable: false}
			         ]
			, autowidth:true
			, height:219
		};
		uxl.grid('list2', options);
		
		//조회 이벤트
		fnSearch();
		
		$('#search').click(function(event){
			fnSearch();
		}); 
		
		$('#select').click(function(){
			fnConfirm();
		});
		
	});
	
 //조회
	function fnSearch(){
		
		//필수정보 체크
		var url = uxl.getFunctionUrl(_SCREEN_ID,'INQUIRY');
		var option = {
				  data:{}		
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
		
					var data = result.getDataList("ApprovalInquiry.getApprovalLineDetail");
					var data_cnt = data.rowCount;
					if(data.rows[0].ID_EMP != null && data.rows[0].ID_EMP != ""){
						for(var i=0; i<data_cnt;i++){
							var userData = {
										TP_APPR_LINE	: data.rows[i].TP_APPR_LINE
								    ,   TP_APPR_LINE_NM : data.rows[i].TP_APPR_LINE_NM
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
	
	function reload(){
		fnSearch();
		idApprLine="";
		$('#list2').jqGrid('clearGridData');
	} 
	
	function fnSelect(id_appr_line){
		fnDetail();
	}
	
	function fnConfirm(){
		//부모창의 jqgrid 정보를담는다.
		var listcount = $("#list2",opener.document).getGridParam("reccount");
		var parentIdEmp = new Array(listcount);
		//부모창의 jqgrid의 결재자를 받아온다
		var parentRowids = $('#list2',opener.document).jqGrid('getRowData');
		for (var i = 0; i < listcount; i++) {
			parentIdEmp[i] = parentRowids[i].ID_EMP;
		}
		
		//현재창의 jqgrid의 정보를 담는다.
		var rowids = $('#list2').jqGrid('getRowData');
		var tpApprLine = new Array(rowids.length);
		var idDept = new Array(rowids.length);
		var cdDuty = new Array(rowids.length);
		var idEmp = new Array(rowids.length);   
		var seqAppr = new Array(rowids.length);
		
		var nmDept = new Array(rowids.length);
		var nmDuty = new Array(rowids.length);
		var nmEmp = new Array(rowids.length);   
		 
		for ( var i = 0; i < rowids.length; i++) {
			tpApprLine[i] = rowids[i].TP_APPR_LINE;
			idDept[i] = rowids[i].ID_DEPT;
			cdDuty[i] = rowids[i].DUTY_CD;
			idEmp[i] = rowids[i].ID_EMP;
			nmDept[i] = rowids[i].NM_DEPT;
			nmDuty[i] = rowids[i].DUTY_NM;
			nmEmp[i] = rowids[i].NM_EMP;
			seqAppr[i] = i+1;
		}
		
		var apprList = {
						TP_APPR_LINE			: tpApprLine
					,	ID_EMP					: idEmp
					,	DUTY_CD					: cdDuty		
					,	ID_DEPT					: idDept
					,	NM_EMP					: nmEmp
					,	DUTY_NM					: nmDuty		
					,	NM_DEPT					: nmDept		
					,	SEQ_APPR				: seqAppr
				};
				
		uxl.pushToParent(apprList);
		self.close();
	}
</script>