<%--
#*
 *  파 일 명 :  VOC0001.jsp
 *  설    명 :  VOC 목록
 *  작 성 자 :  강현준
 *  작 성 일 :  2018.12.10
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
<%@ page import="com.ubone.standard.common.encrypto.IwtCrypt"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core"   prefix="c" %>


<!--  ========================================================================
  This page is generated with the UB-META™ ver4.0 
 
   - PAGE ID : VOC0001R00
   - PAGE TYPE : META
 
  Copyright ⓒ UBONE Co., Ltd. All rights reserved.
 ========================================================================
--> 
<style>
	.ui-jqgrid-bdiv tr { cursor : pointer; }
	.ui-jqgrid tr.jqgrow td { text-overflow: ellipsis;-o-text-overflow: ellipsis; }
	#exportListViewer { border-bottom: 1px solid; }
</style>
<script type="text/javascript">

uxl.onLoad(function(){
	// 체크박스 검색조건 유지
	var strChk = '${paramMap.strChk}';
	if(strChk != ''){
		$('input[name="CD_BIZ_CHNN"]').attr('checked',false);
		var strTemp = strChk.split('/');
		for(var i = 0; i < strTemp.length; i++ ){
			$('input[name="CD_BIZ_CHNN"][value="'+strTemp[i]+'"]').attr('checked',true);
		}
	}
	// 전화번호 숫자만
	$('#NO_PHONE_SEARCH').keyup(function(event){
		uxl.setInputMask($(this), "cellPhone");
	});
	
	// 코드 세팅
	uxl.bindComboCode('CD_VOC_STATUS','CD_VOC_STATUS',{emptyOption : '전체'});
// 	uxl.bindComboCode('CD_VOC_CAUSE','CD_VOC_CAUSE',{emptyOption : '전체'});
	uxl.bindComboCode('CD_ACT_CAUSE','CD_ACT_CAUSE',{emptyOption : '전체'});
	uxl.bindComboCode('CD_VOC_CAUSE_1','CD_VOC_CAUSE_1',{emptyOption : '전체'});
	uxl.chainCombo('CD_VOC_CAUSE_1', 'CD_VOC_CAUSE_2', 'CD_VOC_CAUSE_2', {emptyOption : '전체'});
	
	//발생매장 자동완성 기능
	uxl.autocomplete('STOR_NM', uxl.getFunctionUrl(_SCREEN_ID,'USERDEFINED1'),  {
		  minLength : 2
		, itemExtractor : function(row) {
										var item = {
													  id : row.STOR_CD
													, value: ''
													, label : '('+row.STOR_CD+') '+ row.STOR_NM
													, STOR_NM : row.STOR_NM
										};
			return item;
		}
  			, select: function(event, ui) {
				var stor_cd = ui.item.id ;
				var stor_nm = ui.item.STOR_NM
				$('#ID_STORE').val(stor_cd);
				$('#NM_STORE').val(stor_nm);
			}
	});
	
	//처리자 자동완성 기능
	uxl.autocomplete('NM_USER_SEARCH', uxl.getFunctionUrl(_SCREEN_ID,'USERDEFINED2'),  {
		  minLength : 2
		, itemExtractor : function(row) {
										var item = {
													  id : row.USER_ID
													, value: ''
													, label : '('+row.USER_ID+') '+ row.USER_NM
													, USER_NM : row.USER_NM
										};
			return item;
		}
  			, select: function(event, ui) {
				var user_id = ui.item.id ;
				var user_nm = ui.item.USER_NM
				$('#ID_USER').val(user_id);
				$('#NM_USER').val(user_nm);
			}
	});
	
	
	var options = {
		//header name
		colNames:['VOC번호','등록일시','발생일','등록채널','VOC유형'
		          ,'제목','회원구분','이름','연락처','이메일'
		          ,'매장','처리유형','처리상태','처리자','처리일시']

		//mapping column
		,colModel:[
				  {name:'ID_VOC', hidden:true}
				 ,{name:'DT_REG',width:16,align:'center'}
				 ,{name:'DT_VOC_REG',width:10,align:'center'}
				 ,{name:'BIZ_CHNN',width:10,align:'center', codeCategory:'CD_BIZ_CHNN'}
				 ,{name:'NM_VOC_CAUSE',width:12,align:'center'}

				 ,{name:'DS_TITLE',width:20,align:'center'}
				 ,{name:'FG_MEMBER',width:7,align:'center'}
				 ,{name:'NM_CUST',width:10,align:'center'}
				 ,{name:'NO_PHONE',width:12,align:'center'}
				 ,{name:'DS_EMAIL',width:20,align:'center'}

				 ,{name:'NM_STORE',width:10,align:'center'}
				 ,{name:'CD_ACT_CAUSE',width:8,align:'center' ,codeCategory:'CD_ACT_CAUSE'}
				 ,{name:'CD_STATUS',width:8,align:'center', codeCategory:'CD_VOC_STATUS'}
		         ,{name:'NM_ACT_EMP',width:7,align:'center'}
		         ,{name:'DT_VOC_ACT',width:10,align:'center'}
		]
		, height:435
		,autowidth:true
		,onSelectRow: function(rowid){
			var selectedRow = $(this).getRowData(rowid);
			uxl.moveLocation(uxl.getScreenURL('VOC0002')+ '?ID_VOC='+selectedRow.ID_VOC + '&pageid=VOC0001' );
		}
	};
	uxl.grid('list', options);

	fnSearch();	
		
	// 검색버튼 클릭시 조회
	$("#search").click(function(event){
		fnSearch();
	});
	
	// 입력폼 더블 클릭 시 값 초기화
	$('form').dblclick(function(e){
		e.target.value = "";
		$('#'+'ID'+e.target.id.substr(2)).val('');
	});
	
	// 전화번호 숫자만
	$('#NO_PHONE_SEARCH').keyup(function(event){
		uxl.setInputMask($(this), "cellPhone");
	});
		
	// 엔터키 입력 시 조회
	$('form').keydown(function() {
	    if (event.keyCode === 13) {
	        fnSearch();
	    }
	});
	
	// 등록버튼
	$('#registBtn').click(function(){
		uxl.moveLocation(uxl.getScreenURL('VOC0004')+"?pageid=VOC0001");
	});
	
	$('#excelBtn').click(function(){
		fnGetExcel();
	});
});

