<%--
#*
 *  파 일 명 :  INF0024.jsp
 *  설    명 :  정독캠페인 목록 
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
	String apMaxRole = user.getMaxRole();
	String hasRole = "N";
	
	// VOC 총괄관리자, 시스템 관리자, 지점 VOC 관리자일 경우 버튼권한
// 	if( apMaxRole.equals(VocConstantHolder.ROLE_VOC_ADMIN) || apMaxRole.equals(VocConstantHolder.ROLE_ID_ADMIN) )
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

	var options = {
		//header name
		colNames:['정독캠페인ID','제목','시작일','종료일']
		//mapping column
		,colModel:[
				  {name:'ID_CAMPAIGN' ,width:0 ,hidden:true}								/* 정독캠페인ID */
			 	 ,{name:'DS_TITLE' ,width:80 ,align:'left'}									/* 제목 */
				 ,{name:'DT_START' ,width:30, align:'center'}								/* 시작일 */
				 ,{name:'DT_END' ,width:30, align:'center'}									/* 종료일 */
		]
		,autowidth:true
		, height: 270
		,onSelectRow: function(rowid){
			var selectedRow = $(this).getRowData(rowid);
			uxl.moveLocation(uxl.getScreenURL('INF0025') + '?ID_CAMPAIGN='+selectedRow.ID_CAMPAIGN);
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
			uxl.moveLocation(uxl.getScreenURL('INF0026'));
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
		$('#DT_START').dblclick(function(){  $(this).val('');  });
		$('#DT_END').dblclick(function(){  $(this).val('');  });
	
		
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
		