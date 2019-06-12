<%--
#*
 *  파 일 명 :  INF0001.jsp
 *  설    명 :  공지사항 목록
 *  작 성 자 :  이슬기
 *  작 성 일 :  2015-07-28
 *  버    전 :  1.0
 *  기타사항 :
 *  Copyrights 2011 by ㈜ 유비원. All right reserved.
*# 
--%>
<%@page import="com.ubone.framework.engine.domain.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.ubone.framework.ConstantHolder"%>
<%@ page import="com.ubone.standard.common.constant.AuthConstantHolder"%>
<%@page import="com.ubone.framework.util.StringUtils"%>
<%@ page import="com.ubone.framework.util.UserUtil"%>
<%@ include file="/WEB-INF/jsp/include/pageCommon.jsp" %>
<%@ include file="/WEB-INF/jsp/include/pageTagLibs.jsp"%>

<%
	User user = UserUtil.getLoginUser();
	String hasRole = "N";
	
	//유저정보
	Boolean hasAdminRole = false;
	
	//관리자 권한(시스템관리자, 전체관리자, 고객서비스 팀장, VOC관리자)
	if(user.hasRole(AuthConstantHolder.ROLE_SYSTEM_ADMIN) || user.hasRole(AuthConstantHolder.ROLE_NORMAL_ADMIN) 
		|| user.hasRole(AuthConstantHolder.ROLE_VOC_ADMIN)){
		hasAdminRole = true;
		hasRole = "Y";
	}
%>
<style>
	.ui-jqgrid-bdiv tr { cursor : pointer; }
</style>
<script type="text/javascript">
uxl.onLoad(function(){
	//관리자 경우(권한 부여)
	//1.등록,수정,삭제 가능
	//2.'게시여부'필드 검색 가능
 	var hasRole = "<%=hasRole%>";
	if("Y" == hasRole){
		//그리드 생성
		makeGridAdmin();
		
	}else{
		//등록 버튼 숨김.
		$('#save').hide();
		
		//그리드 생성
		makeGridUser();
	}

	//조회 이벤트
	$('#search').click(function(event){
		fnSearch();
	}).click();
	
	//등록 이벤트
	$('#save').click(function(event){
		uxl.moveLocation(uxl.getScreenURL('INF0003'));
	});
	
	//엔터키 검색 전체적용
	$('#searchForm').keydown(function(event) {
		if(event.keyCode == '13') {
			fnSearch();
			return false;
		}
	});
	
	//더블 클릭시 clear
	$('#DT_REG_START').dblclick(function(){ $(this).val(''); });
	$('#DT_REG_END').dblclick(function(){ $(this).val(''); });
	$('#DS_TITLE').dblclick(function(){ $(this).val(''); });
	
	
});//End Of onLoad

//조회
function fnSearch(){
	
	if($('#DT_REG_START').val()!='' && $('#DT_REG_END').val()!=''){
		//등록일자 예외처리(시작일이 종료일 보다 작아야한다.)
		if(DateUtil.getDayInterval($('#DT_REG_START').val(),$('#DT_REG_END').val()) <0){
			 alert('등록일자 검색조건이 유효하지 않습니다.');
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
			, success:function(result){
				uxl.grid.init('list');
				uxl.grid.appendData('list' ,result , true );
			}
			, async:true
	};
	uxl.callSubmitFunction('searchForm' , url , option );		
}

function makeGridAdmin(){
	/*
	그리드 옵션 - 관리자(권한자)
	colNames : 그리드 Header 정보,
	colModel : 그리드 Contents 의 바인딩 정보
	*/
	var options = {
		//header name
		colNames:['id','제목','게시여부','등록자','등록일시','상위게시여부','상위게시기한여부']

		//mapping column
		,colModel:[
				  {name:'ID_NOTICE' ,width:40 ,hidden:true}
				 ,{name:'DS_TITLE' ,width:150}
				 ,{name:'FG_OPEN_PORTAL' ,width:15 ,align:'center'}
				 ,{name:'NM_REG_EMP', width:20 ,align:'center'}
				 ,{name:'DT_REG', width:40 ,align:'center'}
				 ,{name:'FG_OPEN_HGST' ,width:2,hidden:true }
				 ,{name:'DT_UPT' ,width:2,hidden:true }
		]
		, height:435
		, autowidth:true
		,afterInsertRow: function(rowid, rowdata){
			//최상위게시여부 'Y'일 경우 CSS적용 
			//최상위게시여부 'Y'상태가 2개 이상일 경우 최근수정일이 가까운 것
			if(rowdata.FG_OPEN_HGST == 'Y'){
				$('#'+rowid).css('background','#bad0e9');
			}
    	}    
		, onSelectRow: function(rowid){
				var selectedRow = $(this).getRowData(rowid);
				uxl.moveLocation(uxl.getScreenURL('INF0002') + '?ID_NOTICE='+selectedRow.ID_NOTICE);
		}
	};
	uxl.grid('list', options);
}

function makeGridUser(){
	/*
	그리드 옵션 - 관리자(권한자)
	colNames : 그리드 Header 정보,
	colModel : 그리드 Contents 의 바인딩 정보
	*/
	var options = {
		//header name
		colNames:['id','제목','등록일자']

		//mapping column
		,colModel:[
				  {name:'ID_NOTICE' ,width:40, hidden:true}
				 ,{name:'DS_TITLE' ,width:150}
				 ,{name:'DT_REG',width:40,align:'center'}
		]
		, height:290
		, autowidth:true
		,afterInsertRow: function(rowid, rowdata){
			//최상위게시여부 'Y'일 경우 CSS적용 
			//최상위게시여부 'Y'상태가 2개 이상일 경우 최근수정일이 가까운 것
			if(rowdata.FG_OPEN_HGST == 'Y'){
				$('#'+rowid).css('background','#bad0e9');
			}
    	}    
		, onSelectRow: function(rowid){
				var selectedRow = $(this).getRowData(rowid);
				uxl.moveLocation(uxl.getScreenURL('INF0002') + '?ID_NOTICE='+selectedRow.ID_NOTICE);
				
		}
	};
	uxl.grid('list', options);
	<%
	String recoveryCommand1 = StringUtils.defaultString(request.getParameter(ConstantHolder.KEY_SEARCH_RECOVERY_COMMAND), "");
	if(!"recovery".equals(recoveryCommand1)){
	%> 
		fnSearch();
	<% 
		}
	%>

}

</script>