// 목록 조회
function fnSearch(){
	
	// 날짜 유효성 검사
	var dtStart = new Date($('#DT_REG_START').val());
	var dtEnd = new Date($('#DT_REG_END').val());

	// 시작일이 종료일보다 늦을때
	if(dtStart > dtEnd ){
		alert('등록일의 검색조건이 유효하지 않습니다.');
		return ;
	};

	// 날짜 유효성 검사
	dtStart = new Date($('#DT_ACT_START').val());
	dtEnd = new Date($('#DT_ACT_END').val());

	// 시작일이 종료일보다 늦을때
	if(dtStart > dtEnd ){
		alert('처리일의 검색조건이 유효하지 않습니다.');
		return ;
	};
	
	// VOC 유형 설정
	var cd_cause = $('#CD_VOC_CAUSE_2').val() == '' ?  $('#CD_VOC_CAUSE_1').val() : $('#CD_VOC_CAUSE_2').val();
	var chnn_size = $('input[name=CD_BIZ_CHNN]:checked').length;
	
	var data = {
				CD_VOC_CAUSE : cd_cause
				, BIZ_CHNN_SIZE : chnn_size
	};
	//필수정보 체크
	var url = uxl.getFunctionUrl(_SCREEN_ID,'INQUIRY');
	var option = {
			  data:$.extend(data, uxl.grid.getParam('list'))		
			, success:function(result){
				uxl.grid.init('list');
				uxl.grid.appendData('list' ,result , true );
			}
			, async:true
	};
	uxl.callSubmitFunction('searchForm' , url , option );
	
}

