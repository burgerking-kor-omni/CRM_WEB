<%--
#*
 *  파 일 명 :  SYS0157.jsp
 *  설    명 :  사용자 접속 로그 목록 
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
		colNames:['LOG_ID', 'ID', '이름', '부서/지점', '로그인 IP', '최근접속일시']

		//mapping column
	  , colModel:[
		    {name:'LOG_ID',    hidden:true}
		  , {name:'LOGIN_ID',       width:15, align:'center'}
		  , {name:'USER_NM',       width:15, align:'center'}
		  , {name:'DEPT_NM',       width:15, align:'center'}
		  , {name:'LOGIN_IP',       width:15, align:'center'}
		  , {name:'LOGIN_DT',       width:20, align:'center'}
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
				label : '[' + row.DEPT_NM + ']  ' + row.USER_NM
			};
			return item;
		},
		select: function(event, ui) {
			$("#USER_NM").val(ui.item.id);
			return false;
		}
	});	
	
	fnSearch();
	
	$("#btnSearch").click(function(){
		fnSearch();
	});
	
	$('#USER_NM').dblclick(function(event) {
		$('#USER_NM').val('');	
	});
	
	$('#USER_NM').keydown(function(event) {
		if(event.keyCode == '13') {
			fnSearch();
			return false;
		}
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