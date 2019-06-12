<%--
#*
 *  파 일 명 :  SYS0160.jsp
 *  설    명 :  개인정보 조회로그 목록 
 *  작 성 자 :  강현준
 *  작 성 일 :  2018.12.13
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
	var options = {
		//header name
		colNames:['NO_LOG', 'ID', '이름', '조회일자', '접속자 IP', '화면ID', '화면명']

		//mapping column
	  , colModel:[
		    {name:'',    hidden:true}
		  , {name:'USER_ID',       width:20, align:'center'}
		  , {name:'USER_NM',       width:15, align:'center'}
		  , {name:'DT_VIEW',       width:20, align:'center'}
		  , {name:'ID_ADDR',       width:20, align:'center'}
		  , {name:'SCREEN_ID',       width:15, align:'center'}
		  , {name:'SCREEN_NAME',       width:40, align:'center'}
		]
	  , autowidth:true
	  , multiselect:false
	  , height:300
	};
	
	uxl.grid('list', options);
	
	uxl.autocomplete('USER_NM', uxl.getFunctionUrl('SYS0158','USERDEFINED1'), {
		minLength : 2,
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
	
	uxl.autocomplete('USER_ID', uxl.getFunctionUrl('SYS0158','USERDEFINED1'), {
		minLength : 2,
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
	
	// 입력폼 더블 클릭 시 값 초기화
	$('form').dblclick(function(e){
		e.target.value = "";
	});
	
	// 엔터키 입력 시 조회
	$('form').keydown(function() {
	    if (event.keyCode === 13) {
	        fnSearch();
	    }
	});
	
	$("#btnSearch").click(function(){
		fnSearch();
	});
});

uxl.onLoadComplete(function(){
	$('#DT_VIEW_START').val($('#DT_VIEW_START').val()+'-01');
	fnSearch();
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