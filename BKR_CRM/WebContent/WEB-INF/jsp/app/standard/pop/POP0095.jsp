<%--
#*
 *  파 일 명 :  POP0095.jsp
 *  설    명 :  다우 상품 선택 팝업
 *  작 성 자 :  강현준
 *  작 성 일 :  2018.11.09
 *  버    전 :  1.0
 *  기타사항 :
 *  Copyrights 2011 by ㈜ 유비원. All right reserved.
*#
--%>
<%@page import="com.ubone.framework.util.ViewUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/include/pageCommon.jsp" %>
<%@ page import="com.ubone.framework.ConstantHolder"%>
<%@ page import="com.ubone.framework.ConfigHolder"%>
<%@ page import="org.apache.commons.lang.StringUtils"%>
<%@ page import="com.ubone.ubmeta.page.util.JspUtils"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core"   prefix="c" %>


<!--  ========================================================================
  This page is generated with the UB-META™ ver4.0 
 
   - PAGE ID : POP0095R00
   - PAGE TYPE : META
 
  Copyright ⓒ UBONE Co., Ltd. All rights reserved.
 ========================================================================
--> 
<style>
	.ui-jqgrid-bdiv tr { cursor : pointer; }
	.ui-jqgrid tr.jqgrow td { text-overflow: ellipsis;-o-text-overflow: ellipsis; }
</style>
<script type="text/javascript">
var rowid = 0;
uxl.onLoad(function(){
	// 매장 목록
	var	options = {
			//header name
			colNames:['NO_GOODS','IMG_SRC','NO_REQ','NM_REQ','쿠폰이미지','상품명','상품금액','유효기간','등록일']

			//mapping column
			,colModel:[
			          {name:'NO_GOODS',hidden:true}
			         ,{name:'IMG_SRC',hidden:true}
			         ,{name:'NO_REQ',width:10,align:'center',sortable:false}
			         ,{name:'NM_REQ',hidden:true}
			         ,{name:'GOODS_IMAGE',width:20,align:'center',formatter:fnMakeImg,sortable:false}
					 ,{name:'NM_GOODS',width:20,align:'center',sortable:false}
					 ,{name:'CPN_PRICE',width:10,align:'center',sortable:false}
					 ,{name:'DT_VALID',width:30,align:'center',sortable:false}
					 ,{name:'REG_DATE',width:15,align:'center',sortable:false}
			]
			, height:450
			, autowidth:true
			, onSelectRow: function(rowid){
				var selRow = $(this).getRowData(rowid);
				var data = {
						NO_REQ : selRow.NO_REQ,
						NM_REQ : selRow.NM_REQ,
						IMG_SRC : selRow.IMG_SRC,
						NM_GOODS : selRow.NM_GOODS,
						NO_GOODS : selRow.NO_GOODS
				}
				uxl.pushToParent(data);
				self.close();
			}
		};
	uxl.grid('list', options);
	
	fnSearch();
});

// 쿠폰 정보 조회
function fnSearch(){
	var data = {};
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

// 다우 상품 이미지 생성
function fnMakeImg(cellValue, rowObject, options){
	return '<img src="'+cellValue+'" width="100">';
}
</script>