// 매장찾기 팝업
function fnSearchStore(){
	uxl.openWindow('POP0100'
					, uxl.getScreenURL('POP0100')
					, {width:'1000', height:'610'}
					, function(rdata){
						$('#NM_STORE').val(rdata.STOR_NM);
						$('#ID_STORE').val(rdata.STOR_CD);
					});
}

function fnSearchEmp(){
	uxl.openWindow('POP0001'
			, uxl.getScreenURL('POP0001')
			, {width:'1000', height:'610'}
			, function(rdata){
				$('#ID_USER').val(rdata.idUser);
				$('#NM_USER').val(rdata.nmUser);
			});
}


// 엑셀파일 추출하기 
function fnGetExcel() {
	
	if($('#DT_REG_START').val() == '' || $('#DT_REG_END').val() == ''){
		alert('엑셀 다운로드 시엔 등록일 조건이 필수입니다.\n등록일을 확인해주세요.');
		return;
	}
	
	// 날짜 유효성 검사
	var dtStart = new Date($('#DT_REG_START').val());
	var dtEnd = new Date($('#DT_REG_END').val());

	// 시작일이 종료일보다 늦을때
	if(dtStart > dtEnd ){
		alert('등록일의 검색조건이 유효하지 않습니다.');
		return ;
	}
	var dtStartLater = new Date($('#DT_REG_START').val());
	dtStartLater.addMonths(1);
	
	if(dtStartLater < dtEnd){
		dtStartLater.setDate(0);
		if(dtStart.getDate() != dtStartLater.getDate() && dtEnd.getDate() != 31){
			alert('등록일자의 최대 검색기간은 1개월입니다. 다시 입력해주세요.');
			return;
		};
	};

	// 날짜 유효성 검사
	dtStart = new Date($('#DT_ACT_START').val());
	dtEnd = new Date($('#DT_ACT_END').val());

	// 시작일이 종료일보다 늦을때
	if(dtStart > dtEnd ){
		alert('처리일의 검색조건이 유효하지 않습니다.');
		return ;
	};
	
	// VOC 유형 설정
	var cd_cause = $('#CD_VOC_CAUSE_2').val() == '' ?  $('#CD_VOC_CAUSE_1').val() : $('#CD_VOC_CAUSE_2').val();
	var chnn_size = $('input[name=CD_BIZ_CHNN]:checked').length;
	
	var data = {
				CD_VOC_CAUSE : cd_cause
				, BIZ_CHNN_SIZE : chnn_size
	};

	//필수정보 체크
	var url = uxl.getFunctionUrl(_SCREEN_ID, 'EXPORT');
	var option = {
		data : data
		,success : function(result) {
			fnSearchExcel(result);
		},
		async : true
	};
	uxl.callSubmitFunction('searchForm', url, option);
}
function fnSearchExcel(result) {
	
	var filelink = result.getResultKey();
	if ($('#exportListViewer').size() == 0) {
		$('<div id="exportListViewer"></div>').appendTo('body');
	}
	$('#exportListViewer')
			.dialog(
					{
						width : 460,
						title : 'Download Result',
						open : function(event, ui) {
							var tag = '';
							if (filelink == null) {
								tag = tag
										+ '<span>다운로드할 데이터가 존재하지 않습니다.</span>';
							} else {
								tag = tag
										+ '<span>아래의 다운로드 link를 클릭하시면 파일을 다운로드 받을 수 있습니다.</span>';
								tag = tag + '<br/><br/><ul>';
								for (var i = 0; i < filelink.length; i++) {
// 									var url = uxl.getContextURL('/file/view.do');
// 									url = uxl.addQueryToUrl(url,'filePath', filelink[i]);
									var url = uxl.getContextURL('/file/bkrDown.' + uxl.CONSTANT.URL_EXTENTION + '?fileId=' + filelink);
									tag = tag + '<li ><a href="' + url + '" target="_self" style="color:#B54444"> 다운로드 파일 '+ (i + 1) + ' </a></li>';
								}
								tag = tag + '</ul>';
							}

							$(this).html(tag);
						},
						close : function(event, ui) {
							$(this).remove();
						}
					})
			.style('css','border-bottom: 1px solid;');
}

</script>