<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.ubone.framework.util.ViewUtil"%>
<%@ page import="com.ubone.framework.data.DataList"%>
<%@ page import="com.ubone.framework.data.Parameter"%>
<%@ page import="com.ubone.framework.ConstantHolder"%>
<%@ page import="com.ubone.framework.ConfigHolder"%>
<%@ page import="java.util.Map"%>
<%@ page import="org.apache.commons.lang.StringUtils"%>
<%@ page import="com.ubone.ubmeta.page.util.JspUtils"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core"   prefix="c" %>
<%@ include file="/WEB-INF/jsp/include/pageCommon.jsp"%>
<%
	DataList _dataList = null;		/* List Table default dataTable */ 
%>


<!--  ========================================================================
  This page is generated with the UB-META™ ver4.0 
 
   - PAGE ID : ALM0001
   - PAGE TYPE : JSP
 
  Copyright ⓒ UBONE Co., Ltd. All rights reserved.
 ========================================================================
--> 
<div class="ub-page list ">

<!-- layout-1 Start -->
<h1 class="ub-control title">알리미 통보</h1>
<div class="ub-layout search">
    <span class="search-ltbg"></span>
    <span class="search-rtbg"></span>
    <span class="search-lbbg"></span>
    <span class="search-rbbg"></span>
<form id="searchForm"><table class="ub-control table normal ">
<colgroup>
<col />
<col />
<col />
<col />
</colgroup>
<tbody>
<tr id="layout-1_1">
<td id="layout-1_1_1"><label class="ub-control label">사원ID</label></td>
<td id="layout-1_1_2"><input type=text  class="ub-control input-text " id="USER_ID" name="USER_ID" style="text-align:left;width:100px;"></td>
<!-- <td id="layout-1_1_3"><label class="ub-control label">부서</label></td>
<td id="layout-1_1_4"><input type=text  class="ub-control input-text " style="text-align:left;width:100px;"></td> -->
</tbody>
</table>
 
<span class="ub-control button search" id="searchBtn">
<a href="#none" title="Search">검색</a>  
</span>
</form>

</div>
<div class="ub-control temp" style="border:2px solid gray;width:100%;height:300px;text-align:center;"><h3 style="padding-top:120px;">Grid Control</h3></div>
<table class="ub-control grid" id="list" name="list"></table> 
	
<div class="ub-layout pagging"><div class="ub-control temp" style="border:2px solid gray;width:100%;height:30px;text-align:center;"><h3 style="padding-top:3px;">Paging Navigation</h3></div>
<div class="ub-control pagging" for="list" formId="searchForm" function="fnSearch"></div>
</div>

</div>
<!-- layout-1 End -->

<input type="hidden"  id="LOGIN_ID"    name="LOGIN_ID"    />
<input type="hidden"  id="CLIENT_IP"   name="CLIENT_IP"   />
<input type="hidden"  id="CLIENT_PORT" name="CLIENT_PORT" />
<input type="hidden"  id="LOGIN_TOKEN" name="LOGIN_TOKEN" />


<!-- script start -->
<script type="text/javascript">

uxl.onLoad(function(){

	var options = {
		
		colNames:[ 
		           '사원 ID'
		          ,'성명'
		          ,'로그인 IP'
		          ,'로그인 PORT'
		          ,'전송'
		          ,'로그인 토큰'
		          ,'로그인 일시' 
		          ] 
		
		,colModel:[
		          {name:'LOGIN_ID', width:30 , align:'center'},
		          {name:'USER_NM' , width:30 , align:'center'},
		          {name:'CLIENT_IP' , width:50 , align:'center'},
		          {name:'CLIENT_PORT' ,width:20, align:'center'},
		          {name:'' ,width:20 ,formatter:setSendBtn, align:'center'},
		          {name:'LOGIN_TOKEN',width:50,hidden:true},
		          {name:'LOGIN_DT',width:30 , hidden:true}
		         ]
        ,autowidth:true
		,onSelectRow: function(rowid){
			// var selectedRow = $(this).getRowData(rowid);
			
		}
		,rowNum: 10
        ,height: 231
	};
	  
	uxl.grid('list', options);
	
	$('#USER_ID').dblclick(function(){   $(this).val(''); }); 
	
	$("#searchBtn").click(function(event){	
		fnSearch();
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
				, success:function(result){
				  uxl.grid.init('list');
				  uxl.grid.appendData( 'list' , result , true );
				}
				, async:true
		};
		uxl.callSubmitFunction('searchForm' , url , option );		
	}
	
	// 전송 버튼 생성
	function setSendBtn(cellValue, opts, rowObject) {
		
		var login_id    = rowObject.LOGIN_ID;
		var client_ip   = rowObject.CLIENT_IP;
		var client_port = rowObject.CLIENT_PORT;
		var login_token = rowObject.LOGIN_TOKEN;
		    
		var param = login_id + "\", \"" +  client_ip + "\", \"" +client_port +  "\", \"" + login_token;
		    
		var innerBtnHtml =  "<span class='ub-control button inner icon'>";    
		    innerBtnHtml += "<a title='전송' href='javascript:almSendPopUp(\"" + param + "\");' ><span></span>전송</a></span>" ;
		return innerBtnHtml; 
	    
	        
	}
	
	
	// 전송 팝업
	function almSendPopUp(login_id,client_ip,client_port,login_token ){
		// alert(login_id + client_ip+ client_port+ login_token);   
		// 타겟 대상 임시 초기화 
		$('#LOGIN_ID').val(login_id);
		$('#CLIENT_IP').val(client_ip);
		$('#CLIENT_PORT').val(client_port);
		$('#LOGIN_TOKEN').val(login_token);		
		  
		uxl.openWindow('PopUp', uxl.getScreenURL('ALM0002'),{width:770, height:310}, fnSendAlimy);
	}
	
	  
	// 메세지 전송 
	function fnSendAlimy(returnData) {
	
		var url = uxl.getFunctionUrl(_SCREEN_ID,'REGIST');
		var option = {
				  data:{
						 'CONTENTS'    : returnData.CONTENTS
						,'TITLE'       : returnData.TITLE
						,'URL'		   : returnData.URL 
						,'LOGIN_ID'    : $('#LOGIN_ID').val()
						,'CLIENT_IP'   : $('#CLIENT_IP').val()
						,'CLIENT_PORT' : $('#CLIENT_PORT').val()
						,'LOGIN_TOKEN' : $('#LOGIN_TOKEN').val()
					  
				  }
				, async:true
		};
		uxl.callFunction(url, option);		
		
	}
	
</script>
<!--./ script End -->

