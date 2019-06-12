<%--
#*
 *  파 일 명 :  ANA0010.jsp
 *  설    명 :  월별 스탬프 적립 현황
 *  작 성 자 :  강현준
 *  작 성 일 :  2019-01-03
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
 
   - PAGE ID : ANA0010R00
   - PAGE TYPE : META
 
  Copyright ⓒ UBONE Co., Ltd. All rights reserved.
 ========================================================================
--> 

<script type="text/javascript">
uxl.onLoad(function(){

	// code bind
	uxl.bindComboCode('DT_START_Y', 'CD_YEAR', {emptyOption:false});
	uxl.bindComboCode('DT_START_M', 'CD_MONTH', {emptyOption:false});
	uxl.bindComboCode('CD_AGE', 'CD_AGE', {emptyOption:'전체'});
	uxl.bindComboCode('CD_GENDER', 'CD_GENDER', {emptyOption:'전체'});
	uxl.bindComboCode('CD_GRADE', 'CD_GRADE', {emptyOption:'전체'});
	
	var options = {
		//header name
		colNames:['기간','전체 회원수',
		          '적립안함','1개',	'2개',
		          '3개','4개','5개','6개',
		          '7개','8개','9개','10개',
		          '리워드 5','리워드 10'
		          ]
		//mapping column
		,colModel:[
				  {name:'AA'	,width:90 ,align:'center',sortable:false}
				 ,{name:'BB'	,width:100 ,align:'center',sortable:false, formatter:'integer'}
				 ,{name:'CC',hidden:true,width:90 ,align:'center',sortable:false, formatter:'integer'}
				 ,{name:'DD'	,width:90 ,align:'center',sortable:false, formatter:'integer'}
				 ,{name:'EE'	,width:90 ,align:'center',sortable:false, formatter:'integer'}
				 ,{name:'FF'	,width:90 ,align:'center',sortable:false, formatter:'integer'}
		         ,{name:'GG'	,width:90 ,align:'center',sortable:false, formatter:'integer'}
		         ,{name:'HH'	,width:90 ,align:'center',sortable:false, formatter:'integer'}
		         ,{name:'II'	,width:90 ,align:'center',sortable:false, formatter:'integer'}
		         ,{name:'JJ'	,width:90 ,align:'center',sortable:false, formatter:'integer'}
		         ,{name:'KK'	,width:90 ,align:'center',sortable:false, formatter:'integer'}
		         ,{name:'LL'	,width:90 ,align:'center',sortable:false, formatter:'integer'}
		         ,{name:'MM'	,width:90 ,align:'center',sortable:false, formatter:'integer'}
		         ,{name:'NN'	,width:90 ,align:'center',sortable:false, formatter:'integer'}
		         ,{name:'OO'	,width:90 ,align:'center',sortable:false, formatter:'integer'}
		]
		,height:350
		,autowidth:true
// 		, ubPlugins :{
// 			footerSum :{
// 				  sumTitle : {index:0, title:'합계 : '}
// 				, sumColumns :['BB','CC','DD'
// 				               ,'EE'
// 				               ,'FF'
// 				               ,'GG'
// 				               ,'HH'
// 				               ,'II'
// 				               ,'JJ'
// 				               ,'KK'
// 				               ,'LL'
// 				               ,'MM'
// 				               ,'NN']
// 			}
// 		}
	};
	uxl.grid('list', options);
	
	
	$("#list").jqGrid('setGroupHeaders', {
		useColSpanStyle: true,
		  groupHeaders:[
			{ startColumnName: 'CC', numberOfColumns: 11, titleText: '스탬프 개수 별 회원 수' },
			{ startColumnName: 'NN', numberOfColumns: 2, titleText: '리워드 개수' }
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

//전체 XML 생성
function fnSearch(){
	
	//필수정보 체크
	var url = uxl.getFunctionUrl(_SCREEN_ID,'INQUIRY');
	var option = {
			  data:uxl.grid.getParam('list')		
			, success:function(result){
				uxl.grid.appendData('list' ,result, true );
			}
			, async:true
	};
	uxl.callSubmitFunction('searchForm' , url , option );	
}

function setComma(cellValue, options, rowdata, action){
	return uxl.setComma(cellValue);
}
</script>