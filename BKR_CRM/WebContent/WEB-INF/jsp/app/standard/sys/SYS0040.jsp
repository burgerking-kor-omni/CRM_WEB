<%--
#*
 *  파 일 명 :  SYS0040.jsp
 *  설    명 :  배치 목록
 *  작 성 자 :  안신용
 *  작 성 일 :  2013-05-22
 *  버    전 :  1.0
 *  기타사항 :
 *  Copyrights 2013 by ㈜ 유비원. All right reserved.
*# 
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.ubone.framework.util.ViewUtil"%>
<%@ include file="/WEB-INF/jsp/include/pageCommon.jsp"%>
<style type="text/css" media="screen">
    th.ui-th-column div{
        white-space:normal !important;
        height:auto !important;
        padding:2px;
    }
</style>
<script type="text/javascript">
uxl.onLoad(function(){
	uxl.bindComboCode('STATUS', 'BATCH_STATUS', {emptyOption:'전체'});
	
	// Dynamic 코드 조회
	var options = {
			//header name
			colNames:['배치ID','배치명','배치TYPE','분','시','일','월','주','시작','성공','실패','상태','사용여부','강제실행']
			
			//mapping column
			, colModel:[
			           {name:'BATCH_ID',width:100} 
			          ,{name:'BATCH_NAME',width:200}
			          ,{name:'BATCH_TYPE',width:50, align:'center'}
			          ,{name:'EXEC_COND_MIN',width:30, align:'center'}
			          ,{name:'EXEC_COND_HOUR',width:30, align:'center'}
			          ,{name:'EXEC_COND_DAY',width:30, align:'center'}
			          ,{name:'EXEC_COND_MONTH',width:30, align:'center'}
			          ,{name:'EXEC_COND_WEEK',width:30, align:'center'}
			          ,{name:'LAST_RUN_DATETIME' ,width:60,formatter:lastResult}
			          ,{name:'LAST_SUCC_DATETIME',width:60,formatter:lastResult}
			          ,{name:'LAST_FAIL_DATETIME',width:60,formatter:lastResult}
			          ,{name:'STATUS',width:50, align:'center'}
			          ,{name:'USE_YN',width:40, align:'center'}
			          ,{name:'ENFORCE',width:50, align:'center'}
			         ]
			, autowidth:true
			, height:435
			, gridComplete: function(){
				var ids = jQuery("#list").jqGrid('getDataIDs');
				for(var i=0;i < ids.length;i++){
					var cl = ids[i];
					var data = $('#list').jqGrid('getRowData',cl);
					button = "<input style='height:20px;width:60px;' type='button' value='강제실행' onclick=\"updateBatchStatus('"+data.BATCH_ID+"');\"  />"; 
					jQuery("#list").jqGrid('setRowData',ids[i],{ENFORCE:button});
				}	
			}
			, ondblClickRow: function(rowid){
				var selectedRow = $(this).getRowData(rowid);
				uxl.moveLocation(uxl.getScreenURL('SYS0042') + '?BATCH_ID='+selectedRow.BATCH_ID);
			}
		};
	uxl.grid('list', options);
	
	$('#list').jqGrid('setGroupHeaders',{
		useColSpanStyle :true,
		groupHeaders:[
		              {startColumnName:'EXEC_COND_MIN',numberOfColumns: 5,titleText: '일정'}
		             ,{startColumnName:'LAST_RUN_DATETIME',numberOfColumns: 3,titleText: '마지막결과'}
		             ]
	});
	
	//조회
	$('#searchBtn').click(function(){
	   	uxl.grid.init('list');
		selectBatchList();
	});
	
	//등록버튼
	$('#insertBatchBtn').click(function(){
		uxl.moveLocation(uxl.getScreenURL('SYS0041'));
	});
	
	
	//자동완성 기능
	uxl.autocomplete('BATCH_NAME', uxl.getFunctionUrl(_SCREEN_ID,'USERDEFINED1') , {
									minLength : 3
									, itemExtractor : function(row) {
										var item = {
											  id : row.BATCH_ID
											, value : row.BATCH_NAME
											, label : row.BATCH_NAME
										};
										return item;
									}
								    , select: function(event, ui) {
								    	selectBatchList();
									}
   });
	
	
	selectBatchList();

});	

//배치 목록 조회
function selectBatchList(){
	var url = uxl.getFunctionUrl(_SCREEN_ID,'INQUIRY');
	var option = {
				  data:uxl.grid.getParam('list')
				, success:function(result){
					uxl.grid.appendData('list' ,result , true );
				}
				, async:true
		};
		uxl.callSubmitFunction('searchForm' , url , option );
}

//배치 상태 수정(강제실행)
function updateBatchStatus(BATCH_ID){
	var url = uxl.getFunctionUrl(_SCREEN_ID,'MODIFY');
	var option = {
				  data:{
					  ID:BATCH_ID
					 ,BATCH_STATUS:'01'
				  }
				, validator:function(data,targetForm){
						var returnVal = false;
						//필수항목체크
						if(uxl.checkRequiredFields(targetForm)){
							returnVal = true;
						}
						return returnVal;
				}
				, success:function(result){
					selectBatchList();
				}
				, async:true
		};
		uxl.callSubmitFunction('searchForm' , url , option );
}

function lastResult(cellvalue, options, rowObject){
	if(cellvalue){
		var cell = cellvalue.split(' ');
		return cell[0]+"\n"+cell[1];
	}else{
		return "";
	}
}
</script>