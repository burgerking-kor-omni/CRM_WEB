<%--
#*
 *  파 일 명 :  ANA0003.jsp
 *  설    명 :  일별 회원현황
 *  작 성 자 :  강현준
 *  작 성 일 :  2018-12-27
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
 
   - PAGE ID : ANA0003R00
   - PAGE TYPE : META
 
  Copyright ⓒ UBONE Co., Ltd. All rights reserved.
 ========================================================================
--> 

<script type="text/javascript">
uxl.onLoad(function(){
	
	var options = {
		//header name
		colNames:['일자'
		          ,'회원수','전 일 대비<br/>증감'
		          ,'회원수','전 일 대비<br/>증감'
		          ,'회원수','전 일 대비<br/>증감'
		          ,'회원수','전 일 대비<br/>증감'
		          ,'회원수','전 일 대비<br/>증감'
		          ,'회원수','전 일 대비<br/>증감'
		          ,'회원수','전 일 대비<br/>증감'
		          ,'회원수','전 일 대비<br/>증감'
		          ,'회원수','전 일 대비<br/>증감'
		          ,'회원수','전 일 대비<br/>증감'
		          ,'회원수','전 일 대비<br/>증감'
		          ,'회원수','전 일 대비<br/>증감'
		          ,'회원수','전 일 대비<br/>증감'
		          ]
		//mapping column
		,colModel:[
				  {name:'AA'	,width:110 ,align:'center',sortable:false}
				 ,{name:'BB'	,width:80 ,align:'center',sortable:false}
				 ,{name:'CC'	,width:80 ,align:'center',sortable:false}
				 ,{name:'DD'	,width:80 ,align:'center',sortable:false}
				 ,{name:'EE'	,width:80 ,align:'center',sortable:false}
				 ,{name:'FF'	,width:80 ,align:'center',sortable:false}
		         ,{name:'GG'	,width:80 ,align:'center',sortable:false}
		         ,{name:'HH'	,width:80 ,align:'center',sortable:false}
		         ,{name:'II'	,width:80 ,align:'center',sortable:false}
		         ,{name:'JJ'	,width:80 ,align:'center',sortable:false}
		         ,{name:'KK'	,width:80 ,align:'center',sortable:false}
		         ,{name:'LL'	,width:80 ,align:'center',sortable:false}
		         ,{name:'MM'	,width:80 ,align:'center',sortable:false}
		         ,{name:'NN'	,width:80 ,align:'center',sortable:false}
		         ,{name:'OO'	,width:80 ,align:'center',sortable:false}
		         ,{name:'PP'	,width:80 ,align:'center',sortable:false}
		         ,{name:'QQ'	,width:80 ,align:'center',sortable:false}
		         ,{name:'RR'	,width:80 ,align:'center',sortable:false}
		         ,{name:'SS'	,width:80 ,align:'center',sortable:false}
		         ,{name:'TT'	,width:80 ,align:'center',sortable:false}
		         ,{name:'UU'	,width:80 ,align:'center',sortable:false}
		         ,{name:'VV'	,width:80 ,align:'center',sortable:false}
		         ,{name:'WW'	,width:80 ,align:'center',sortable:false}
		         ,{name:'XX'	,width:80 ,align:'center',sortable:false}
		         ,{name:'YY'	,width:80 ,align:'center',sortable:false}
		         ,{name:'ZZ'	,width:80 ,align:'center',sortable:false}
		         ,{name:'AAA'	,width:80 ,align:'center',sortable:false}
		]
		,autoheight:true
	};
	uxl.grid('list', options);
	
	
	$("#list").jqGrid('setGroupHeaders', {
		useColSpanStyle: true,
		  groupHeaders:[
			{ startColumnName: 'BB', numberOfColumns: 2, titleText: '전체' },
			{ startColumnName: 'DD', numberOfColumns: 6, titleText: '상태 관련' },
			{ startColumnName: 'JJ', numberOfColumns: 10, titleText: '구매/활동 관련' },
			{ startColumnName: 'TT', numberOfColumns: 8, titleText: '가입 채널' },
		  ]
    });
	
	$("#list").jqGrid('setGroupHeaders', {
		useColSpanStyle: true,
		  groupHeaders:[
			{ startColumnName: 'DD', numberOfColumns: 2, titleText: '가입' },
			{ startColumnName: 'FF', numberOfColumns: 2, titleText: '휴면' },
			{ startColumnName: 'HH', numberOfColumns: 2, titleText: '탈퇴' },
			{ startColumnName: 'JJ', numberOfColumns: 2, titleText: '로그인' },
			{ startColumnName: 'LL', numberOfColumns: 2, titleText: '구매' },
			{ startColumnName: 'NN', numberOfColumns: 2, titleText: '쿠폰 사용' },
			{ startColumnName: 'PP', numberOfColumns: 2, titleText: '멤버십 리워드' },
			{ startColumnName: 'RR', numberOfColumns: 2, titleText: '누적 멤버십 리워드' },
			{ startColumnName: 'TT', numberOfColumns: 2, titleText: 'BKR' },
			{ startColumnName: 'VV', numberOfColumns: 2, titleText: '네이버' },
			{ startColumnName: 'XX', numberOfColumns: 2, titleText: '카카오톡' },
			{ startColumnName: 'ZZ', numberOfColumns: 2, titleText: '삼성앱 카드' }
		  ]
    });
	
	$('#list_AA').attr('rowspan',3);
	$('#jqgh_list_AA').attr('style','top:40px;');
	$('#list_BB').attr('rowspan',2);

	//Enter Key 이벤트
	$('form').keydown(function(event) {
		if(event.keyCode == '13') {
			fnSearch();
		}
	});

});

uxl.onLoadComplete(function(){
	// code bind
	uxl.bindComboCode('DT_START_Y', 'CD_YEAR', {emptyOption:false});
	uxl.bindComboCode('DT_START_M', 'CD_MONTH', {emptyOption:false});
	uxl.bindComboCode('CD_AGE', 'CD_AGE', {emptyOption:'전체'});
	uxl.bindComboCode('CD_GENDER', 'CD_GENDER', {emptyOption:'전체'});
	uxl.bindComboCode('CD_GRADE', 'CD_GRADE', {emptyOption:'전체'});

	var dtDay = new Date();
	dtDay.addDays(-1);
	
	$('#DT_START_Y').val(dtDay.getFullYear());
	$('#DT_START_M').val(dtDay.getMonth()+1 < 10 ? '0'+(dtDay.getMonth()+1) : dtDay.getMonth()+1);
	
	$('#DT_START_M, #DT_START_Y').change(function(){
		uxl.bindComboCode( 'DT_START_D', 'CD_DATE', {parameter:{YYYY:$('#DT_START_Y').val(),MM:$('#DT_START_M').val()},emptyOption:false});
	}).change();
	$('#DT_START_D').val(dtDay.getDate() < 10 ? '0'+dtDay.getDate():dtDay.getDate());
	
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