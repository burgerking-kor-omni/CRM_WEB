<%--
#*
 *  파 일 명 :  EXP8001.jsp
 *  설    명 :  공지사항 목록
 *  작 성 자 :  김범수
 *  작 성 일 :  2013-05-10
 *  버    전 :  1.0
 *  기타사항 :
 *  Copyrights 2011 by ㈜ 유비원. All right reserved.
*# 
--%>
<%@page import="com.ubone.framework.engine.domain.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/include/pageCommon.jsp" %>
<%@ page import="com.ubone.framework.ConstantHolder"%>
<%@ page import="com.ubone.framework.util.UserUtil"%>
<%@ include file="/WEB-INF/jsp/include/pageTagLibs.jsp"%>

<script src="<c:url value="/uxl/ext/jquery/fileDownload/jquery.fileDownload.js"/>"></script>


<div id="gridPager" ></div>

<script type="text/javascript">
//uxl.onLoad(function(){
$(document).ready(function(){
	
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
			paging : { top : true, buttom : true }			
		}
		, rowNum : 20
	};
	uxl.grid('list', options);

	//조회 이벤트
	fnSearch();
	$('#search').click(function(event){
		fnSearch();
	});
	
	//등록 이벤트
	$('#save').click(function(event){
		uxl.moveLocation(uxl.getScreenURL('EXP8003'));
	});
	
	$('#excel').click(function(){
		fnGetExcel();
	});
});

//조회
function fnSearch(){
	
	if($('#DT_REG_START').val()!='' && $('#DT_REG_END').val()!=''){
		//등록일자 예외처리(시작일이 종료일 보다 작아야한다.)
		if(DateUtil.getDayInterval($('#DT_REG_START').val(),$('#DT_REG_END').val()) <0){
			uxl.showMessage(uxl.getMessage('@message.voc.search.date.target', '등록일자'));
			return;
		}
	}	
	
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


//엑셀 다운로드
function fnGetExcel(){
	var url = uxl.getFunctionUrl(_SCREEN_ID,'EXPORT');
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
				fnSearchExcel(result);
			}
			, async:true
	};
	uxl.callFunction(url , option );
}

function fnSearchExcel(result){
	var filelink = result.getResultKey();
	if ($('#exportListViewer').size() == 0) {
		$('<div id="exportListViewer"></div>').appendTo('body');
	}
	$('#exportListViewer').dialog({
		width: 460,
		title : 'Download Result',
		open: function(event, ui) {
			var tag = '';
			if(filelink == null) {
				tag = tag + '<span>다운로드할 데이터가 존재하지 않습니다.</span>';
			}
			else {
				tag = tag + '<span>아래의 다운로드 link를 클릭하시면 파일을 다운로드 받을 수 있습니다.</span>';
				tag = tag + '<br/><br/><ul>';
				for(var i=0; i<filelink.length; i++) {
					var url = uxl.getContextURL('/file/view.do');
					url = uxl.addQueryToUrl(url, 'filePath', filelink[i]);
					tag = tag + '<li ><a href="' + url + '" target="_self" style="color:#B54444"> 다운로드 파일 '+ (i + 1) +' </a></li>';
				}
				tag = tag + '</ul>';
			}
			
			$(this).html(tag);
		},
		close: function(event, ui) {
			$(this).remove();
		}
	});
}
</script>