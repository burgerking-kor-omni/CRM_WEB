<%--
#*
 *  파 일 명 :  EXP9009.jsp
 *  설    명 :  상세화면 페이지
 *  작 성 자 :  황민국
 *  작 성 일 :  
 *  버    전 :  1.0
 *  기타사항 :
 *  Copyrights 2011 by ㈜ 유비원. All right reserved.
*#
--%>
<%@page import="com.ubone.framework.util.MessageUtils"%>
<%@page import="com.ubone.framework.util.CodeUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="com.ubone.framework.util.ViewUtil"%>
<%@ include file="/WEB-INF/jsp/include/pageCommon.jsp"%>
<%@ page import="com.ubone.framework.data.DataList"%>
<%@ page import="com.ubone.framework.data.Parameter"%>
<%@ page import="com.ubone.framework.ConstantHolder"%>
<%@ page import="com.ubone.framework.ConfigHolder"%>
<%@ page import="java.util.Map"%>
<%@ page import="org.apache.commons.lang.StringUtils"%>
<%@ page import="com.ubone.ubmeta.page.util.JspUtils"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<script type="text/javascript">
	//uxl.onLoad(function(){
	$(document).ready(function() {

		$("#multiCombo").append("<option value='1'>예제1</option>");
		$("#multiCombo").append("<option value='2'>예제2</option>");
		$("#multiCombo").append("<option value='3'>예제3</option>");
		
		/* 임의로 데이터 삽입 */
		$("#combo, #combo2").append("<option value='01'>예제1</option>");
		$("#combo, #combo2").append("<option value='01'>예제2</option>");
		$("#combo, #combo2").append("<option value='01'>예제3</option>");


		// Jqgrid Draw
		var options = {
			//header name
			colNames : [ '제목', '결재처리구분', '상신자', '상신일시' ]
			//mapping column
			,
			colModel : [ {
				name : 'DS_TITLE_APPR',
				width : 152,
				align : 'left'
			} //제목
			, {
				name : 'TP_APPR_PROC',
				width : 40,
				align : 'center'
			} //결재처리구분
			, {
				name : 'NM_EMP_SUBMIT',
				width : 40,
				align : 'center',
				formatter : buttonSet
			} //상신자
			, {
				name : 'DT_SUBMIT',
				width : 52,
				align : 'center'
			} //상신일자
			]

			,
			autowidth : true,
			height : 270,
			onSelectRow : function(rowid) {
			}
		};
		uxl.grid('list', options);

		var newData = [ {
			"DS_TITLE_APPR" : "제목1",
			"TP_APPR_PROC" : "처리",
			"DT_SUBMIT" : "2017-02-01"
		}, {
			"DS_TITLE_APPR" : "제목1",
			"TP_APPR_PROC" : "처리",
			"DT_SUBMIT" : "2017-02-01"
		} ];

		for ( var i = 0; i < newData.length; i++) {
			$("#list").jqGrid('addRowData', i, newData[i]);
		}
	});

	function buttonSet() {
		var str = "<span class='ub-control button inner'><a href='#'>연락하기</a></span>";

		return str;
	}
</script>