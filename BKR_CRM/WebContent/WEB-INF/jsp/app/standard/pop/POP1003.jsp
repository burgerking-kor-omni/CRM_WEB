<%--
#*
 *  파 일 명 :  POP1003.jsp
 *  설    명 :  적립기준 쿠폰 등록 팝업
 *  작 성 자 :  강현준
 *  작 성 일 :  2018.11.22
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
 
   - PAGE ID : CUS1003R00
   - PAGE TYPE : META
 
  Copyright ⓒ UBONE Co., Ltd. All rights reserved.
 ========================================================================
--> 

<script type="text/javascript">

uxl.onLoad(function(){
	
	var options = {
		//header name
		colNames:['쿠폰코드','쿠폰명','유효기간','시작일','종료일','버튼']

		//mapping column
		,colModel:[
		           {name:'CD_COUPON',width:10,align:'center'}
		         , {name:'NM_COUPON', width:10,align:'center'}
		         , {name:'DT_EXPIRY', width:10,align:'center'}
		         , {name:'DT_EXPIRY_START', hidden:true}
		         , {name:'DT_EXPIRY_END', hidden:true}
		         , {name:'', hidden:true, width:5,align:'center', formatter:makeBtn}
		]
		, height:290
		, autowidth:true
		,onSelectRow:function(rowid, status, e){
			var selectedRow = $(this).getRowData(rowid);
			
			$('#CD_COUPON').val(selectedRow.CD_COUPON);
			$('#NM_COUPON').val(selectedRow.NM_COUPON);
			$('#DT_EXPIRY_START').val(selectedRow.DT_EXPIRY_START);
			$('#DT_EXPIRY_END').val(selectedRow.DT_EXPIRY_END);
		}
		, ondblClickRow: function(rowid){
			var selRow = $(this).getRowData(rowid);
			var data = {
					CD_COUPON : selRow.CD_COUPON,
					NM_COUPON : selRow.NM_COUPON,
					DT_EXPIRY : selRow.DT_EXPIRY_START + " ~ " + selRow.DT_EXPIRY_END,
					STR_COUPON : selRow.CD_COUPON+"/"+selRow.NM_COUPON
					
			}
			uxl.pushToParent(data);
			self.close();
		}
	};
	uxl.grid('list', options);
	

	//검색번튼 
	$('#searchBtn').click(function(){
		fnSearch();
	});
	
	// 입력폼 더블 클릭 시 값 초기화
	$('form').dblclick(function(e){
		e.target.value = "";
	});
	
	// 엔터키 입력 시 조회
	$('form').keydown(function() {
	    if (event.keyCode === 13) {
	        fnSearch();
	        return;
	    }
	});
	
	fnSearch();
	
});

function fnSearch(){
	
	var data = {
			CD_COUPON : $('#CD_COUPON_SEARCH').val(),
			NM_COUPON : $('#NM_COUPON_SEARCH').val(),
			CD_COUPON_OBJ : '4'
	};
	
	//필수정보 체크
	var url = uxl.getFunctionUrl('CUP0002','INQUIRY');
	var option = {
			  data:$.extend(data, uxl.grid.getParam('list'))
			, success:function(result){
				uxl.grid.appendData('list' ,result , true );
				$('.select-pagging').hide();
			}
			, async:true
	};
	uxl.callSubmitFunction('searchForm' , url , option );

}

// 쿠폰 등록
function fnSave(){
	var flag = 'Y';
	$('#layout-1_1:eq(0) input').each(function(){
		if($(this).val() == ''){
			flag = 'N'
		}
	});
	
	if(flag == 'N'){
		alert('쿠폰을 선택해 주십시오.');
		return;
	}
	
	var data = {
			CD_COUPON : $('#CD_COUPON').val(),
			NM_COUPON : $('#NM_COUPON').val(),
			DT_EXPIRY : $('#DT_EXPIRY_START').val() + " ~ " + $('#DT_EXPIRY_END').val(),
			STR_COUPON : $('#CD_COUPON').val()+"/"+$('#NM_COUPON').val()
	}
	uxl.pushToParent(data);
	self.close();
}

function makeBtn(cellValue, opts, rowObject){
	var str = '<span class="ub-control button inner icon" onclick="fnSelect('+opts.rowId+')">'
   				 +'<a href="#none" title="등록"><span></span>등록</a>'
    		 +'</span>';
	return str;
}

function fnSelect(rowId){
	var selRow = $('#list').getRowData(rowId);
	var data = {
			CD_COUPON : selRow.CD_COUPON,
			NM_COUPON : selRow.NM_COUPON,
			DT_EXPIRY : selRow.DT_EXPIRY_START + " ~ " + selRow.DT_EXPIRY_END,
			STR_COUPON : selRow.CD_COUPON+"/"+selRow.NM_COUPON
	}
	uxl.pushToParent(data);
	self.close();
}
</script>
