<%--
#*
 *  파 일 명 :  VOC0002.jsp
 *  설    명 :  VOC 상세
 *  작 성 자 :  강현준
 *  작 성 일 :  2018.10.18
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
 
   - PAGE ID : VOC0002R00
   - PAGE TYPE : META
 
  Copyright ⓒ UBONE Co., Ltd. All rights reserved.
 ========================================================================
--> 

<%
	DataList _dl_vocdetail = ViewUtil.getResult().getDataList("VocManage.getVocDetail");

	String fg_member				= _dl_vocdetail.getString(0, "FG_MEMBER");
// 	String yn_privacy_agree 		= _dl_vocdetail.getString(0, "YN_PRIVACY_AGREE");          /* 개인정보수집동의여부 */
//     String yn_sensitive_agree       = _dl_vocdetail.getString(0, "YN_SENSITIVE_AGREE");        /* 민감정보수집동의여부 */
//     String yn_privacy_order_agree   = _dl_vocdetail.getString(0, "YN_PRIVACY_ORDER_AGREE");    /* 개인정보제3자제공동의여부 */
//     String yn_sensitive_order_agree = _dl_vocdetail.getString(0, "YN_SENSITIVE_ORDER_AGREE");  /* 민감정보제3자제공동의여부 */
%>

<script type="text/javascript">

uxl.onLoad(function(){
	
// 	if($('#BIZ_CHNN_NM').val() == 'APP'||$('#BIZ_CHNN_NM').val() == 'WEB'){
// 		$('#layout-1_6').show();
// 	}else{
// 		$('#layout-1_6').hide();
// 	}
	
	// 코드 맴핑
	uxl.bindComboCode('CD_ACT_CAUSE', 'CD_ACT_CAUSE', {emptyOption:'선택안됨'});
// 	uxl.bindComboCode('PAYMENT_TYPE', 'PAYMENT_TYPE', {emptyOption:'선택안됨'});
	uxl.bindComboCode('CD_VOC_CAUSE_1','CD_VOC_CAUSE_1',{emptyOption : '선택안됨'});
	uxl.chainCombo('CD_VOC_CAUSE_1', 'CD_VOC_CAUSE_2', 'CD_VOC_CAUSE_2', {emptyOption : '선택안됨'});
	
	// 목록 버튼
	$('#list').click(function(){
		uxl.returnToList('VOC0001');
	});
	
	//자동완성 기능(내용유형)
	uxl.autocomplete('NM_CAUSE', uxl.getFunctionUrl('VOC0004','USERDEFINED1'),  {
		  minLength : 2
		, itemExtractor : function(row) {
										var item = {
													  value: ''
													, label : row.CAUSE1+' > '+row.CAUSE2
													, CAUSE1 : row.CD_CAUSE1
													, CAUSE2 : row.CD_CAUSE2
										};
			return item;
		}
  			, select: function(event, ui) {
  				var main = ui.item.CAUSE1 ;
  				var sub = ui.item.CAUSE2 ;
				
				$('#CD_VOC_CAUSE_1').val(main).change();
				$('#CD_VOC_CAUSE_2').val(sub).change();
			}
	});
	
	fnFileList();
});

uxl.onLoadComplete(function(){
	$('input[name="YN_MEMBER"][value="'+'<%=fg_member%>'+'"]').attr('checked',true);
	
	// 처리완료 시 수정불가 처리
	if($("#CD_STATUS").val() == '01'){
		$('.ub-layout.button.bottom').show();
		$('select').removeClass('readonly').removeAttr('disabled');
		$('.ui-datepicker-trigger').remove();
		$('#vocInfoDtl #layout-1_4').hide()
		$('#regInfo input[name!="NM_CAUSE"],#regInfo textarea').addClass('readonly').attr('disabled', true);
		
	}else{
		$('.ub-layout.button.bottom, #NM_CAUSE').hide();
		$('select, input, textarea').addClass('readonly').attr('disabled', true);
		$('.ui-datepicker-trigger').remove();
		$('#vocInfoDtl #layout-1_4').show();
	};
	if($('#ORDER_NO').val() == ''){
		$('#popupDetail').hide();		
	}
	$('#TXT_LABEL').addClass('txt-color01');
	
	$('input[name="FG_SEND"]').change(function(){
		if($(this).val() == 'Y'){
			$('#DS_DISPATCH_CONT').attr('metaessential',1);
			$('label[for="DS_DISPATCH_CONT"]').append('<span class="required">*</span>');
		}else{
			$('#DS_DISPATCH_CONT').attr('metaessential',0);
			$('label[for="DS_DISPATCH_CONT"] span').remove();
		}
	});
	
	if('<%=_dl_vocdetail.getString(0, "FG_SEND")%>' == 'Y'){
		$('input[name="FG_SEND"][value="Y"]').attr('checked',true);
	}else{
		$('input[name="FG_SEND"][value="N"]').attr('checked',true);
		$('#DS_DISPATCH_CONT').attr('metaessential',0);
		$('label[for="DS_DISPATCH_CONT"] span').remove();
	};
	
	$('form').dblclick(function(e){
		if(!$(e.target).is(':disabled') && !$(e.target).attr('readonly')){
			e.target.value = "";
		};
	});
	
	$('html').scrollTop(0);
});


