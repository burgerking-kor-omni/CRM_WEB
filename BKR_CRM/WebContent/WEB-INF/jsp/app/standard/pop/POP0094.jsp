<%--
#*
 *  파 일 명 :  POP0094.jsp
 *  설    명 :  일괄 핀 발행 팝업
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
 
   - PAGE ID : POP0094R00
   - PAGE TYPE : META
 
  Copyright ⓒ UBONE Co., Ltd. All rights reserved.
 ========================================================================
--> 
<%
	DataList _dl_ = ViewUtil.getResult().getDataList("");
// .getString(0,"");

%>
<script type="text/javascript">
var rowid = 0;
uxl.onLoad(function(){
	// 매장 목록
	var	options = {
			//header name
			colNames:['ID_MEMBER','회원 ID','회원명']

			//mapping column
			,colModel:[
			          {name:'ID_MEMBER',hidden:true}
			         ,{name:'DS_EMAIL',width:20,align:'center'}
					 ,{name:'NM_MEMBER',width:20,align:'center'}
			]
			, height:100
			, autowidth:true
			, multiselect:true
		};
	uxl.grid('list', options);
	
	// 엔터키 입력 시 조회
	$('form').keydown(function() {
	    if (event.keyCode === 13) {
	        fnSearch();
	    }
	});
	
	fnSearchInfo();
});

// 쿠폰 정보 조회
function fnSearchInfo(){
	var url = uxl.getFunctionUrl('POP0091','INQUIRY');
	var option = {
			  data:{}
			, success:function(result){
				
				var row = result.getDataList(0).rows[0];
				
				$('#CD_COUPON_OBJ').html(row.CD_COUPON_OBJ);
				$('#NM_COUPON').html(row.NM_COUPON);
				$('#DT_EXPIRY').html(row.DT_EXPIRY);
				$('#CD_STATUS').html(row.CD_STATUS);
			}
			, async:true
	};
	uxl.callSubmitFunction('searchForm' , url , option );
}

//이메일로 사용자 찾기
function fnSearch(){
	
	if($("#DS_EMAIL_SEARCH").val() == ''){
		alert("이메일을 입력해 주세요.");
		return false;
	}
	
	$("#DS_EMAIL").val('');
	$("#NM_MEMBER").val('');
	$("#ID_MEMBER").val('');
	
	var url = uxl.getFunctionUrl('POP0093','INQUIRY');
	var option = {
			  data:{}
			, success:function(result){
				
				
				if(result.getDataList(0).rowCount < 1){
					alert('조회된 회원이 없습니다. 이메일을 확인해 주세요.');
					$("#DS_EMAIL_SEARCH").focus();
				}else{
					var row = result.getDataList(0).rows[0];
					
					$("#DS_EMAIL").val($("#DS_EMAIL_SEARCH").val());
					$("#NM_MEMBER").val(row.NM_MEMBER);
					$("#ID_MEMBER").val(row.ID_MEMBER);
				};
			}
			, async:true
	};
	uxl.callSubmitFunction('searchForm' , url , option );
}

function fnAdd(){
	if($('#DS_EMAIL').val() == ''){
		alert("검색된 회원이 없습니다. 다시 검색해주세요.");
		return;
	}
	var url = uxl.getFunctionUrl('POP0093','USERDEFINED1');
	var option = {
			  data:{}
			, success:function(result){
				fnAddList();
			}
			, async:true
	};
	uxl.callSubmitFunction('searchForm' , url , option );
}

// 발행 회원 추가
function fnAddList(){
	
	// 중복 검사
	var recs = $("#list").getRowData();
    var rows = recs.length;
    
    for (var i = rows - 1; i >= 0; i--) {
    	if(recs[i].ID_MEMBER == $('#ID_MEMBER').val()){
    		alert('이미 등록된 회원입니다.');
    		return ;
    	}
    }
    
 	// 발행 회원 목록에 추가
	rowid = rowid+1
	var rowdata = {
			  ID_MEMBER :  $("#ID_MEMBER").val()
			, DS_EMAIL :   $("#DS_EMAIL").val()
			, NM_MEMBER : $("#NM_MEMBER").val()
	} 
	$("#list").jqGrid("addRowData", rowid, rowdata);
}

// 발행 회원 삭제
function fnDel(){
	
	var recs = $("#list").jqGrid('getGridParam', 'selarrrow');
    var rows = recs.length;
    if(rows < 1){
    	alert("선택한 열이 없습니다.");
    	return false;
    }
    for (var i = rows - 1; i >= 0; i--) {
          $('#list').jqGrid('delRowData', recs[i]);
    }
}

//발행
function fnPublish(){
	var recs = $("#list").getRowData();
    var rows = recs.length;
	var ID_MEMBERS = [rows];
	var NM_MEMBERS = [rows];
	
	if(rows < 1){
		alert("추가된 회원이 없습니다.");
		return;
	}

    for (var i = rows - 1; i >= 0; i--) {
    	ID_MEMBERS[i] = recs[i].ID_MEMBER;
    	NM_MEMBERS[i] = recs[i].NM_MEMBER;
    }
	
	
	var url = uxl.getFunctionUrl(_SCREEN_ID,'EXECUTE');
	var option = {
			  data:{
				  	ID_MEMBERS : ID_MEMBERS
				  	, NM_MEMBERS : NM_MEMBERS
			  }
			, success:function(result){
				self.close();
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