<%--
#*
 *  파 일 명 :  ANA0006.jsp
 *  설    명 :  연령대별 회원현황
 *  작 성 자 :  강현준
 *  작 성 일 :  2019-01-02
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
 
   - PAGE ID : ANA000R00
   - PAGE TYPE : META
 
  Copyright ⓒ UBONE Co., Ltd. All rights reserved.
 ========================================================================
--> 

<script type="text/javascript">
uxl.onLoad(function(){

	// code bind
	uxl.bindComboCode('DT_START_Y', 'CD_YEAR', {emptyOption:false});
	uxl.bindComboCode('DT_START_M', 'CD_MONTH', {emptyOption:false});
	uxl.bindComboCode('DT_END_Y', 'CD_YEAR', {emptyOption:false});
	uxl.bindComboCode('DT_END_M', 'CD_MONTH', {emptyOption:false});
	uxl.bindComboCode('CD_AGE', 'CD_AGE', {emptyOption:'전체'});
	uxl.bindComboCode('CD_GENDER', 'CD_GENDER', {emptyOption:'전체'});
	uxl.bindComboCode('CD_GRADE', 'CD_GRADE', {emptyOption:'전체'});
	
	var options = {
		//header name
		colNames:['연령대별','전체 회원수'
		          ,'가입 회원수','휴면 회원수','탈퇴 회원수'
		          ,'로그인 회원수','구매 회원수','쿠폰사용 회원수','멤버십 리워드<br/>회원수','누적 멤버십<br/>리워드 쿠폰수'
		          ,'BKR','네이버','카카오톡','삼성앱 카드'
		          ]
		//mapping column
		,colModel:[
				  {name:'AA'	,width:100 ,align:'center',sortable:false, codeCategory:'CD_AGE'}
				 ,{name:'BB'	,width:90 ,align:'center',sortable:false, formatter: 'integer'}
				 ,{name:'CC'	,width:90 ,align:'center',sortable:false, formatter: 'integer'}
				 ,{name:'DD'	,width:90 ,align:'center',sortable:false, formatter: 'integer'}
				 ,{name:'EE'	,width:90 ,align:'center',sortable:false, formatter: 'integer'}
				 ,{name:'FF'	,width:90 ,align:'center',sortable:false, formatter: 'integer'}
		         ,{name:'GG'	,width:90 ,align:'center',sortable:false, formatter: 'integer'}
		         ,{name:'HH'	,width:90 ,align:'center',sortable:false, formatter: 'integer'}
		         ,{name:'II'	,width:90 ,align:'center',sortable:false, formatter: 'integer'}
		         ,{name:'JJ'	,width:90 ,align:'center',sortable:false, formatter: 'integer'}
		         ,{name:'KK'	,width:90 ,align:'center',sortable:false, formatter: 'integer'}
		         ,{name:'LL'	,width:90 ,align:'center',sortable:false, formatter: 'integer'}
		         ,{name:'MM'	,width:90 ,align:'center',sortable:false, formatter: 'integer'}
		         ,{name:'NN'	,width:90 ,align:'center',sortable:false, formatter: 'integer'}
		]
		,height:290
		,autowidth:true
	};
	uxl.grid('list', options);
	
	
	$("#list").jqGrid('setGroupHeaders', {
		useColSpanStyle: true,
		  groupHeaders:[
			{ startColumnName: 'CC', numberOfColumns: 3, titleText: '상태 관련' },
			{ startColumnName: 'FF', numberOfColumns: 5, titleText: '구매/활동 관련' },
			{ startColumnName: 'KK', numberOfColumns: 4, titleText: '가입 채널' },
		  ]
    });
	
	//Enter Key 이벤트
	$('form').keydown(function(event) {
		if(event.keyCode == '13') {
			fnSearch();
		}
	});
});

uxl.onLoadComplete(function(){
	var dtStart = new Date('${paramMap.DT_START_Y}');
	var MM = dtStart.getMonth()+1;

	$('#DT_START_Y').val(dtStart.getFullYear());
	$('#DT_START_M').val(MM < 10 ? '0'+MM : MM);

    var startDate = dtStart.addMonths(11);
    MM = startDate.getMonth()+1
    $('#DT_END_M').val(MM < 10 ? '0'+MM : MM);
	fnSearch();

});


//전체 XML 생성
function fnSearch(){
	
	var startDate = new Date($('#DT_START_Y').val()+"-"+$('#DT_START_M').val()+'-01');
    var endDate = new Date($('#DT_END_Y').val()+"-"+$('#DT_END_M').val()+'-01');
    var testDate = new Date($('#DT_END_Y').val()+"-"+$('#DT_END_M').val()+'-01');
    testDate.addMonths(-11);

    if(startDate > endDate){
    	alert('검색기간이 유효하지 않습니다.');
    	return;
    }
    if(startDate < testDate){
    	alert('최대 검색기간은 12개월 이내입니다.');
    	return;
    }
	
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