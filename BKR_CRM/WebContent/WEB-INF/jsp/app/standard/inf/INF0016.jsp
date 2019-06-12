<%--
#*
 *  파 일 명 : INF0016.jsp
 *  설    명 :  
 *  작 성 자 :  
 *  작 성 일 :  2013-05-24
 *  버    전 :  1.0
 *  기타사항 :
 *  Copyrights 2011 by ㈜ 유비원. All right reserved.
*# 
--%>
<%@page import="com.ubone.framework.util.ViewUtil"%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/include/pageCommon.jsp" %>

<script type="text/javascript">
uxl.onLoad(function(){
	
	//접수채널
	uxl.chainCombo($("#TP_CHNN_SYSTEM"), $("#TP_CHNN_PATH") , "TP_CHNN_PATH", {unusedMapping : true});
	
	uxl.bindComboCode('CD_VOC_PATTERN', 'CD_VOC_PATTERN', {parameter : {}, emptyOption:'전체'});
	uxl.bindComboCode('CD_VOC_CAUSE_1', 'CD_VOC_CAUSE_1', {parameter : {}, emptyOption:'전체'});
	uxl.chainCombo($('#CD_VOC_CAUSE_1'), $('#CD_VOC_CAUSE_2') , 'CD_VOC_CAUSE_2', {parameter : {}});
	uxl.chainCombo($('#CD_VOC_CAUSE_2'), $('#CD_VOC_CAUSE_3') , 'CD_VOC_CAUSE_3', {parameter : {}});
	/*
		그리드 옵션
		colNames : 그리드 Header 정보,
		colModel : 그리드 Contents 의 바인딩 정보
	*/
	
	var options = {
		//header name
		colNames:['VOC NO','ID_SUB_VOC','VOC ID','유형','제목','고객유형','등록일시','최종완료일시','담당부서'] 
		
		//mapping column
		,colModel:[
				   {name:'ID_VOC' ,width:100 ,hidden:true}
				  ,{name:'ID_SUB_VOC' ,width:10 ,hidden:true}
				  ,{name:'ID_VOC_ALL' ,width:100 ,align:'center'}
		          ,{name:'CD_VOC_PATTERN' ,width:20,codeCategory:'NM_VOC_PATTERN', align:'center'}
		          ,{name:'DS_TITLE',width:150}
		          ,{name:'TP_CUST',width:50,codeCategory:'TP_CUST'}
		          ,{name:'DT_VOC_REG',width:50}
		          ,{name:'DT_VOC_END',width:50}
		          ,{name:'NM_VOC_ACT_DEPT',width:50 ,align:'center'}
		      ]
		,autowidth:true
		,multiselect:true
		,onSelectRow: function(rowid){
					//상세 호출
					var selectedRow = $(this).getRowData(rowid);
					uxl.openWindow('popVocDetail', uxl.getScreenURL('POP0023') + '?ID_VOC='+ selectedRow.ID_VOC+ '&ID_SUB_VOC='+selectedRow.ID_SUB_VOC
													, { width:1024,height:700 ,scrollbars:'yes' }, listner);
		}
	};
	uxl.grid('list', options);
	
	fnSearch();
	//조회 이벤트
	$('#search').click(function(event){
		fnSearch();
	});
	
	//베스트 등록 이벤트
	$('#best').click(function(event){
		 var rowids = $('#list').jqGrid('getGridParam','selarrrow');
	 		//체크박스에 선택된 rowdata가 없을 경우 예외처리
	 		if(rowids.length==null || rowids.length=='0'){
	 			alert("체크 박스를 선택한 후 확인 버튼을 눌러 주세요");
	 			return;
	 	  }
		
		 	 //관련VOC의 정보를 담는다.
			var listcount = $("#list",opener.document).getGridParam("reccount");
	    	var parentVocIds = new Array(listcount);
	
			//JqGrid 에 ID_VOC 와 ID_SUB_VOC를 배열에 담는다.
			for (var i = 0; i < listcount; i++) {
				var selectedRow = $("#list",opener.document).getRowData(i);				
				parentVocIds[i] = selectedRow.ID_VOC;
			}
		 	  //추가할 VOC의 ID_VOC와  ID_VOC, 중복체크를 할 VOC_NO(ID_VOC + ID_SUB_VOC) 배열에 담는다.
			  var rowdatas = new Array(rowids.length);
			  var vocIds = new Array(rowids.length);
			  //var vocNoIds = new Array(rowids.length);
	    	  //var vocSubIds = new Array(rowids.length);
	    	  var tpCase = "B";
			  
			  for ( var i = 0; i < rowids.length; i++) {
					rowdatas[i]  = $('#list').jqGrid('getRowData',rowids[i]);
					vocIds[i] = rowdatas[i].ID_VOC;
					//vocNoIds[i] = rowdatas[i].VOC_NO;
					//vocSubIds[i] = rowdatas[i].ID_SUB_VOC;
			 }
			
			//선택한 VOC가 이미 등록되어 있는지 확인한다.
			for(var i=0; i<vocIds.length; i++){ 
				   for(var j=0; j<parentVocIds.length; j++){ 
			    		  if(vocIds[i] == parentVocIds[j]){ 
			         			alert("동일한 VOC를 추가할 수  없습니다.");
			         			return;
				      		} 
				   	}
	  		 }
	  		 
	  		 var vocData = {
						idVoc			: vocIds	  //VOC ID
					,   tpCase		: tpCase
			};
	  		 
	  		uxl.pushToParent(vocData);
			self.close();
		
	});
	
	//워스트 등록 이벤트
	$('#worst').click(function(event){
		 var rowids = $('#list').jqGrid('getGridParam','selarrrow');
	 		//체크박스에 선택된 rowdata가 없을 경우 예외처리
	 		if(rowids.length==null || rowids.length=='0'){
	 			alert("체크 박스를 선택한 후 확인 버튼을 눌러 주세요");
	 			return;
	 	  }
		
		 	 //관련VOC의 정보를 담는다.
			var listcount = $("#list",opener.document).getGridParam("reccount");
	    	var parentVocIds = new Array(listcount);
	
			//JqGrid 에 ID_VOC 와 ID_SUB_VOC를 배열에 담는다.
			for (var i = 0; i < listcount; i++) {
				var selectedRow = $("#list",opener.document).getRowData(i);				
				parentVocIds[i] = selectedRow.ID_VOC;
			}
		 	  //추가할 VOC의 ID_VOC와  ID_VOC, 중복체크를 할 VOC_NO(ID_VOC + ID_SUB_VOC) 배열에 담는다.
			  var rowdatas = new Array(rowids.length);
			  var vocIds = new Array(rowids.length);
			  //var vocNoIds = new Array(rowids.length);
	    	  //var vocSubIds = new Array(rowids.length);
	    	  var tpCase = "W";
			  
			  for ( var i = 0; i < rowids.length; i++) {
					rowdatas[i]  = $('#list').jqGrid('getRowData',rowids[i]);
					vocIds[i] = rowdatas[i].ID_VOC;
					//vocNoIds[i] = rowdatas[i].VOC_NO;
					//vocSubIds[i] = rowdatas[i].ID_SUB_VOC;
			 }
			
			//선택한 VOC가 이미 등록되어 있는지 확인한다.
			for(var i=0; i<vocIds.length; i++){ 
				   for(var j=0; j<parentVocIds.length; j++){ 
			    		  if(vocIds[i] == parentVocIds[j]){ 
			         			alert("동일한 VOC를 추가할 수  없습니다.");
			         			return;
				      		} 
				   	}
	  		 }
	  		 
	  		 var vocData = {
						idVoc			: vocIds	  //VOC ID
					,   tpCase		: tpCase
			};
	  		 
	  		uxl.pushToParent(vocData);
			self.close();
		
	});
	
	//자동완성 기능(내용유형)
	uxl.autocomplete('NM_VOC_CAUSE', uxl.getFunctionUrl(_SCREEN_ID,'USERDEFINED1'),  {
					data : {}
					, minLength : 2
					, itemExtractor : function(row) { 
													var item = {
																id : row.CODE
																, value : row.CODE_NAME
																, label : row.CODE_NAME
													};
						return item;
					}
	    			, select: function(event, ui) {
									    			var str = ui.item.id;
											    	$('#CD_VOC_CAUSE_1').val(str.substr(0,3));
											    	uxl.chainCombo($('#CD_VOC_CAUSE_1'), $('#CD_VOC_CAUSE_2') , 'CD_VOC_CAUSE_2', {parameter : {}, unusedMapping:true});
											    	$('#CD_VOC_CAUSE_2').val(str.substr(0,6));
											    	uxl.chainCombo($('#CD_VOC_CAUSE_2'), $('#CD_VOC_CAUSE_3') , 'CD_VOC_CAUSE_3', {parameter : {}, unusedMapping:true});
											    	$('#CD_VOC_CAUSE_3').val(str).change();
													}
	});
	
});

function listner(){

}

/*
 * 조회한 데이터를 그리드에 추가함.
 * @param {String} 그리드로 변환할 테이블ID
 * @param {Result} 조회된 데이터 객체 result
 * @param {boolean} 데이터 추가시 기존데이터의 clear 여부
 */
function fnSearch(){
	//필수정보 체크
	var url = uxl.getFunctionUrl(_SCREEN_ID,'INQUIRY');
	var option = {
			  data:uxl.grid.getParam('list')
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
</script>
