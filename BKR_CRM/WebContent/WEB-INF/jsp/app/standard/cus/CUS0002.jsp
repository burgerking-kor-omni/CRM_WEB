<%--
#*
 *  파 일 명 :  CUS0002.jsp
 *  설    명 :  고객 상세
 *  작 성 자 :  강현준
 *  작 성 일 :  2018.06.20
 *  버    전 :  1.0
 *  기타사항 :
 *  Copyrights 2011 by ㈜ 유비원. All right reserved.
*#
--%>
<%@page import="com.ubone.framework.util.ViewUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/include/pageCommon.jsp"%>
<%@ page import="com.ubone.framework.data.DataList"%>
<%@ page import="com.ubone.framework.data.Parameter"%>
<%@ page import="com.ubone.framework.ConstantHolder"%>
<%@ page import="com.ubone.standard.common.constant.AuthConstantHolder"%>
<%@ page import="com.ubone.framework.ConfigHolder"%>
<%@ page import="org.apache.commons.lang.StringUtils"%>
<%@ page import="com.ubone.ubmeta.page.util.JspUtils"%>
<%@ page import="com.ubone.framework.util.UserUtil"%>
<%@ page import="com.ubone.framework.engine.domain.User"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%
	DataList _dl_cust = ViewUtil.getResult().getDataList( "customerDAO.getCustDetail" );
	//유저정보
	User user 			 = UserUtil.getLoginUser();
	Boolean hasAdminRole = false;
	
	//관리자 권한(시스템관리자, 전체관리자, 고객서비스 팀장, VOC관리자)
	if(user.hasRole(AuthConstantHolder.ROLE_SYSTEM_ADMIN) || user.hasRole(AuthConstantHolder.ROLE_NORMAL_ADMIN) 
		|| user.hasRole(AuthConstantHolder.ROLE_VOC_ADMIN)){
		hasAdminRole = true;
	}
%>

<script type="text/javascript" charset="UTF-8" src="<spring:url value='/uxl/tab/uxl-tab-1.3.0.js'/>"></script>
<script type="text/javascript">

var hasRole = <%=hasAdminRole%>;

uxl.onLoad(function(){
	
	if(!hasRole){
		$('.ub-layout.button.inner').hide();
	}else{
		$('.ub-layout.button.inner').show();
	}
	
	uxl.bindComboCode('CD_GRADE', 'CD_GRADE', {emptyOption : '선택안됨'});
	uxl.bindComboCode('YN_EMAIL_RECV', 'FLAG_YN', {emptyOption : '선택안됨'});
	uxl.bindComboCode('YN_SMS_RECV', 'FLAG_YN', {emptyOption : '선택안됨'});
	uxl.bindComboCode('CD_STATUS', 'CD_STATUS', {emptyOption : '선택안됨'});
	uxl.bindComboCode('CD_GENDER', 'CD_GENDER', {emptyOption : '선택안됨'});
	uxl.bindComboCode('CD_JOIN_SITE', 'CD_JOIN_SITE', {emptyOption : '선택안됨'});		
	uxl.bindComboCode('CD_JOIN_PATH', 'ORDER_CHN', {emptyOption : '선택안됨'});
	
	uxl.bindComboCode('YN_SLEEP', 'FLAG_YN', {emptyOption : '선택안됨'});
	uxl.bindComboCode('YN_PRIVACY_AGREE', 'FLAG_YN', {emptyOption : '선택안됨'});
	uxl.bindComboCode('YN_CONFIRM', 'FLAG_YN', {emptyOption : '선택안됨'});
	uxl.bindComboCode('YN_BKR_AGREE', 'FLAG_YN', {emptyOption : '선택안됨'});

	var options = {
		//header name
		colNames:['카드번호','보유금액','최근사용일','발급일','해지여부']

		//mapping column
		,colModel:[
				  {name:'NO_CARD',width:10,align:'center'}
				 ,{name:'VAL_AMOUNT',width:20,align:'center'}
		         ,{name:'DT_UPT', width:15,align:'center'}
		         ,{name:'DT_REG', width:15,align:'center'}
		         ,{name:'', width:10,align:'center'}
		]
		, height:100
		,autowidth:true
	};
	uxl.grid('list_card', options);
		
	// 목록버튼 클릭시
	$('#listBtn').click(function(){
		uxl.returnToList('CUS0001');
	});

	// 기안취소버튼 클릭시
	$('#fnSearch').click(function(){
		uxl.openWindow('PopupAddr', uxl.getScreenURL('POP0003'), {width:'1024px',height:'720px'}, callbackAddr);
	});
	$('#fnSearch_job').click(function(){
		uxl.openWindow('PopupAddr_job', uxl.getScreenURL('POP0003'), {width:'1024px',height:'720px'}, callbackAddr_job);
	});
	
	$('#addbtn').click(function(){
		uxl.openWindow('Popup_relation', uxl.getScreenU, option, listner)
	});

	$('#updBtn').click(function(){
		if(confirm("수정하시겠습니까?")){
			uxl.reload();
		}
	});
	
// 	$("#delBtn").hide();
	// 회원탈퇴 처리
	$("#delBtn").click(function(){
		fnDelete();
	});
	
	
	
	fnTabgen();
	fnSetPhone();
			
	$('select').attr('disabled',true).addClass('readonly');
	$("html").scrollTop(0);
	// 선불 카드이력 숨김
	$('#cardLayout').hide();
// 	fnSearch_card();
	
});

