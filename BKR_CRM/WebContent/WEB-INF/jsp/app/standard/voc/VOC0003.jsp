<%--
#*
 *  파 일 명 :  VOC0001.jsp
 *  설    명 :  VOC 문의 목록
 *  작 성 자 :  강현준
 *  작 성 일 :  2018.10.18
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
<%@ page import="com.ubone.standard.common.encrypto.IwtCrypt"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core"   prefix="c" %>


<!--  ========================================================================
  This page is generated with the UB-META™ ver4.0 
 
   - PAGE ID : CUS0001R00
   - PAGE TYPE : JSP
 
  Copyright ⓒ UBONE Co., Ltd. All rights reserved.
 ========================================================================
--> 

<script type="text/javascript">

uxl.onLoad(function(){
	
	// 코드 세팅
	uxl.bindComboCode('CD_CHNN','CD_CHNN',{emptyOption : '전체'});
	uxl.bindComboCode('CD_STATUS','CD_VOC_STATUS',{emptyOption : '전체'});
	uxl.bindComboCode('CD_VOC_CAUSE','CD_VOC_CAUSE',{emptyOption : '전체'});
	uxl.bindComboCode('CD_ACT_CAUSE','CD_ACT_CAUSE',{emptyOption : '전체'});
	
	var options = {
			//header name
			colNames:['ID_VOC','채널','이름','이메일','연락처'
			          ,'제목','처리유형','처리상태','처리자','처리일시']
	
			//mapping column
			,colModel:[
					  {name:'ID_VOC',hidden:true}
					 ,{name:'CD_CHNN',width:10,align:'center', codeCategory:'CD_CHNN'}
					 ,{name:'NM_CUST',width:10,align:'center'}
					 ,{name:'DS_EMAIL',width:10,align:'center'}
					 ,{name:'NO_PHONE',width:10,align:'center'}
					 
					 ,{name:'DS_TITLE',width:10,align:'center'}
					 ,{name:'CD_ACT_CAUSE',width:10,align:'center', codeCategory:'CD_ACT_CAUSE'}
					 ,{name:'CD_STATUS',width:10,align:'center', codeCategory:'CD_VOC_STATUS'}
			         ,{name:'NM_ACT_EMP',width:10,align:'center'}
			         ,{name:'DT_VOC_ACT',width:10,align:'center'}
			]
			, height:300
			,autowidth:true
			,onSelectRow: function(rowid){
				var selectedRow = $(this).getRowData(rowid);
				uxl.moveLocation(uxl.getScreenURL('VOC0002')+ '?ID_VOC='+selectedRow.ID_VOC+'&pageid=VOC0003' );
			}
		};
		uxl.grid('list', options);

// 		fnSearch();	
		
		// 검색버튼 클릭시 조회
		$("#search").click(function(event){
			fnSearch();
		});
		
		// 입력폼 더블 클릭 시 값 초기화
		$('form').dblclick(function(e){
			e.target.value = "";
		});
		
		// 전화번호 숫자만
		$('#NO_PHONE_SEARCH').keyup(function(event){
			uxl.setInputMask($(this), "cellPhone");
		});
		
		// 엔터키 입력 시 조회
		$('form').keydown(function() {
		    if (event.keyCode === 13) {
		        fnSearch();
		    }
		});
		
		// 등록버튼
		$('#registBtn').click(function(){
			uxl.moveLocation(uxl.getScreenURL('VOC0004')+"?pageid=VOC0003");
		});
		
});

// 목록 조회
function fnSearch(){
	
	// 날짜 유효성 검사
	var dtStart = new Date($('#DT_REG_START').val());
	var dtEnd = new Date($('#DT_REG_END').val());

	// 시작일이 종료일보다 늦을때
	if(dtStart > dtEnd ){
		var temp = $('#DT_REG_START').val();
		$('#DT_REG_START').val($('#DT_REG_END').val());
		$('#DT_REG_END').val(temp);
	};

	// 날짜 유효성 검사
	dtStart = new Date($('#DT_ACT_START').val());
	dtEnd = new Date($('#DT_ACT_END').val());

	// 시작일이 종료일보다 늦을때
	if(dtStart > dtEnd ){
		var temp = $('#DT_ACT_START').val();
		$('#DT_ACT_START').val($('#DT_ACT_END').val());
		$('#DT_ACT_END').val(temp);
	};
	
	var cd_cause = '01';

	$("#list").clearGridData();
	var data = {CD_VOC_CAUSE : cd_cause};
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
</script>