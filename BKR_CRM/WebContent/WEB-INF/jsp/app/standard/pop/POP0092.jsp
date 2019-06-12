<%--
#*
 *  파 일 명 :  POP0090.jsp
 *  설    명 :  쿠폰 핀 현황 보기 팝업
 *  작 성 자 :  강현준
 *  작 성 일 :  2018.11.06
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
 
   - PAGE ID : POP0090R00
   - PAGE TYPE : META
 
  Copyright ⓒ UBONE Co., Ltd. All rights reserved.
 ========================================================================
--> 
<script type="text/javascript">

uxl.onLoad(function(){
	
	var url = uxl.getFunctionUrl('POP0091','INQUIRY');
	var option = {
			  data:{}
			, success:function(result){
				
				var row = result.getDataList(0).rows[0]
				$('#NO_REQ').val(row.NO_REQ);
				
				$('#CD_COUPON_OBJ').html(row.CD_COUPON_OBJ);
				$('#NM_COUPON').html(row.NM_COUPON);
				$('#DT_EXPIRY').html(row.DT_EXPIRY);
				
				$('#DT_EXPIRY_START').val(row.DT_EXPIRY_START);
				$('#DT_EXPIRY_END').val(row.DT_EXPIRY_END);
				$('#CD_STATUS').html(row.CD_STATUS);
				
				$('#TXT_STATUS').html(row.TXT_STATUS);
			}
			, async:true
	};
	uxl.callSubmitFunction('searchForm' , url , option );

	$('#TXT_LABEL').html(' <b>다우에서 해당 쿠폰의 핀을  '+$('#CNT_PIN').val()+'  개 발행하시겠습니까?</b>');
});

function fnPublish(){

	var cnt_pin = $('#CNT_PIN').val();
	cnt_pin.replace(',','');
	$('#CNT_PIN').val(cnt_pin);
	
	if($('#NO_REQ').val() == ''){
		alert('해당 쿠폰에 다우 쿠폰 번호가 없습니다.');
		return;
	}

	var url = uxl.getFunctionUrl(_SCREEN_ID,'CHECK');
	var option = {
			  data:{}
			, success:function(result){
				opener.fnSearch();
				uxl.close();
			}
			, message : {
				 confirm : uxl.getMessage('@message.common.confirm','발행'),
				 success : uxl.getMessage('@message.common.success','발행'),
				 fail : uxl.getMessage('@message.common.fail','발행')
			}
			, async:true
	};
	uxl.callSubmitFunction('searchForm' , url , option );
}
</script>