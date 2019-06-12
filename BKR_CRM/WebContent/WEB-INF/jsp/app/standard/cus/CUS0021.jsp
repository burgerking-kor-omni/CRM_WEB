<%--
#*
 *  파 일 명 :  CUS0015.jsp
 *  설    명 :  주문매장 이력 목록
 *  작 성 자 :  강현준
 *  작 성 일 :  2018.06.20
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
 
   - PAGE ID : CUS1002R00
   - PAGE TYPE : META
 
  Copyright ⓒ UBONE Co., Ltd. All rights reserved.
 ========================================================================
--> 

<script type="text/javascript">

uxl.onLoad(function(){
	
	// 선물 분류 코드
	uxl.bindComboCode('CD_GIFT', 'CD_GIFT', {emptyOption:false});
	
	var options = {
			//header name
			colNames:[
			            '카드번호', '금액', '보낸사람', '연락처'
			          , '받은일자', '메세지', '사용여부', '사용일자']

			//mapping column
			,colModel:[
			          {name:'NO_CARD', width:15,align:'center'}
			         ,{name:'', width:15,align:'center' }
			         ,{name:'NM_MEMBER', width:15,align:'center'}
			         ,{name:'NO_PHONE', width:20,align:'center'}

			         ,{name:'DT_REG', width:20,align:'center'}
			         ,{name:'DS_MESSAGE', width:20,align:'center'}
			         ,{name:'YN_USE', width:20,align:'center'}
			         ,{name:'', width:20,align:'center'}
			         
			]
			, height:150
			,autowidth:true
		};
		uxl.grid('receive_list', options);
		
		var options = {
				//header name
				colNames:[
			            '카드번호', '금액', '받은사람', '연락처'
			          , '보낸일자', '메세지', '사용여부', '사용일자']

				//mapping column
				,colModel:[
				          {name:'NO_CARD', width:15,align:'center'}
				         ,{name:'', width:15,align:'center' }
				         ,{name:'NM_TARGET', width:15,align:'center'}
				         ,{name:'NO_PHONE_TARGET', width:20,align:'center'}
				         
				         ,{name:'DT_REG', width:20,align:'center'}
				         ,{name:'DS_MESSAGE', width:20,align:'center'}
				         ,{name:'YN_USE', width:20,align:'center'}
				         ,{name:'', width:20,align:'center'}
				]
				, height:150
				,autowidth:true
			};
		uxl.grid('send_list', options);
		
		// 콤보변경 이벤트
		$('#CD_GIFT').change(function(){
			if($(this).val() == '01'){
				$('#sendLayout').show();
				$('#receiveLayout').hide();
			}else{
				$('#sendLayout').hide();
				$('#receiveLayout').show();
			}
			
			fnSearch();	
		}).change();
		
		
		
});

function fnSearch(){
	
	var flag = $('#CD_GIFT').val();
	var list_nm = "";
	var alias = "";
	
	if(flag == '02'){
		// 받은 선물
		list_nm = "receive_list";
		alias = "INQUIRY";
	}else{
		// 보낸 선물
		list_nm = "send_list";
		alias = "USERDEFINED1";
	}
	
	var data = {
			ID_MEMBER : parent.$('#ID_MEMBER').val()
		};
	//필수정보 체크
	var url = uxl.getFunctionUrl(_SCREEN_ID, alias);
	var option = {
			  data: $.extend(data, uxl.grid.getParam(list_nm))
			/*
			 * 조회한 데이터를 그리드에 추가함.
			 * @param {String} 그리드로 변환할 테이블ID
			 * @param {Result} 조회된 데이터 객체 result
			 * @param {boolean} 데이터 추가시 기존데이터의 clear 여부
			 */
			, success:function(result){
				
				$("#"+list_nm).clearGridData();
				uxl.grid.appendData(list_nm ,result , true );
			}
			, async:true
	};
	uxl.callSubmitFunction( 'listForm', url , option );		
}
</script>