<%--
#*
 *  파 일 명 :  POP0096.jsp
 *  설    명 :  상품 선택 팝업
 *  작 성 자 :  강현준
 *  작 성 일 :  2018.11.09
 *  버    전 :  1.0
 *  기타사항 :
 *  Copyrights 2011 by ㈜ 유비원. All right reserved.
*#
--%>
<%@page import="com.ubone.framework.util.ViewUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/include/pageCommon.jsp" %>
<%@ page import="com.ubone.framework.ConstantHolder"%>
<%@ page import="com.ubone.framework.ConfigHolder"%>
<%@ page import="org.apache.commons.lang.StringUtils"%>
<%@ page import="com.ubone.ubmeta.page.util.JspUtils"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core"   prefix="c" %>


<!--  ========================================================================
  This page is generated with the UB-META™ ver4.0 
 
   - PAGE ID : POP0096R00
   - PAGE TYPE : META
 
  Copyright ⓒ UBONE Co., Ltd. All rights reserved.
 ========================================================================
--> 
<style>
	.ui-jqgrid tr.jqgrow td { text-overflow: ellipsis;-o-text-overflow: ellipsis; }
</style>
<script type="text/javascript">

uxl.onLoad(function(){
	
	// 코드 세팅
	uxl.bindComboCode('MENU_CATEGORY_1', 'MENU_CATEGORY_1', {parameter:{MENU_TYPE:$('#MENU_TYPE').val()}, emptyOption:'전체' });
	uxl.chainCombo('MENU_CATEGORY_1', 'MENU_CATEGORY_2', 'MENU_CATEGORY_2', {parameter:{MENU_TYPE:$('#MENU_TYPE').val()}});
	uxl.bindComboCode('USE_YN', 'USE_YN', {emptyOption:'전체' });
	
	$('#CD_MENU_TYPE').append('<option value="1" selected>킹오더</option>');
	$('#CD_MENU_TYPE').append('<option value="2">딜리버리</option>');
	
	// 매장 목록
	var	options = {
			//header name
			colNames:['카테고리','상품 코드','상품명','가격','상태','등록일']

			//mapping column
			,colModel:[
			          {name:'MAIN_MENU_NM',width:16,align:'center'}
			         ,{name:'MENU_CD',width:5,align:'center'}
					 ,{name:'MENU_NM',width:25,align:'center'}
					 ,{name:'DINE_IN_PRC',width:5,align:'center',formatter:setComma}
					 ,{name:'USE_YN',width:3,align:'center',codeCategory:'USE_YN'}
					 ,{name:'REG_DATE',width:10,align:'center'}
			]
			, height:290
			, autowidth:true
			, onSelectRow: function(rowid){
				var selRow = $(this).getRowData(rowid);
				var data = {
						  MENU_CD : selRow.MENU_CD
						, MENU_NM : selRow.MENU_NM
				}
				uxl.pushToParent(data);
				self.close();
			}
		};
	uxl.grid('list', options);
	
	// 입력폼 더블 클릭 시 값 초기화
	$('form').dblclick(function(e){
		e.target.value = "";
	});
	
	// 엔터키 입력 시 조회
	$('form').keydown(function() {
	    if (event.keyCode === 13) {
	        fnSearch();
	    }
	});
	
	if(opener._SCREEN_ID == 'VOC0004'){
		$('#CD_MENU_TYPE').change(function(){
			$('#MENU_TYPE').val($(this).val());
			uxl.bindComboCode('MENU_CATEGORY_1', 'MENU_CATEGORY_1', {parameter:{MENU_TYPE:$('#MENU_TYPE').val()}, emptyOption:'전체' });
			uxl.chainCombo('MENU_CATEGORY_1', 'MENU_CATEGORY_2', 'MENU_CATEGORY_2', {parameter:{MENU_TYPE:$('#MENU_TYPE').val()}});
		}).change();
		$('#layout-1_1').show();
	}else{
		$('#layout-1_1').hide();
		fnSearch();
	}
});

// 쿠폰 정보 조회
function fnSearch(){

	var data = {};
	//필수정보 체크
	var url = uxl.getFunctionUrl(_SCREEN_ID,'INQUIRY');
	var option = {
			  data:$.extend(data, uxl.grid.getParam('list'))
			, success:function(result){
				uxl.grid.appendData('list' ,result , true );
			}
			, async:true
	};
	uxl.callSubmitFunction('searchForm' , url , option );
}

function setComma(cellValue, opts, rowObject){
	var str = uxl.setComma(cellValue+" 원");
	if(cellValue.length == 0){
		return '';
	}
	return str;
}
</script>