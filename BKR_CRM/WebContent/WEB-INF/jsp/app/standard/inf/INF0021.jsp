<%--
#*
 *  파 일 명 :  INF0021.jsp
 *  설    명 :  사전예보 목록 
 *  작 성 자 :  이슬기
 *  작 성 일 :  2015-03-24
 *  버    전 :  1.0
 *  기타사항 :
 *  Copyrights 2011 by ㈜ 유비원. All right reserved.
*#
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.ubone.framework.util.UserUtil"%>
<%@ page import="com.ubone.framework.util.ViewUtil"%>
<%@ page import="com.ubone.framework.engine.domain.User"%>
<%@ include file="/WEB-INF/jsp/include/pageCommon.jsp" %>

<%
	User user = UserUtil.getLoginUser();
	String hasRole = "N";
	
	// 버튼권한 - 시스템관리자, 민원관리자, 고객의소리(voc)관리자
// 	if(user.hasRole(VocConstantHolder.ROLE_ID_ADMIN)  || user.hasRole(VocConstantHolder.ROLE_CP_DEPT_ADMIN) || user.hasRole(VocConstantHolder.ROLE_CC_ADMIN))
	{
		hasRole = "Y";
	}
%>
<script type="text/javascript">

uxl.onLoad(function(){

	var hasRole = "<%=hasRole%>";
	
	//관리자가 아닐 경우
	if("N" == hasRole){
		//등록 불가
		$('#register').hide();
	}

	//시작년
	uxl.bindComboCode('CD_YEAR_START', 'CD_YEAR', {parameter : {}, emptyOption:'선택'});
	//시작달
	uxl.bindComboCode('CD_MONTH_START', 'CD_MONTH', {parameter : {}, emptyOption:'선택'});
	//종료년
	uxl.bindComboCode('CD_YEAR_END', 'CD_YEAR', {parameter : {}, emptyOption:'선택'});
	//종료달
	uxl.bindComboCode('CD_MONTH_END', 'CD_MONTH', {parameter : {}, emptyOption:'선택'});
	
	
	var options = {
			
		//header name
		colNames:['사전예보ID','년/월','제목','등록부서','등록자','등록일시	']

		//mapping column
		,colModel:[
				  {name:'ID_BEFORE_FORECAST' ,width:0,hidden:true}	/* 사전예보ID */
				 ,{name:'DT_YYMM' ,width:30 ,align:'center'}		/* 년/월 */
			 	 ,{name:'DS_TITLE' ,width:80}						/* 제목 */
				 ,{name:'NM_REG_DEPT' ,width:30, align:'center'}	/* 등록부서 */
				 ,{name:'NM_REG_EMP' ,width:30, align:'center'}		/* 등록자 */
				 ,{name:'DT_REG' ,width:30, align:'center'}			/* 등록일시 */
		]
		,autowidth:true
		, height: 270
		,onSelectRow: function(rowid){
			var selectedRow = $(this).getRowData(rowid);
			uxl.moveLocation(uxl.getScreenURL('INF0022') + '?ID_BEFORE_FORECAST='+selectedRow.ID_BEFORE_FORECAST);
		}
	};
		uxl.grid('list', options);
		fnSearch();
		
		//조회 이벤트
		$('#search').click(function(event){
			fnSearch();
		});
		
		//등록 이벤트
		$('#register').click(function(event){
			uxl.moveLocation(uxl.getScreenURL('INF0023'));
		});
	
		//엔터키 검색 전체적용
		$('#searchForm').keydown(function(event) {
			if(event.keyCode == '13') {
				fnSearch();
				return false;
			}
		});
		
		//더블클릭시 clear
		$('#DS_TITLE_CONTENT').dblclick(function(){ $(this).val(''); });
		$('#DT_REG_START').dblclick(function(){ $(this).val(''); });
		$('#DT_REG_END').dblclick(function(){ $(this).val(''); });
	
		
	});
	

	//조회
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
		