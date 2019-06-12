<%--
#*
 *  파 일 명 :  VOC0004.jsp
 *  설    명 :  문의/클레임 등록 화면
 *  작 성 자 :  강현준
 *  작 성 일 :  2018.10.26
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
 
   - PAGE ID : VOC0004R00
   - PAGE TYPE : META
 
  Copyright ⓒ UBONE Co., Ltd. All rights reserved.
 ========================================================================
--> 

<%
// 	DataList _dl_vocdetail = ViewUtil.getResult().getDataList("VocManage.getVocDetail");

	
// 	String yn_privacy_agree 		= _dl_vocdetail.getString(0, "YN_PRIVACY_AGREE");          /* 개인정보수집동의여부 */
//     String yn_sensitive_agree       = _dl_vocdetail.getString(0, "YN_SENSITIVE_AGREE");        /* 민감정보수집동의여부 */
//     String yn_privacy_order_agree   = _dl_vocdetail.getString(0, "YN_PRIVACY_ORDER_AGREE");    /* 개인정보제3자제공동의여부 */
//     String yn_sensitive_order_agree = _dl_vocdetail.getString(0, "YN_SENSITIVE_ORDER_AGREE");  /* 민감정보제3자제공동의여부 */
%>

<script type="text/javascript">
var flag = 'Y';