//상세보기 팝업
function fnShowDetail(){
	if($('#ORDER_NO').val().length == 0){
		alert('주문번호를 입력해주십시오.');
		return;
	}
	uxl.openWindow('POP1001'
				  , uxl.getScreenURL('POP1001')+"?ORDER_NO="+$('#ORDER_NO').val()
				  , {width:1100,height:760}
				  , function(rdata){
					  fnSearch(rdata.ORDER_NO);
				  });
}

// 수정 처리
function fnSave(){
	//필수정보 체크
	var url = uxl.getFunctionUrl(_SCREEN_ID,'MODIFY');
	var option = {
			  data:{CD_VOC_STATUS : '01'}
			, success:function(result){
				uxl.reload();
				$('html').scrollTop(0);
			}
			, message : {
				 confirm : uxl.getMessage('@message.common.insert.confirm'),
				 success : uxl.getMessage('@message.common.insert.success'),
				 fail 	 : uxl.getMessage('@message.common.insert.fail')
			}
			, async:true
	};
	uxl.callSubmitFunction('detailForm' , url , option );
}

// 완료 함수
function fnComplete(){
	//필수정보 체크
	var url = uxl.getFunctionUrl(_SCREEN_ID,'COMPLETE');
	var option = {
			  data:{CD_VOC_STATUS : '02'}
			,  validator:function(data,targetForm){
				var returnVal = false;
				//필수항목체크
				if(uxl.checkRequiredFields(targetForm)){
						returnVal = true;
				}
				return returnVal;
			}
			, success:function(result){
				uxl.returnToList('${paramMap.pageid}');
			}
			, message : {
				 confirm : uxl.getMessage('@message.common.confirm','완료'),
				 success : uxl.getMessage('@message.common.success','완료'),
				 fail 	 : uxl.getMessage('@message.common.fail','완료')
			}
			, async:true
	};
	uxl.callSubmitFunction('detailForm' , url , option );
}

// 삭제
function fnDel(){
	//필수정보 체크
	var url = uxl.getFunctionUrl(_SCREEN_ID,'REMOVE');
	var option = {
			  data:{}
			, success:function(result){
				uxl.returnToList('VOC0001');
			}
			, message : {
				 confirm : uxl.getMessage('@message.common.delete.confirm'),
				 success : uxl.getMessage('@message.common.delete.success'),
				 fail 	 : uxl.getMessage('@message.common.delete.fail')
			}
			, async:true
	};
	uxl.callSubmitFunction('detailForm' , url , option );
}

function fnFileList(){
	//필수정보 체크
	var url = uxl.getFunctionUrl(_SCREEN_ID,'USERDEFINED1');
	var option = {
			  data:{}
			, success:function(result){
				var rowdata = result.getDataList(0);
				if(rowdata.rowCount > 0){
					for(var i = 0; i < rowdata.rowCount; i++){
						var fileUrl = uxl.getContextURL('/file/bkrDown.' + uxl.CONSTANT.URL_EXTENTION + '?fileId=' + rowdata.rows[i].FILE_KEY);
						var innerHtml = "<a title='다운로드' href='" + fileUrl + "' ><span></span>" + rowdata.rows[i].FILE_NM + "</a></span><br /><br />" ;
// 						var innerHtml = "<a title='다운로드' href='javascript:fnFile(\"" + rowdata.rows[i].FILE_KEY + "\", \"" + rowdata.rows[i].FILE_NM + "\");' ><span></span>" + rowdata.rows[i].FILE_NM + "</a></span><br /><br />" ;
						$('#regInfo #layout-1_6_14').append(innerHtml);
					}
				}
				
			}
			, async:true
	};
	uxl.callSubmitFunction('detailForm' , url , option );
}

function fnFile(fileKey, fileNm) {
	//필수정보 체크
	var url = uxl.getFunctionUrl(_SCREEN_ID,'USERDEFINED2');
	var option = {
			  data:{'FILE_KEY':fileKey, 'FILE_NM':fileNm}
			, success:function(result){
				
			}
			, async:true
	};
	uxl.callSubmitFunction('detailForm' , url , option );
}
</script>