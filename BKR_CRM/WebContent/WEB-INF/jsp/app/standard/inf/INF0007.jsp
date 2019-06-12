<%--
#*
 *  파 일 명 :  INF0007.jsp
 *  설    명 :  자료실 목록 
 *  작 성 자 :  이슬기
 *  작 성 일 :  2015-10-03
 *  버    전 :  1.0
 *  기타사항 :
 *  Copyrights 2015 by ㈜ 유비원. All right reserved.
*#
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.ubone.framework.ConstantHolder"%>
<%@page import="com.ubone.framework.util.StringUtils"%>
<%@ include file="/WEB-INF/jsp/include/pageCommon.jsp" %>
<style>
	.ui-jqgrid-bdiv tr { cursor : pointer; }
</style>
<script type="text/javascript">

uxl.onLoad(function(){
	
	var options = {
			
		//header name
		colNames:['게시판ID','제목','등록부서','등록자','등록일시','첨부']

		//mapping column
		,colModel:[
				  {name:'ID_BULLETIN',width:0,hidden:true}
			 	 ,{name:'DS_TITLE',width:80}					/* 제목 */
				 ,{name:'NM_REG_DEPT',width:30, align:'center'} /* 등록팀/지점 */
				 ,{name:'NM_REG_EMP',width:30, align:'center'}	/* 등록자 */
				 ,{name:'DT_REG',width:30, align:'center'}		/* 등록일시 */
				 ,{name:'CNT_ATTACH',width:10, align:'center'}	/* 첨부 */
		]
		,autowidth:true
		, height: 390
		,onSelectRow: function(rowid){
			var selectedRow = $(this).getRowData(rowid);
			uxl.moveLocation(uxl.getScreenURL('INF0008') + '?ID_BULLETIN='+selectedRow.ID_BULLETIN);
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
		
		//조회 이벤트
		$('#search').click(function(event){
			uxl.grid.init('list');
			fnSearch();
		});
		
		//등록 이벤트
		$('#register').click(function(event){
			uxl.moveLocation(uxl.getScreenURL('INF0009'));
		});
	
		//엔터키 검색 전체적용
		$('#searchForm').keydown(function(event) {
			if(event.keyCode == '13') {
				fnSearch();
				return false;
			}
		});
		
		//처리자 검색
		$('#empSearch').click(function(event) {
			uxl.openWindow('userpopup', uxl.getScreenURL('POP0001'), { width:'747px' ,height:'605px' }, callBackUser);		
		});
		
		//더블클릭시 clear
		$('#NM_REG_EMP').dblclick(function ()  { $(this).val(''); $('#ID_REG_EMP').val(''); });
		$('#DT_REG_START').dblclick(function ()  { $('#DT_REG_START').val(''); });
		$('#DT_REG_END').dblclick(function ()  { $('#DT_REG_END').val(''); });
		$('#DS_TITLE_CONTENT').dblclick(function(){ $(this).val(''); });
		
	});
	
	//점포팝업 callBack
	function callBackUser(userData) {
		$('#NM_REG_EMP').val(userData.nmUser);							//직원이름
		$('#ID_REG_EMP').val(userData.idUser);							//직원이름
	}

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
		