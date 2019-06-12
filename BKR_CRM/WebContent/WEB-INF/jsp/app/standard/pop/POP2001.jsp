<%--
#*
 *  파 일 명 :  POP2001.jsp
 *  설    명 :  스탬프 상품추가 팝업
 *  작 성 자 :  강현준
 *  작 성 일 :  2018.10.25
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
  This page is generated with the UB-META™ ver6.0 
 
   - PAGE ID : CUS2001R00
   - PAGE TYPE : META
 
  Copyright ⓒ UBONE Co., Ltd. All rights reserved.
 ========================================================================
--> 

<script type="text/javascript">

uxl.onLoad(function(){
	
	uxl.bindComboCode('FG_USE','FLAG_YN',{emptyOption:false});
	
	$('input').dblclick(function (){
		$(this).val("");
	});

});

// 상품찾기 팝업
function fnSearch(){
	uxl.openWindow('POP2002', uxl.getScreenURL('POP2002'), {width:'800',height:'500'}, fnCallback);
}

function fnCallback(rdata){
	$('#MENU_CD').val(rdata.MENU_CD);
	$('#MENU_NM').val(rdata.MENU_NM);
}

function fnSave(){
	//필수정보 체크
	var url = uxl.getFunctionUrl(_SCREEN_ID,'REGIST');
	var option = {
			  data:{}
			/*
			 * 조회한 데이터를 그리드에 추가함.
			 * @param {String} 그리드로 변환할 테이블ID
			 * @param {Result} 조회된 데이터 객체 result
			 * @param {boolean} 데이터 추가시 기존데이터의 clear 여부
			 */
			, success:function(result){
				var data = {
						flag : 'P'
				}
				uxl.pushToParent(data);
				uxl.close();
			}
			, message : {
				 confirm : uxl.getMessage('@message.common.insert.confirm'),
				 success : uxl.getMessage('@message.common.insert.success'),
				 fail 	 : uxl.getMessage('@message.common.insert.fail')
			}
			, async:true
	};
	uxl.callSubmitFunction('detailForm' , url , option );
}
</script>