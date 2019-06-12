<%--
#*
 *  파 일 명 :  APM0041.jsp
 *  설    명 :  다국어 리소스 데이터 상세 팝업 
 *  작 성 자 :  이창섭
 *  작 성 일 :  2016-09-23
 *  버    전 :  1.0
 *  기타사항 :
 *  Copyrights 2016 by ㈜ 유비원. All right reserved.
*# 
--%>
<%@page import="com.ubone.framework.util.ViewUtil"%>
<%@page import="com.ubone.framework.ConfigHolder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/include/pageCommon.jsp" %>
<%@ page import="com.ubone.framework.data.DataList"%>
<%
	DataList _dataList = null;		/* List Table default dataTable */
	
	String defaltLang 	= ConfigHolder.LOCALE_DEFAULT_LANGUAGE;
	boolean isMultiLang = ConfigHolder.LOCALE_USE_MULTI_LANGUAGE;
	String[] listLang 	= ConfigHolder.LOCALE_USE_LANGUAGE_CODE;
%>

<!-- layout-1 Start -->
<h1 class="ub-control title">다국어 상세 팝업</h1>
<div class="ub-layout details"><form id="detailForm" name="detailForm"><table class="ub-control table normal ">
<colgroup>
<col width="120px"/>
<col />
</colgroup>
<tbody>
<tr id="layout-1_1">
<th id="layout-1_1_1"><label class="ub-control label">ID</label></th>
<td id="layout-1_1_2">
	<input type=text  class="ub-control input-text "       value="${paramMap.RES_ID}"  readonly              style="text-align:left;width:95%;">
	<input type=hidden id="RES_ID" name="RES_ID"    value="${paramMap.RES_ID}">
	<input type="hidden" id="RES_TP" name="RES_TP" value="">
	<input type="hidden" id="TABLE_NM" name="TABLE_NM" value="${paramMap.TABLE_NM}">
	<input type="hidden" id="COLUMN_NM" name="COLUMN_NM" value="${paramMap.COLUMN_NM}">
</td>
</tr>
<tr id="layout-1_2">
<th id="layout-1_2_3"><label class="ub-control label">리소스명</label></th>
<td id="layout-1_2_4">
	<input type=text id="RES_NM" name="RES_NM" class="ub-control input-text "       value=""       style="text-align:left;width:79%;">
	<span class="ub-control button inner icon" id="btnMap">
    	<a href="#none" title="매핑"><span></span>매핑</a>
	</span>
</td>
</tr>
</tbody>
</table>

<table class="ub-control table normal " id="formTable">
<colgroup>
<col width="120px"/>
<col />
</colgroup>
<tbody>
</tbody>
</table>
 
</form>
</div>
<div class="ub-layout button bottom">
<span class="ub-control button bottom icon" id="save">
    <a href="#none" title="Save"><span class="ico-save"></span>수정</a>
</span>
<span class="ub-control button bottom icon" id="delete">
    <a href="#none" title="Delete"><span class="ico-save"></span>삭제</a>
</span>
</div>

<!-- layout-1 End -->

<script type="text/javascript">
var LANG_TPs = new Array();	// 다국어 코드 배열

<%
	for (int i = 0; i < listLang.length; i++) {
%>
		LANG_TPs.push('<%=listLang[i]%>');
<%
	}
%>

uxl.onLoad(function(){
	initScreen();

	$('#close').click(function(){
		uxl.close();
	});
	
	//수정
	$('#save').click(function(){
		fnUpdate();
	});
	
	//삭제
	$('#delete').click(function() {
		fnDelete();
	});
	
	// 조회
	fnSearch();
	
	// 자동맵핑 - 버튼
	$('#btnMap').click(function() {
		fnAutoMapping(true);
	});
	
	// 자동맵핑 - blur
	$('#RES_NM').blur(function() {
		fnAutoMapping();
	});
	
	// 엔터키 저장 이벤트
	for (var i = 0; i < LANG_TPs.length; i++) {
		$('#RES_NM_' + LANG_TPs[i]).keydown(function(event) {
			if(event.keyCode == '13') {
				fnUpdate();
			}
		});
	}
});

