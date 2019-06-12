<%--
#*
 *  파 일 명 :  SYS0158.jsp
 *  설    명 :  프로그램 사용 로그 목록 
 *  작 성 자 :  
 *  작 성 일 :  
 *  버    전 :  1.0
 *  기타사항 :
 *  Copyrights 2013 by ㈜ 유비원. All right reserved.
*# 
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.ubone.framework.util.ViewUtil"%>
<%@ include file="/WEB-INF/jsp/include/pageCommon.jsp"%>

<script type="text/javascript">
uxl.onLoad(function(){	
	/*
	그리드 옵션
	colNames : 그리드 Header 정보,
	colModel : 그리드 Contents 의 바인딩 정보
	*/	
	var options = {
		//header name
		colNames:['RUN_LOG_SN', 'ID', '이름', '사용 일자', '접속자 IP', '수행업무', '프로그램 경로']

		//mapping column
	  , colModel:[
		    {name:'RUN_LOG_SN',    hidden:true}
		  , {name:'USER_ID',       width:20, align:'center'}
		  , {name:'USER_NM',       width:15, align:'center'}
		  , {name:'RUN_DATETIME',       width:20, align:'center'}
		  , {name:'CLIENT_IP_ADDR',       width:20, align:'center'}
		  , {name:'FUNCTION_ALIAS_NAME',       width:15, align:'center'}
		  , {name:'MENU_FULL_NAME',       width:40, align:'center'}
		]
	  , autowidth:true
	  , multiselect:false
	  , height:300
	};
	
	uxl.grid('list', options);
	
	uxl.autocomplete('USER_NM', uxl.getFunctionUrl(_SCREEN_ID,'USERDEFINED1'), {
		minLength : 1,
		itemExtractor : function(row) {
			var item = {
				id : row.USER_NM,
				value : row.USER_ID,
				label : '[' + row.DEPT_NM + ']  ' + row.USER_NM
			};
			return item;
		},
		select: function(event, ui) {
			$("#USER_NM").val(ui.item.id);
			$("#USER_ID").val(ui.item.value);
			return false;
		}
	});	
	
	uxl.autocomplete('USER_ID', uxl.getFunctionUrl(_SCREEN_ID,'USERDEFINED1'), {
		minLength : 1,
		itemExtractor : function(row) {
			var item = {
				id : row.USER_NM,
				value : row.USER_ID,
				label : '[' + row.USER_ID + ']  ' + row.USER_NM
			};
			return item;
		},
		select: function(event, ui) {
			$("#USER_NM").val(ui.item.id);
			$("#USER_ID").val(ui.item.value);
			return false;
		}
	});	
	
	fnSearch();
	
	$("#btnSearch").click(function(){
		fnSearch();
	});
});

//조회
function fnSearch() {
	//필수정보 체크
	var url = uxl.getFunctionUrl(_SCREEN_ID, 'INQUIRY');
	var option = {
		data:uxl.grid.getParam('list')
		
	    /*
		 * 조회한 데이터를 그리드에 추가함.
		 * @param {String} 그리드로 변환할 테이블ID
		 * @param {Result} 조회된 데이터 객체 result
		 * @param {boolean} 데이터 추가시 기존데이터의 clear 여부
		 */
	  , success:function(result) {
			uxl.grid.appendData('list', result, true);
		}
	  , async:true
	};
	uxl.callSubmitFunction('searchForm', url, option);		
}

</script>