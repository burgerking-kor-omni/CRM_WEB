<%--
#*
 *  파 일 명 :  APM0040.jsp
 *  설    명 :  다국어 리소스 데이터 등록 팝업 
 *  작 성 자 :  강영운
 *  작 성 일 :  2016-09-22
 *  버    전 :  1.0
 *  기타사항 :
 *  Copyrights 2011 by ㈜ 유비원. All right reserved.
*# 
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/include/pageCommon.jsp" %>
<%@ page import="com.ubone.framework.data.DataList"%>
<%@ page import="com.ubone.framework.ConfigHolder"%>
<%
	DataList _dataList = null;		/* List Table default dataTable */ 
	
	String defaltLang 	= ConfigHolder.LOCALE_DEFAULT_LANGUAGE;
	boolean isMultiLang = ConfigHolder.LOCALE_USE_MULTI_LANGUAGE;
	String[] listLang 	= ConfigHolder.LOCALE_USE_LANGUAGE_CODE;
%>

<!-- layout-1 Start -->
<h1 class="ub-control title">다국어 등록 팝업</h1>
<div class="ub-layout details"><form id="detailForm" name="detailForm"><table class="ub-control table normal ">
<colgroup>
<col width="120px"/>
<col />
</colgroup>
<tbody>
<tr id="layout-1_1">
<th id="layout-1_1_1"><label class="ub-control label" for="RES_ID">리소스ID</label></th>
<td id="layout-1_1_2">
	<input type=text id="RES_ID" name="RES_ID" class="ub-control input-text" readonly value="${paramMap.RES_ID}" style="text-align:left;width:95%;" metaessential="1">
	<input type="hidden" id="RES_TP" name="RES_TP" value="${paramMap.TYPE}">
	<input type="hidden" id="PARENT_ID" name="PARENT_ID" value="${paramMap.PARENT_ID}">
	<input type="hidden" id="TABLE_NM" name="TABLE_NM" value="${paramMap.TABLE_NM}">
	<input type="hidden" id="COLUMN_NM" name="COLUMN_NM" value="${paramMap.COLUMN_NM}">
</td>
</tr>
<tr id="layout-1_2">
<th id="layout-1_2_3"><label class="ub-control label" for="RES_NM">리소스명</label></th>
<td id="layout-1_2_4">
	<input type=text id="RES_NM" name="RES_NM" class="ub-control input-text "       value=""       style="text-align:left;width:79%;" metaessential="1">
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
    <a href="#none" title="Save"><span class="ico-save"></span>저장</a>
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
	$('#save').click(function(event){
		fnSave();
	});
	
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
				fnSave();
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
	
	// 리소스 타입에 따른 화면 컨트롤
	var type = uxl.isNotEmpty($('#RES_TP').val())?$('#RES_TP').val():"U";
	
	// 리소스 관리 화면에서 신규 등록일 경우 RES_ID input의 readonly 해제
	if ('${paramMap.isNew}' == 'Y') {
		$('#RES_ID').removeClass('readonly').removeAttr('readonly');
	}
	
	if (type == 'T') {
		$('#RES_ID').val('자동생성');
		
	} else if (type == 'M'){
		$('#RES_ID').hide();
		
		var inputHtml = '';
		inputHtml += '<input type=text id="RES_ID_1" name="RES_ID_1" class="ub-control input-text" value="message" style="text-align:left;width:15%;" readonly>';
		inputHtml += '<label class="ub-control label">.</label>';
		inputHtml += '<input type=text id="RES_ID_2" name="RES_ID_2" class="ub-control input-text" value="" style="text-align:left;width:20%;">';
		inputHtml += '<label class="ub-control label">.</label>';
		inputHtml += '<input type=text id="RES_ID_3" name="RES_ID_3" class="ub-control input-text" value="" style="text-align:left;width:39%;">';
		
		$('#RES_ID').before(inputHtml);
	}
	
	// 리소스 타입에 따른 Validation 체크
	fnValidationCheck(type);
	
	// 리소스명 바인딩
	$('#RES_NM').val(unescape('${paramMap.TEXT}'));
}

// 등록
function fnSave(){
	//필수정보 체크
	var url = uxl.getFunctionUrl(_SCREEN_ID,'REGIST');
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
				if (opener._SCREEN_ID == 'SYS0032') {
					opener.fnSearch();
				} else {
					if ($('#RES_TP').val() != 'T') {
						opener.uxl.reload();
					}
					
					var returnData = {
							RES_ID 	: result.getResultKey()
						  , RES_NM	: $('#RES_NM').val()
					};
					uxl.pushToParent(returnData);
				}
				
				uxl.close();
			}
			, async:true
			/* , message : {
			    confirm : uxl.getMessage('@message.common.insert.confirm'),
				success : uxl.getMessage('@message.common.insert.success'),
				fail : uxl.getMessage('@message.common.insert.fail')
			} */
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

// 벨리데이션 체크
function fnValidationCheck(type) {
	if (type == 'M') {
		$('#RES_ID_1, #RES_ID_2, #RES_ID_3').blur(function() {
			var $resId_1 = $('#RES_ID_1');
			var $resId_2 = $('#RES_ID_2');
			var $resId_3 = $('#RES_ID_3');
			
			// 정규식 체크
			var regExp = /^[a-zA-Z]{3}$|^[a-zA-Z]{3}[0-9]{4}$|^common$/;
			
			if (regExp.test($resId_2.val())) {
				// 대문자로 변경 - common이 아닐 경우만
				if ($resId_2.val() != 'common') {
					$resId_2.val($resId_2.val().toUpperCase());
				}
				
				// 아이디 값 병합
				$('#RES_ID').val($resId_1.val() + '.' + $resId_2.val() + '.' + $resId_3.val());
			} else {
				alert(uxl.getMessage('@message.APM.resource.id.validation.M-type'));
				$resId_2.focus();
				return false;
			}
		});
	} else if (type == 'U') {
		
		if ('${paramMap.isNew}' != 'Y') { // 리소스 관리 화면에서 신규 등록일 경우는 RES_ID 값 validation 체크 제외
			var resIds = $('#RES_ID').val().split('.');
			
			if (resIds[0] == 'label') {
				// 정규식 체크
				var regExp = /^[a-zA-Z]{3}$|^[a-zA-Z]{3}[0-9]{4}$|^common$/;
				
				if (!regExp.test(resIds[1])) {
					alert(uxl.getMessage('@message.APM.resource.id.validation.U-type'));
					uxl.close();
				}
			} else if (resIds[0] == 'button') {
				// 정규식 체크
				var regExp = /^[a-zA-Z]{3}$|^[a-zA-Z]{3}[0-9]{4}$|^common$/;
				
				if (!regExp.test(resIds[1])) {
					alert(uxl.getMessage('@message.APM.resource.id.validation.U-type'));
					uxl.close();
				}
			} else if (resIds[0] == 'title') {
				// 정규식 체크
				var regExp = /^[a-zA-Z]{3}[0-9]{4}$/;
				
				if (!regExp.test(resIds[1])) {
					alert(uxl.getMessage('@message.APM.resource.id.validation.U-type'));
					uxl.close();
				}
			} else {
				alert(uxl.getMessage('@message.APM.resource.id.validation.U-type'));
				uxl.close();
			}
		}
		
	} else if (type == 'T') {
		if (uxl.isEmpty($('#TABLE_NM').val()) || uxl.isEmpty($('#COLUMN_NM').val())) {
			alert(uxl.getMessage('@message.APM.resource.id.validation.T-type'));
			uxl.close();
		}
	}
}
</script>