// 화면 초기화
function initScreen() {
	var trNo = $('#formTable').find('tr').length + 1;										// tr id용 시퀀스
	var tdNo = $('#formTable').find('th').length + $('#formTable').find('td').length + 1;	// th/td id용 시퀀스
	
	var html = '';		// 테이블 동적 생성을 위한 html
	for (var i = 0; i < LANG_TPs.length; i++) {
		html += '<tr id="layout-1_' + String(trNo) + '">';
		html += '<th id="layout-1_' + String(trNo) + '_' + String(tdNo) + '"><label class="ub-control label"             for="RES_NM_' + LANG_TPs[i] + '">' + LANG_TPs[i] + '</label></th>';
		tdNo++;
		html += '<td id="layout-1_' + String(trNo) + '_' + String(tdNo) + '"><input type=text  class="ub-control input-text " id="RES_NM_' + LANG_TPs[i] + '" name="RES_NM_' + LANG_TPs[i] + '"     style="width:95%;"   value=""></td>';
		tdNo++;
		html += '</tr>';
		trNo++;
	}
	
	$('#formTable').append(html);
}

// 조회
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
				var dt = result.getDataList(0);
				var rowCount = dt.rowCount;
				
				if (dt.rowCount > 0) {
					$('#RES_NM').val(dt.rows[0].MASTER_NM);
					$('#RES_TP').val(dt.rows[0].RES_TP);
					
					for (var i = 0; i < dt.rowCount; i++) {
						$('#RES_NM_' + dt.rows[i].LANG_TP).val(dt.rows[i].RES_NM);
					}
				}
				
			}
			, async:true
	};
	uxl.callSubmitFunction('detailForm' , url , option );
}

// 수정
function fnUpdate(){
	//필수정보 체크
	var url = uxl.getFunctionUrl(_SCREEN_ID,'MODIFY');
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
				if (opener._SCREEN_ID == 'APM0042') {
					opener.fnSearch();
				} else {
					if ($('#RES_TP').val() != 'T') {
						opener.uxl.reload();
					}
					
					var returnData = {
							RES_ID 	: $('#RES_ID').val()
						  , RES_NM	: $('#RES_NM').val()
					};
					uxl.pushToParent(returnData);
				}
				
				uxl.close();
			}
			, async:true
			/* , message : {
			    confirm : uxl.getMessage('@message.common.update.confirm'),
				success : uxl.getMessage('@message.common.update.success'),
				fail : uxl.getMessage('@message.common.update.fail')
			} */
	};
	uxl.callSubmitFunction('detailForm' , url , option );
}

// 삭제
function fnDelete() {
	var url = uxl.getFunctionUrl(_SCREEN_ID,'REMOVE');
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
				if (opener._SCREEN_ID == 'APM0042') {
					opener.fnSearch();
				} else {
					if ($('#RES_TP').val() != 'T') {
						opener.uxl.reload();
					}
					
					var returnData = {
							RES_ID 	: ''
						  , RES_NM	: ''
					};
					uxl.pushToParent(returnData);
				}
				
				uxl.close();
			}
			, async:true
			, message : {
			    confirm : uxl.getMessage('@message.common.delete.confirm'),
				success : uxl.getMessage('@message.common.delete.success'),
				fail : uxl.getMessage('@message.common.delete.fail')
			}
	};
	uxl.callSubmitFunction('detailForm' , url , option );
}

//자동맵핑
function fnAutoMapping(isForced) {
	if ($('#RES_NM').val() != '') {
		$('input').each(function() {
			var inputId = $(this).attr('id');
			if (typeof(inputId) == 'string') {
				var resNm = $('#RES_NM').val();
				if (inputId.substr(0, 7) == 'RES_NM_') {
					if (inputId.substr(7) == 'ko') {
						if ($(this).val() == '' || isForced) {
							$(this).val(resNm);
						}
					} else {
						if ($(this).val() == '' || isForced) {
							$(this).val('[' + inputId.substr(7) + '] ' + resNm);
						}
					}
				}
			}
		});
		
		$('#RES_NM_' + LANG_TPs[LANG_TPs.length - 1]).focus();
	}
}

</script>