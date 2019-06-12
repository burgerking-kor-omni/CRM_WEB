<%--
#*
 *  파 일 명 :  INF0010.jsp
 *  설    명 :  베스트 상담사례 목록
 *  작 성 자 :  이슬기
 *  작 성 일 :  2015-08-03
 *  버    전 :  1.0
 *  기타사항 :
 *  Copyrights 2015 by ㈜ 유비원. All right reserved.
*# 
--%>
<%@ page import="com.ubone.framework.engine.domain.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/include/pageCommon.jsp" %>
<%@ page import="com.ubone.framework.util.UserUtil"%>
<%@ include file="/WEB-INF/jsp/include/pageTagLibs.jsp"%>
<%@page import="com.ubone.framework.ConstantHolder"%>
<%@page import="com.ubone.framework.util.StringUtils"%>
<%
	User user = UserUtil.getLoginUser();
	String hasRole = "N";
	
	// 버튼권한 - 시스템관리자, 민원관리자, 고객의소리(voc)관리자
// 	if(user.hasRole(VocConstantHolder.ROLE_ID_ADMIN)  || user.hasRole(VocConstantHolder.ROLE_VOC_ADMIN) || user.hasRole(VocConstantHolder.ROLE_CC_ADMIN))
	{
		hasRole = "Y";
	}
%>

