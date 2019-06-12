<%--
#*
 *  파 일 명 :  ANA0013.jsp
 *  설    명 :  매장별 스탬프 적립현황 목록
 *  작 성 자 :  강현준
 *  작 성 일 :  2018-01-03
 *  버    전 :  1.0
 *  기타사항 :  
 *  수정이력 :  
 *  Copyrights 2013 by ㈜ 유비원. All right reserved.
*# 
--%>
<%@page import="com.ubone.framework.util.MessageUtils"%>
<%@page import="com.ubone.framework.util.CodeUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.ubone.framework.util.ViewUtil"%>
<%@ include file="/WEB-INF/jsp/include/pageCommon.jsp"%>
<%@ page import="com.ubone.framework.data.DataList"%>
<%@ page import="com.ubone.framework.data.Parameter"%>
<%@ page import="com.ubone.framework.ConstantHolder"%>
<%@ page import="com.ubone.framework.ConfigHolder"%>
<%@ page import="java.util.Map"%>
<%@ page import="org.apache.commons.lang.StringUtils"%>
<%@ page import="com.ubone.ubmeta.page.util.JspUtils"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core"   prefix="c" %>


<!--  ========================================================================
  This page is generated with the UB-META™ ver4.0 
 
   - PAGE ID : ANA0013R00
   - PAGE TYPE : META
 
  Copyright ⓒ UBONE Co., Ltd. All rights reserved.
 ========================================================================
--> 

<script type="text/javascript">
uxl.onLoad(function(){
	
	// code bind
	uxl.bindComboCode('DT_START_Y', 'CD_YEAR', {emptyOption:false});
	uxl.bindComboCode('DT_START_M', 'CD_MONTH', {emptyOption:false});

	var options = {
		//header name
		colNames:['기간'
		          ,'회원수','적립 스탬프'
		          ,'회원수','적립 스탬프'
		          ,'회원수','적립 스탬프'
		          ,'회원수','적립 스탬프'
		          ]
		//mapping column
		,colModel:[
				  {name:'AA' ,width:80 ,align:'center' ,sortable:false}
				 ,{name:'BB' ,width:80 ,align:'center' ,sortable:false, formatter:'integer'}
				 ,{name:'CC' ,width:80 ,align:'center' ,sortable:false, formatter:'integer'}
				 ,{name:'DD' ,width:80 ,align:'center' ,sortable:false, formatter:'integer'}
				 ,{name:'EE' ,width:80 ,align:'center' ,sortable:false, formatter:'integer'}
				 ,{name:'FF' ,width:80 ,align:'center' ,sortable:false, formatter:'integer'}
		         ,{name:'GG' ,width:80 ,align:'center' ,sortable:false, formatter:'integer'}
		         ,{name:'HH' ,width:80 ,align:'center' ,sortable:false, formatter:'integer'}
		         ,{name:'II' ,width:80 ,align:'center' ,sortable:false, formatter:'integer'}
		]
		,height:350
		,autowidth:true
	};
	uxl.grid('list', options);
	
	
	$("#list").jqGrid('setGroupHeaders', {
		useColSpanStyle: true,
		  groupHeaders:[
			{ startColumnName: 'BB', numberOfColumns: 2, titleText: '전체 회원수' },
			{ startColumnName: 'DD', numberOfColumns: 2, titleText: '주니어' },
			{ startColumnName: 'FF', numberOfColumns: 2, titleText: '와퍼' },
			{ startColumnName: 'HH', numberOfColumns: 2, titleText: '킹' },
		  ]
    });

	//Enter Key 이벤트
	$('form').keydown(function(event) {
		if(event.keyCode == '13') {
			fnSearch();
		}
	});
	
	var nowYmd = new Date();
	nowYmd.addMonths(-1);
	var MM = nowYmd.getMonth()+1;
	$('#DT_START_M').val(MM < 10 ? '0'+MM : MM);
	
	fnSearch();
	
});


function fnSearch(){
	
	//필수정보 체크
	var url = uxl.getFunctionUrl(_SCREEN_ID,'INQUIRY');
	var option = {
			  data:uxl.grid.getParam('list')		
			, success:function(result){
				uxl.grid.appendData('list' ,result , true );
			}
			, async:true
	};
	uxl.callSubmitFunction('searchForm' , url , option );
}
</script>