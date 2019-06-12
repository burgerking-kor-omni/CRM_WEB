<%--
#*
 *  파 일 명 :  INF0020.jsp
 *  설    명 :  처리지침 목록
 *  작 성 자 :  이동엽
 *  작 성 일 :  2014-03-19
 *  버    전 :  1.0
 *  기타사항 :
 *  Copyrights 2011 by ㈜ 유비원. All right reserved.
*# 
--%>
<%@page import="com.ubone.framework.engine.domain.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/include/pageCommon.jsp" %>
<%@ page import="com.ubone.framework.util.UserUtil"%>
<%@ include file="/WEB-INF/jsp/include/pageTagLibs.jsp"%>

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
	
	// 버튼권한
	var hasRole = "<%=hasRole%>";
	if("Y" != hasRole){
		$('#save').hide();
	}
	
	//Combo Ajax 처리
	uxl.bindComboCode('CD_VOC_CAUSE_1', 'CD_VOC_CAUSE_1', {parameter : {}, emptyOption:'전체'});
	uxl.chainCombo($('#CD_VOC_CAUSE_1'), $('#CD_VOC_CAUSE_2') , 'CD_VOC_CAUSE_2', {parameter : {}});
	uxl.chainCombo($('#CD_VOC_CAUSE_2'), $('#CD_VOC_CAUSE_3') , 'CD_VOC_CAUSE_3', {parameter : {}});
	
	$('#save').click(function(event){
		uxl.moveLocation(uxl.getScreenURL('INF0012'));
	});

	$('#Search').click(function(event){
		fnSearch();
	});
	
	
	/*
	그리드 옵션
	colNames : 그리드 Header 정보,
	colModel : 그리드 Contents 의 바인딩 정보
	*/
	var options = {
		//header name
		colNames:['id','등록일자','등록자','수정일자','내용유형', '제목']

		//mapping column
		,colModel:[
				  {name:'ID_GUIDE_ACT' ,width:0, hidden:true}
				 ,{name:'DT_REG' ,width:60, align:'center'}
				 ,{name:'NM_REG_EMP',width:60,align:'center'}
				 ,{name:'DT_UPT',width:60,align:'center'}
				 ,{name:'CD_VOC_CAUSE',width:80,align:'center', codeCategory:'CD_VOC_CAUSE_FULL'}
				 ,{name:'DS_TITLE',width:140,align:'center'}
		]
		, autowidth:true
			, onSelectRow: function(rowid){
				var selectedRow = $(this).getRowData(rowid);
				uxl.moveLocation(uxl.getScreenURL('INF0013') + '?ID_GUIDE_ACT='+selectedRow.ID_GUIDE_ACT);
				
		}
	};
	uxl.grid('list', options);
	
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