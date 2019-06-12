<%--
#*
 *  파 일 명 :  SYS0002.jsp
 *  설    명 :  코드 유형 목록
 *  작 성 자 :  안신용
 *  작 성 일 :  2013-05-09
 *  버    전 :  1.0
 *  기타사항 :
 *  Copyrights 2013 by ㈜ 유비원. All right reserved.
*# 
--%>
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
<%
	DataList _dataList = null;		/* List Table default dataTable */ 
	DataList _dl_CODE_TP = ViewUtil.getResult().getDataList("Code.CODE_TP");
%>


<script type="text/javascript">
uxl.onLoad(function(){
	/*
		그리드 옵션
		colNames : 그리드 Header 정보,
		colModel : 그리드 Contents 의 바인딩 정보
	*/
	var options = {
		//header name
		colNames:['코드유형ID','코드유형명','코드유형','상수등록여부','캐쉬여부','상태','상위코드','MAPPING여부','등록자','등록일시'] 
		
		//mapping column
		,colModel:[
		          {name:'CODE_CATEGORY_ID' ,width:100},
		          {name:'CODE_CATEGORY_NM',width:100},
		          {name:'CODE_TP',width:50 , codeCategory:'CODE_TP',align:'center'},
		          {name:'CONSTANT_REG_YN',width:50 , codeCategory:'FLAG_YN' ,align:'center'},
		          {name:'CACHE_YN',width:50 , codeCategory:'FLAG_YN' ,align:'center'},
		          {name:'STATUS',width:50, codeCategory:'STATUS' ,align:'center'},
		          {name:'CODE_CATEGORY_ID_UP',width:70},
		          {name:'MAPPING_YN',width:50 , codeCategory:'FLAG_YN' ,align:'center'},
		          {name:'USER_NM',width:50 ,align:'center'},
		          {name:'REG_DT',width:120 ,align:'center'}
		         ]
        ,autowidth:true
        /*
        ,loadComplete:function(){
	       	if(records = $(this).jqGrid('getGridParam','records') < 1){
        		fnSearch();
	       	}
        }*/
		, onSelectRow: function(rowid){
			var selectedRow = $(this).getRowData(rowid);
			uxl.moveLocation(uxl.getScreenURL('EXP9001') + '?CODE_CATEGORY_ID='+selectedRow.CODE_CATEGORY_ID);
		}
		,rowNum: 10
        ,height: 231
	};
	uxl.grid('list', options);
	
	//조회 이벤트
	$('#search').click(function(){
		uxl.grid.init('list');
		fnSearch();
	});
	
	//신규 등록
	$('#insertBtn').click(function(){
		uxl.moveLocation(uxl.getScreenURL('SYS0003'));
	});
	
	$(':text').keydown(function(event) {
		if(event.keyCode == '13') {
			$(this).val($(this).val().toUpperCase());
			$('#search').click();
		}
	});
	
	$('#CODE_TP').change(function(){
		$('#search').click();
	});
	
	uxl.grid.init('list');
	fnSearch();
	
	//엔터키 검색 전체적용
	$('#searchForm').keydown(function(event) {
		if(event.keyCode == '13') {
			fnSearch();
			return false;
		}
	});
});	
	//조회
	function fnSearch(){
		//필수정보 체크
		var url = uxl.getFunctionUrl(_SCREEN_ID,'INQUIRY');
		var option = {
				  data:{}
				, validator:function(data,targetForm){
						var returnVal = false;
						//필수항목체크
						if(uxl.checkRequiredFields(targetForm)){
							returnVal = true;
						}
						return returnVal;
				}
				/*
				 * 조회한 데이터를 그리드에 추가함.
				 * @param {String} 그리드로 변환할 테이블ID
				 * @param {Result} 조회된 데이터 객체 result
				 * @param {boolean} 데이터 추가시 기존데이터의 clear 여부
				 */
				, success:function(result){
					var dataSet = result.getDataList(0).rows;
					var rowCount = result.getDataList(0).rowCount;
					uxl.grid.appendData('list' ,result , true );
				}
				, async:true
		};
		uxl.callSubmitFunction('searchForm' , url , option );		
	}
</script>