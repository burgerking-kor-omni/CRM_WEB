<%--
#*
 *  파 일 명 :  INF0004.jsp
 *  설    명 :  FAQ 목록
 *  작 성 자 :  이슬기
 *  작 성 일 :  2015-10-06
 *  버    전 :  1.0
 *  기타사항 :
 *  Copyrights 2015 by ㈜ 유비원. All right reserved.
*# 
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.ubone.framework.engine.domain.User"%>
<%@ page import="com.ubone.framework.util.UserUtil"%>
<%@ include file="/WEB-INF/jsp/include/pageCommon.jsp" %>
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
	
	$('#CD_CATEGORY_1').append("<option value='01'>로그인오류</option>");
	$('#CD_CATEGORY_1').append("<option value='02'>화면오류</option>");
	
	var hasRole = "<%=hasRole%>";
	
	// 관리자아닐 경우 - 등록버튼 x
	if("N" == hasRole){
		$('#register').hide();
	}

	/*
	그리드 옵션
	colNames : 그리드 Header 정보,
	colModel : 그리드 Contents 의 바인딩 정보
	*/
	var options = {
		//header name
		colNames:['게시판ID','카테고리','제목','등록자','등록일시']

		//mapping column
		,colModel:[
				  {name:'ID_BULLETIN', width:1,hidden:true}
				 ,{name:'TP_CATEGORY' ,width:30 ,align:'center',formatter:test}
				 ,{name:'DS_TITLE' ,width:150}
				 ,{name:'NM_REG_EMP',width:40,align:'center'}
				 ,{name:'DT_REG',width:40,align:'center'}
		]
		, autowidth:true
		, height: 390
			, onSelectRow: function(rowid){
				var selectedRow = $(this).getRowData(rowid);
				uxl.moveLocation(uxl.getScreenURL('INF0005') + '?ID_BULLETIN='+selectedRow.ID_BULLETIN);
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
		fnSearch();
	});
	
	//등록 이벤트
	$('#save').click(function(event){
		uxl.moveLocation(uxl.getScreenURL('INF0006'));
	});
	
	//처리자 검색
	$('#empSearch').click(function(event) {
		uxl.openWindow('empPopup', uxl.getScreenURL('POP0001'), { width:'747px' ,height:'605px' }, callBackUser);		
	});
	
	//엔터키 검색 전체적용
	$('#searchForm').keydown(function(event) {
		if(event.keyCode == '13') {
			fnSearch();
			return false;
		}
	});
	
	//더블클릭 이벤트
	$('#NM_REG_EMP').dblclick(function ()  { $(this).val(''); $('#ID_REG_EMP').val('');});
	$('#DT_REG_START').dblclick(function ()  { $('#DT_REG_START').val('');});
	$('#DT_REG_END').dblclick(function ()  { $('#DT_REG_END').val('');});
	$('#DS_TITLE').dblclick(function(){ $('#DS_TITLE').val('') });

	
});

//점포팝업 callBack
function callBackUser(userData) {
	$('#NM_REG_EMP').val(userData.nmUser);							//직원이름
	$('#ID_REG_EMP').val(userData.idUser);							//직원이름
}

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

function test(cellvalue){
	if(cellvalue == '01'){
		return "로그인오류";
	}else{
		return "화면오류";
	}
}
</script>