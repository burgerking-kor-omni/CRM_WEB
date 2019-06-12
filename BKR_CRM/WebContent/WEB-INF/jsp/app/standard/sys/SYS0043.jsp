<%--
#*
 *  파 일 명 :  SYS0043.jsp
 *  설    명 :  배치 기록 목록
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

<script type="text/javascript">
uxl.onLoad(function(){
	
	// Dynamic 코드 조회
	var options = {
			//header name
			colNames:['시작시간','종료시간','배치ID','건수','상태','오류내용']
			
			//mapping column
			, colModel:[
			           {name:'START_DATETIME',width:100} 
			          ,{name:'FINISH_DATETIME',width:100}
			          ,{name:'BATCH_ID',width:150}
			          ,{name:'RESULT_COUNT',width:30}
			          ,{name:'STATUS',width:30}
			          ,{name:'ERROR_MESSAGE',hidden:true}
			         ]
			, autowidth:true
			, height:231
			, loadComplete:function(){
				if(records = $(this).jqGrid('getGridParam','records') < 1){
					selectBatchLogList();				
				}
			}
			,onSelectRow:function(rowid){
				$(this).jqGrid('toggleSubGridRow',rowid);
			}
			,subGrid:true
			,subGridRowExpanded: function(subgrid_id, row_id) {
				var selectRow = $(this).jqGrid('getRowData',row_id);
				var msg = selectRow.ERROR_MESSAGE;
				var msgarr = msg.split(/[\n\r]+/g);
				var rows = msgarr.length,cols = 0;
				for(var i=0; i<rows; i++)
					if(cols<msgarr[i].length)
						cols=msgarr[i].length;
				$('#'+subgrid_id).append('<textarea>​​</textarea>')
				.find('textarea')
				.text(msg)
				.addClass('ub-control textarea')
     			.attr({
					 rows:rows
					,cols:cols+20
					,style:'overflow-y:hidden'
				});
			}
		};
	uxl.grid('list', options);
	
	//조회
	$('#searchBtn').click(function(){
		selectBatchLogList();
	});
	
	$('#BATCH_JOB').change(function(){
		selectBatchLogList();
	});
	
	$('#BATCH_LOG_STATUS').change(function(){
		selectBatchLogList();
	});
});	

//배치 기록 목록 조회
function selectBatchLogList(){
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
				, success:function(result){
					uxl.grid.appendData('list' ,result , true );
				}
				, async:true
		};
		uxl.callSubmitFunction('searchForm' , url , option );
}

</script>