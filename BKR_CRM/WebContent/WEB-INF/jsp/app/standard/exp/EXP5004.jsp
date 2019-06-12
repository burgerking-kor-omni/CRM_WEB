<%--
#*
 *  파 일 명 :  EXP5003.jsp
 *  설    명 :  DIV TAB 목록화면 샘플
 *  작 성 자 :  강영운
 *  작 성 일 :  2017-04-10
 *  버    전 :  1.0
 *  기타사항 :
 *  Copyrights 2011 by ㈜ 유비원. All right reserved.
*# 
--%>
<%@page import="com.ubone.framework.util.ViewUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/include/pageCommon.jsp" %>

<script type="text/javascript">
/**
 * 탭ID에 해당하는 로딩 한수를 등록하는 함수 선언
 *
 * tabId : 현재탭 id
 * thisTab : 현재탭 객체
 * screenId : 현재 탭에 표시되는 화면ID
 */
tab.onLoad('EXP5004', function(tabId, $thisTab, screenId){
	
	/*
	그리드 옵션
	colNames : 그리드 Header 정보,
	colModel : 그리드 Contents 의 바인딩 정보
	*/
	var options = {
		//header name
		colNames:['id','제목','게시여부','공지기간','등록일자']

		//mapping column
		,colModel:[
				  {name:'ID_NOTICE' ,width:40, hidden:true}
				 ,{name:'DS_TITLE' ,width:150}
				 ,{name:'FG_OPEN_PORTAL',width:20,align:'center'}
				 ,{name:'DT_START',width:60,align:'center'}
				 ,{name:'DT_REG',width:40,align:'center'}
		]
		, height : "auto"
		, autowidth:true
		, ondblClickRow: function(rowid){
			var selectedRow = $(this).getRowData(rowid);
			uxl.moveLocation(uxl.getScreenURL('EXP8002') + '?ID_NOTICE='+selectedRow.ID_NOTICE + '&DS_TITLE_H='+$('#DS_TITLE').val() + '&DT_REG_START_H='+$('#DT_REG_START').val() + '&DT_REG_END_H='+$('#DT_REG_END').val());
		}
		, ubPlugins : {
			paging : { top:false, buttom:true }			
		}
		, rowNum : 20
	};
	uxl.grid('list2', options);

	//조회 이벤트
	fnSearch2();
	$('#search', $thisTab).click(function(event){
		fnSearch2();
	});
	
	//등록 이벤트
	$('#save', $thisTab).click(function(event){
		uxl.moveLocation(uxl.getScreenURL('EXP8003'));
	});
});

var fnSearch2 = function(){
	
	if($('#DT_REG_START').val()!='' && $('#DT_REG_END').val()!=''){
		//등록일자 예외처리(시작일이 종료일 보다 작아야한다.)
		if(DateUtil.getDayInterval($('#DT_REG_START').val(),$('#DT_REG_END').val()) <0){
			uxl.showMessage(uxl.getMessage('@message.voc.search.date.target', '등록일자'));
			return;
		}
	}	
	
	//필수정보 체크
	var url = uxl.getFunctionUrl('EXP8001','INQUIRY');
	var option = {
			  data:uxl.grid.getParam('list2')
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
				uxl.grid.appendData('list2',result , true );
			}
			, async:true
	};
	uxl.callSubmitFunction('searchForm2', url , option );		
};	

</script>