uxl.onLoadComplete(function(){
	$('#DS_ADDR').attr('size',$('#DS_ADDR').val().length);
	$('#DS_ADDR_DTL').attr('size',$('#DS_ADDR_DTL').val().length);
});

// 선불카드 리스트 조회
function fnSearch_card() {
	//필수정보 체크
	var url = uxl.getFunctionUrl(_SCREEN_ID, 'INQUIRY');
	var option = {
		  data : {}
		, success : function(result) {
			uxl.grid.appendData('list_card', result, true);
		}
		, async : true
	};
	uxl.callSubmitFunction('detailForm' , url , option );
}

// 비밀번호 초기화
function fnResetPasswd(){
	//필수정보 체크
	var url = uxl.getFunctionUrl(_SCREEN_ID, 'INQUIRY');
	var option = {
		data : {ID_MEMBER : $("#ID_MEMBER").val()},
		success : function(result) {
		}
		,async : true
		, message : {
			 confirm : uxl.getMessage('@message.common.change.passwd'),
			 success : uxl.getMessage('@message.common.update.success'),
			 fail 	 : uxl.getMessage('@message.common.update.fail')
		}
	};
	uxl.callFunction( url , option );
}

// 회원 탈퇴
function fnDelete(){
	//필수정보 체크
	var url = uxl.getFunctionUrl(_SCREEN_ID, 'REMOVE');
	var option = {
		data : {ID_MEMBER : $("#ID_MEMBER").val()},
		success : function(result) {
				uxl.returnToList('CUS0001');
		}
		, async : true
		, message : {
			 confirm : uxl.getMessage('@message.common.confirm','탈퇴'),
			 success : uxl.getMessage('@message.common.success','탈퇴'),
			 fail 	 : uxl.getMessage('@message.common.fail','탈퇴')
		}
	};
	uxl.callFunction( url , option );
}

function callbackAddr(addrData) {
	$('#ID_ADDR').val(addrData.id_zip_jibun);
	$('#DS_ADDR').val(addrData.addr_jibun);
	$('#DS_ADDR_DTL').val(addrData.addr2_jibun);
}
function callbackAddr_job(addrData) {
	$('#ID_ADDR_JOB').val(addrData.id_zip_jibun);
	$('#DS_ADDR_JOB').val(addrData.addr_jibun);
	$('#DS_ADDR_DTL_JOB').val(addrData.addr2_jibun);
}


function fnTabgen(){
	var tab = new uxl.Tabs('tabs',{maxTabs:20});
	var param = "";
	tab.add('CUS0011', '<%=request.getContextPath()%>' + '/screen/CUS0011.ub' + param, '정보변경이력', false);
	tab.add('CUS0012', '<%=request.getContextPath()%>' + '/screen/CUS0012.ub' + param, '진행중 주문', false);
	tab.add('CUS0013', '<%=request.getContextPath()%>' + '/screen/CUS0013.ub' + param, '완료 주문이력', false);
	tab.add('CUS0014', '<%=request.getContextPath()%>' + '/screen/CUS0014.ub' + param, '주문상품이력', false);
	tab.add('CUS0015', '<%=request.getContextPath()%>' + '/screen/CUS0015.ub' + param, '주문매장이력', false);
	tab.add('CUS0016', '<%=request.getContextPath()%>' + '/screen/CUS0016.ub' + param, '구매방법이력', false);
	tab.add('CUS0017', '<%=request.getContextPath()%>' + '/screen/CUS0017.ub' + param, '구매채널이력', false);
	tab.add('CUS0018', '<%=request.getContextPath()%>' + '/screen/CUS0018.ub' + param, '쿠폰사용이력', false);
	tab.add('CUS0019', '<%=request.getContextPath()%>' + '/screen/CUS0019.ub' + param, '스템프이력', false);
	tab.add('CUS0020', '<%=request.getContextPath()%>' + '/screen/CUS0020.ub' + param, '보유쿠폰', false);
<%-- 	tab.add('CUS0021', '<%=request.getContextPath()%>' + '/screen/CUS0021.ub' + param, '선물함', false); --%>
<%-- 	tab.add('CUS0022', '<%=request.getContextPath()%>' + '/screen/CUS0022.ub' + param, '선불카드이력', false); --%>
}

// 전화번호 
function fnSetPhone(){
	var str = $('#NO_PHONE').val();
	var temp = '';
	if(str.length == 11){
		temp = str.substr(0,3)+'-';
		temp += str.substr(3,4)+'-';
		temp += str.substr(7,4);
		$('#NO_PHONE').val(temp);
	}else if(str.length == 10){
		temp = str.substr(0,3)+'-';
		temp += str.substr(3,3)+'-';
		temp += str.substr(6,4);
		$('#NO_PHONE').val(temp);
	}else if(str.length == 9){
		temp = str.substr(0,3)+'-';
		temp += str.substr(2,3)+'-';
		temp += str.substr(6,4);
		$('#NO_PHONE').val(temp);
	}
}

// 스탬프 추가 팝업
function fnAddStamp(){
	uxl.openWindow('POP0101', uxl.getScreenURL('POP0101')+'?ID_MEMBER='+$('#ID_MEMBER').val(), {width:'500px',height:'150px'}, function(){uxl.reload();});
}

</script>