uxl.onLoad(function(){
	
	$('#popupMember, #resetBtn').hide();
	$('input[name="YM_MEMBER"]').change(function(){
		var str = '<span class="ub-control button inner icon" id="popupMember" onclick="fnSearchMember()" style="display: inline-block;">    <a href="#none" title="검색"><span></span>검색</a></span>';
		if($(this).val() == 'Y'){
			$('#memberInfo #layout-1_1_2').append(str);
			$('#memberInfo input').attr('readonly',true).addClass('readonly');
			$('#memberInfo #layout-1_3').show();
		}else{
			if($('#memberInfo input[type!="radio"]').val() != ''){
				if(confirm('회원 정보를 초기화하시겠습니까?')){
					$('#memberInfo input[type!="radio"]').each(function(){
						$(this).val('');
					});
				}else{
					$('input[name="YM_MEMBER"][value="N"]').attr('checked',false);
					$('input[name="YM_MEMBER"][value="Y"]').attr('checked',true);
					return ;
				}
			}
			$('#popupMember').remove();
			$('#memberInfo input').attr('readonly',false).removeClass('readonly');
			$('#memberInfo #layout-1_3').hide();
		};
	});
	
	// 전화번호 숫자만
	$('#NO_PHONE').keyup(function(event){
		uxl.setInputMask($(this), "cellPhone");
	});
	
	//
	fnReset();
	
	// 코드 맴핑
	uxl.bindComboCode('PAYMENT_TYPE_SUB','PAYMENT_TYPE',{emptyOption : '선택안됨'});
	uxl.bindComboCode('CD_VOC_CAUSE_1','CD_VOC_CAUSE_1',{emptyOption : '선택안됨'});
	uxl.chainCombo('CD_VOC_CAUSE_1', 'CD_VOC_CAUSE_2', 'CD_VOC_CAUSE_2', {emptyOption : '선택안됨'});
	
	// 목록 버튼
	$('#list').click(function(){
		uxl.returnToList('VOC0001');
	});

	$('#img').click(function(){
		uxl.openWindow('POP0100', uxl.getScreenURL('POP0100'), {width:'1000', height:'650'}, fnSetStore);
	});
	
	$('#imgMenu').click(function(){
		uxl.openWindow(
				'PopupMenuList'
				, uxl.getScreenURL('POP0096')
				, {width:'800',height:'620'}
				, function(rdata){
					$('#MENU_CODE').val(rdata.MENU_CD);
					$('#MENU_NM').val(rdata.MENU_NM);
				})
	});
	
	//VOC유형 자동완성 기능
	uxl.autocomplete('NM_CAUSE', uxl.getFunctionUrl(_SCREEN_ID,'USERDEFINED1'),  {
		  minLength : 2
		, itemExtractor : function(row) {
			var item = {
				  id : row.CODE
				, value: ''
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
	
	
	//발생매장 자동완성 기능
	uxl.autocomplete('STOR_NM', uxl.getFunctionUrl('VOC0001','USERDEFINED1'),  {
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
				$('#STOR_CD').val(stor_cd);
				$('#NM_STORE').val(stor_nm);
			}
	});
	
	//메뉴명 자동완성 기능
	uxl.autocomplete('MENU_NAME', uxl.getFunctionUrl('MNG0003','USERDEFINED1'),  {
		  minLength : 2
		, itemExtractor : function(row) {
			var item = {
				  id : row.MENU_CD
				, value: ''
				, label : row.MENU_TYPE+'['+row.MENU_CD+'] '+row.MENU_NM
				, MAIN_CATEGORY_ID : row.MAIN_CATEGORY_ID
				, SUB_CATEGORY_ID  : row.SUB_CATEGORY_ID
				, MENU_NM : row.MENU_NM
			};
			return item;
		}
 		, select: function(event, ui) {
			var menu_cd = ui.item.id ;
			$('#MENU_CD').val(menu_cd);
			$('#MENU_CODE').val(menu_cd);
			$('#MENU_NM').val(ui.item.MENU_NM);
		}
	});

});

uxl.onLoadComplete(function(){
	$('#memberInfo #layout-1_3').hide();
});

// 등록 처리
function fnSave(){
	
	// voc 유형
	var cd_voc_cause = $('#CD_VOC_CAUSE_2').val();
	
	var fgMember = 'N';
	if($('#ID_MEMBER').val().length > 0){
		fgMember = 'Y';
	}
	
	var url = uxl.getFunctionUrl(_SCREEN_ID,'REGIST');
	var option = {
			  data:{
				    CD_VOC_CAUSE : cd_voc_cause
				  , FG_MEMBER : fgMember
			  }
			, validator:function(data,targetForm){
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
				 confirm : uxl.getMessage('@message.common.insert.confirm'),
				 success : uxl.getMessage('@message.common.insert.success'),
				 fail 	 : uxl.getMessage('@message.common.insert.fail')
			}
			, async:true
	};
	uxl.callSubmitFunction('detailForm' , url , option );
}

// 주문,회원 정보 조회
function fnSearch(orderNo){
	var url = uxl.getFunctionUrl(_SCREEN_ID,'INQUIRY');
	var option = {
			  data:{ORDER_NO : orderNo}
			, success:function(result){
				if(result.getDataList(0).rowCount > 0){
					
					$('#ORDER_INFO input[name!="ORDER_NO"]').attr('readonly',true);
					$('#memberInfo input').attr('readonly',true);
					$('#popupMember').remove();
					$('#PAYMENT_TYPE_SUB').attr('disabled',false);
					$('#FG_ORDER').val('Y');
					$('#popupDetail a').text('상세보기');
					$('#img, #imgMenu, #ORDER_INFO .ui-datepicker-trigger').hide();
					
					var row = result.getDataList(0).rows[0];
					
					$('#POS_ORDER_NO').val(row.POS_ORDER_NO);
					$('#CALL_ORDER_NO').val(row.CALL_ORDER_NO);
					$('#CD_STATUS').val(row.CD_STATUS);
					
					$('#ID_MEMBER').val(row.ID_MEMBER);
					$('#STOR_CD').val(row.STOR_CD);
// 					$('#STOR_NM').val('').hide();
					$('#STOR_NM').remove();
					$('#NM_STORE').val(row.STOR_NM).addClass('readonly',true);
					$('#PAYMENT_TYPE').val(row.PAYMENT_TYPE);
					$('#PAYMENT_TYPE_SUB').val(row.NM_PAYMENT_TYPE);
// 					$('#PAYMENT_TYPE_SUB').val(row.PAYMENT_TYPE).addClass('readonly',true).attr('disabled',true);

					$('#MENU_NM').val(row.ORDER_NM).addClass('readonly',true);
					$('#MENU_CD').val(row.MENU_CD).addClass('readonly',true);
					$('#MENU_CODE').val(row.MENU_CD);
// 					$('#MENU_NAME').val(row.MENU_NAME).addClass('readonly',true);
					$('#MENU_NAME').remove();
					$('#PAYMENT_PRC').val(uxl.setComma(row.PAYMENT_PRC)).addClass('readonly',true);
					$('#DT_ORDER').val(row.DT_ORDER).addClass('readonly',true);
					$('#NM_CUST').val(row.NM_MEMBER).addClass('readonly',true);
					$('#NO_PHONE').val(row.NO_PHONE).addClass('readonly',true);
					$('#DS_EMAIL').val(row.DS_EMAIL).addClass('readonly',true);
					
					$("input:radio[value='"+row.YN_MEMBER+"']").attr("checked",true);
					$("input:radio[name='YM_MEMBER']").attr('disabled',true);
					flag = 'N';
					$("#resetBtn").show();
					fnReset();
					
				}else{
					alert("일치하는 주문번호가 없습니다.");
				}
			}
			, async:true
	};
	uxl.callFunction( url , option );
}

// 상세보기 팝업
function fnShowDetail(){
	if($('#ORDER_NO').val().length == 0){
		alert('주문번호를 입력해주십시오.');
		return;
	}
	uxl.openWindow('POP1001'
				  , uxl.getScreenURL('POP1001')+"?ORDER_NO="+$('#ORDER_NO').val()+"&FLAG="+$('#FG_ORDER').val()
				  , {width:1100,height:760}
				  , function(rdata){
					  fnSearch(rdata.ORDER_NO);
				  });
}

// 매장찾기 콜백
function fnSetStore(rdata){
	$('#STOR_CD').val(rdata.STOR_CD);
	$('#NM_STORE').val(rdata.STOR_NM);
}

function fnReset() {
	if(flag == 'Y'){
		// 더블 클릭시 초기화
		$('input, textarea').dblclick(function(){
			if(this.id != 'BIZ_CHNN' && $('#FG_ORDER').val() == 'N' && this.id != 'BIZ_CHNN_NM'){
				$(this).val('');
				$('#'+this.id.substr(0,this.id.length-2)+'CD').val('');
				if(this.id == 'NM_STORE'){
					$('#STOR_CD').val('');
				}
				if(this.id == 'MENU_NM'){
					$('#MENU_CODE').val('');
				}
			};
		});
	}else{
		// 더블 클릭시 초기화
		$('#regInfo input, textarea').dblclick(function(){
			$(this).val('');
		});
	}
}

// 회원찾기
function fnSearchMember(){
	uxl.openWindow('POP0012', uxl.getScreenURL('POP0012'), {width:1300, height:650}, function(rdata){
		$('#ID_MEMBER').val(rdata.ID_MEMBER);
		$('#NM_CUST').val(rdata.NM_CUST);
		$('#NO_PHONE').val(rdata.NO_PHONE);
		$('#DS_EMAIL').val(rdata.DS_EMAIL);
	});
}
</script>