<script type="text/javascript">
uxl.onLoad(function(){
	
	var hasRole = "<%=hasRole%>";
	
	//관리자가 아닐 경우
	if("N" == hasRole){
		//등록버튼 숨김
		$('#register').hide();
	}
	
	//분류유형
	uxl.bindComboCode('CD_VOC_PATTERN_1', 'CD_VOC_PATTERN_1', {parameter : {}, emptyOption:'전체'});
	uxl.chainCombo($('#CD_VOC_PATTERN_1'), $('#CD_VOC_PATTERN_2') , 'CD_VOC_PATTERN_2', {parameter : {}});
	uxl.chainCombo($('#CD_VOC_PATTERN_1'), $('#CD_VOC_CAUSE_1') , 'CD_VOC_CAUSE_1', {parameter : {}});   
	uxl.chainCombo($('#CD_VOC_CAUSE_1'), $('#CD_VOC_CAUSE_2') , 'CD_VOC_CAUSE_2', {parameter : {}});
	uxl.chainCombo($('#CD_VOC_CAUSE_2'), $('#CD_VOC_CAUSE_3') , 'CD_VOC_CAUSE_3', {parameter : {}}); 
	
	//접수경로
 	uxl.bindComboCode('TP_CHNN_SYSTEM', 'TP_CHNN_SYSTEM', {parameter : {}, emptyOption:'전체'});
	uxl.chainCombo($('#TP_CHNN_SYSTEM'), $('#TP_CHNN_PATH') , 'TP_CHNN_PATH', {parameter : {}});
	
	var hasRole = "<%=hasRole%>";
	//권한별 등록 컨트롤
	if(hasRole == "V"){     
		//1.고객의소리(voc)관리자 -> voc 등록가능
		$('select[id=CD_VOC_PATTERN_1]').val('01').change();
		$('#CD_VOC_PATTERN_1').attr('disabled',true);
	}else if(hasRole == "C"){
		//2.민원관리자 -> 민원 등록가능
		$('select[id=CD_VOC_PATTERN_1]').val('02').change();
		$('#CD_VOC_PATTERN_1').attr('disabled',true);
	}
	
	
	/*
	그리드 옵션
	colNames : 그리드 Header 정보,
	colModel : 그리드 Contents 의 바인딩 정보
	*/
	var options = {
		//header name
		colNames:['id','VOC_ID','ID_SUB_VOC','VOC ID','VOC 제목','사례유형','접수경로','유형','분류유형','처리자','등록일자']

		//mapping column
		,colModel:[
				  {name:'SEQ_VOC_RELATION_BEST' ,width:0 ,hidden:true}   
				 ,{name:'ID_VOC' ,width:0 ,hidden:true}    
				 ,{name:'ID_SUB_VOC' ,width:0 ,hidden:true}
				 ,{name:'ID_VOC_ALL' ,width:80 ,align:'left'} //VOC ID
				 ,{name:'DS_TITLE' ,width:150} //제목
				 ,{name:'TP_CASE' ,width:25 ,align:'center' ,codeCategory:'TP_CASE'}// 사례유형
				 //,{name:'TP_CHNN_SYSTEM' ,width:30 ,align:'center' ,codeCategory:'TP_CHNN_SYSTEM'} //접수채널
				 ,{name:'TP_CHNN_PATH' ,width:30 ,align:'center' ,codeCategory:'TP_CHNN_PATH'} //접수경로
				 ,{name:'NM_VOC_PATTERN' ,width:20 ,align:'center'} // VOC유형1
				 ,{name:'CD_VOC_CAUSE' ,width:100 ,codeCategory:'CD_VOC_CAUSE_FULL'} //세부유형
				 ,{name:'NM_VOC_ACT_EMP' ,width:50 ,align:'center'} //처리자
				 ,{name:'DT_REG' ,width:60 ,align:'center'} //등록일자
		]
		//, multiselect:true
		, height:390
		, autowidth:true
		, onSelectRow: function(rowid){
				var selectedRow = $(this).getRowData(rowid);
				uxl.moveLocation(uxl.getScreenURL('INF0015') +'?SEQ_VOC_RELATION_BEST='+ selectedRow.SEQ_VOC_RELATION_BEST +'&ID_VOC='+ selectedRow.ID_VOC +'&ID_SUB_VOC='+ selectedRow.ID_SUB_VOC +'&PAGEID='+_SCREEN_ID);
		}
		, onSelectAll: function (rowid) {
			if("Y"!= hasRole){
				$(this).jqGrid('resetSelection');	
				return true;	
			}
		}
	};
	uxl.grid('list', options);
	<%
	String recoveryCommand = StringUtils.defaultString(request.getParameter(ConstantHolder.KEY_SEARCH_RECOVERY_COMMAND), "");
	if(!"recovery".equals(recoveryCommand)){
	%> 
		fnSearch();
	<% 
		}
	%>

	// 리셋
	$('#DT_VOC_REG_START').dblclick(function(){   $(this).val(''); });
	$('#DT_VOC_REG_END').dblclick(function(){   $(this).val(''); });
	$('#NM_VOC_CAUSE').dblclick(function(){
		$(this).val('');
		uxl.bindComboCode('CD_VOC_CAUSE_1', 'CD_VOC_CAUSE_1', {parameter : {}, emptyOption:'전체'});
		uxl.chainCombo($('#CD_VOC_CAUSE_1'), $('#CD_VOC_CAUSE_2') , 'CD_VOC_CAUSE_2', {parameter : {}});
		uxl.chainCombo($('#CD_VOC_CAUSE_2'), $('#CD_VOC_CAUSE_3') , 'CD_VOC_CAUSE_3', {parameter : {}});
	});
	$('#DS_TITLE').dblclick(function(){ $(this).val(''); });
	
	//조회 이벤트
	$('#search').click(function(event){
		uxl.grid.init('list');
		fnSearch();
	});
	
	//등록 이벤트
	$('#register').click(function(event){
		uxl.moveLocation(uxl.getScreenURL('INF0011'));
	});
	
	//삭제 이벤트
	$('#delete').click(function(event){
		fnDelete();
	});
	
	//엔터키 검색 전체적용
	$('#searchForm').keydown(function(event) {
		if(event.keyCode == '13') {
			fnSearch();
			return false;
		}
	});
	
	
	//자동완성 기능(내용유형)
	uxl.autocomplete('NM_VOC_CAUSE', uxl.getFunctionUrl(_SCREEN_ID,'USERDEFINED1'),  {
					data : {CD_VOC_PATTERN_1: function(){
						return $('#CD_VOC_PATTERN_1').val();
					}}
					, minLength : 2
					, itemExtractor : function(row) { 
													var item = {
																      id : row.CODE
																, value: row.CODE_NAME
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


//조회
function fnSearch(){
	
	if($('#DT_VOC_REG_START').val()!='' && $('#DT_VOC_REG_END').val()!=''){
		//등록일자 예외처리(시작일이 종료일 보다 작아야한다.)
		if(DateUtil.getDayInterval($('#DT_VOC_REG_START').val(),$('#DT_VOC_REG_END').val()) <0){
			uxl.showMessage(uxl.getMessage('@message.voc.search.date.target', '등록일자'));
			return;
		}
	}
	
	//필수정보 체크
	var url = uxl.getFunctionUrl(_SCREEN_ID,'INQUIRY');
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

function fnDelete(){

	    var rowids = $('#list').jqGrid('getGridParam','selarrrow');
	    
 		//체크박스에 선택된 rowdata가 없을 경우 예외처리
 		if(rowids == ''){
 			uxl.showMessage(uxl.getMessage('@message.voc.Report.checkList'));
 			return;
 	  	}

 		var seqNum = new Array(rowids.length);
 		var rowdata = '';
 		
 		for ( var i = 0; i < rowids.length; i++) {
 			rowdata = $('#list').jqGrid('getRowData', rowids[i]);
			seqNum[i] = rowdata.SEQ_NUM;
		}
	
		var url = uxl.getFunctionUrl(_SCREEN_ID,'REMOVE');
		var option = {
				  data:{'seqNum':seqNum}
				, success:function(result){
					fnSearch();
				}
				, async:true
				, message : {
					 confirm : uxl.getMessage('@message.common.delete.confirm'),
					 success : uxl.getMessage('@message.common.delete.success'),
					 fail : uxl.getMessage('@message.common.delete.fail')
				  }
				
		};
		uxl.callSubmitFunction('searchForm' , url , option );

}
</script>