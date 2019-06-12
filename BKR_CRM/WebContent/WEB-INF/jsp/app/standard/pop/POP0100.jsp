<%--
#*
 *  파 일 명 :  POP0100.jsp
 *  설    명 :  매장찾기 팝업
 *  작 성 자 :  강현준
 *  작 성 일 :  2018.10.29
 *  버    전 :  1.0
 *  기타사항 :
 *  Copyrights 2011 by ㈜ 유비원. All right reserved.
*#
--%>
<%@page import="com.ubone.framework.util.ViewUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/include/pageCommon.jsp" %>
<%@ page import="com.ubone.framework.data.DataList"%>
<%@ page import="com.ubone.framework.data.Parameter"%>
<%@ page import="com.ubone.framework.ConstantHolder"%>
<%@ page import="com.ubone.framework.ConfigHolder"%>
<%@ page import="org.apache.commons.lang.StringUtils"%>
<%@ page import="com.ubone.ubmeta.page.util.JspUtils"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core"   prefix="c" %>


<!--  ========================================================================
  This page is generated with the UB-META™ ver4.0 
 
   - PAGE ID : POP0100R00
   - PAGE TYPE : META
 
  Copyright ⓒ UBONE Co., Ltd. All rights reserved.
 ========================================================================
--> 

<script type="text/javascript">

uxl.onLoad(function(){
	
// 	$('#STOR_NM').val('${paramMap.STOR_NM}');
	
	//콤보 세팅
	uxl.bindComboCode('DLVYN','FLAG_YN',{emptyOption:'전체'});
	uxl.bindComboCode('KORD_YN','FLAG_YN',{emptyOption:'전체'});
	uxl.bindComboCode('CLOSE','OPER_TYPE',{emptyOption:'전체'});
	uxl.bindComboCode('DRT_FRCS_TYPE','CD_STORE',{emptyOption:'전체'});
	$('#YN_FLAG').append('<option value="">전체</option><option value="1">Y</option><option value="0">N</option>');
	  
	
	// 매장 목록
	var	options = {
			//header name
			colNames:['매장코드','매장명','D/T여부','직/가맹','전화번호'
			          ,'배달여부','킹오더여부','매장상태']

			//mapping column
			,colModel:[
			          {name:'STOR_CD',width:10,align:'center'}
			         ,{name:'STOR_NM',width:20,align:'center'}
			         ,{name:'DIRVE_TH',width:10,align:'center'}
			         ,{name:'DRT_FRCS_TYPE',width:15,align:'center', codeCategory:'CD_STORE'}
					 ,{name:'TEL_NO',width:20,align:'center'}

					 ,{name:'DLVYN',width:10,align:'center'}
					 ,{name:'KORD_YN',width:10,align:'center'}
					 ,{name:'OPER_TYPE',width:10,align:'center',codeCategory:'OPER_TYPE'}
			]
			, height:290
			, autowidth:true
			,ondblClickRow: function (rowid, iRow, iCol, e) {
				var selRow = $(this).getRowData(rowid);
				var data = {
						STOR_CD : selRow.STOR_CD,
						STOR_NM : selRow.STOR_NM
				}
				uxl.pushToParent(data);
				uxl.close();
			}
		};
	uxl.grid('list', options);

	// 엔터키 이벤트
	$('#searchForm').keydown(function (key) {
		if(key.keyCode == 13){
			fnSearch();	
		}
	});
	
	// 더블 클릭 시 값 초기화
	$('form').dblclick(function(e){
		e.target.value = "";
	});
	
	// 전화번호 숫자만
	$('#TEL_NO').keyup(function(event){
		uxl.setInputMask($(this), "cellPhone");
	});
	
	fnSearch();	
	
});

// 상품목록 조회
function fnSearch(){
	
	var data = {};
	
	//필수정보 체크
	var url = uxl.getFunctionUrl(_SCREEN_ID,'INQUIRY');
	var option = {
			  data:$.extend(data, uxl.grid.getParam('list'))
			/*
			 * 조회한 데이터를 그리드에 추가함.
			 * @param {String} 그리드로 변환할 테이블ID
			 * @param {Result} 조회된 데이터 객체 result
			 * @param {boolean} 데이터 추가시 기존데이터의 clear 여부
			 */
			, success:function(result){
				uxl.grid.appendData('list' ,result , true );
				$('.select-pagging').hide();
			}
			, async:true
	};
	uxl.callSubmitFunction('searchForm' , url , option );

}

// 선택클릭 시
function fnSelect(){
	var rowid =  $('#list').getGridParam( "selrow" );
	var selRow = $('#list').getRowData(rowid);
	var data = {
			STOR_CD : selRow.STOR_CD,
			STOR_NM : selRow.STOR_NM
	}
	uxl.pushToParent(data);
	uxl.close();
}
</script>