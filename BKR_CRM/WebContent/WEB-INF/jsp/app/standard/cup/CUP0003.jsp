<%--
#*
 *  파 일 명 :  CUP0003.jsp
 *  설    명 :  쿠폰 마스터 상세
 *  작 성 자 :  강현준
 *  작 성 일 :  2018-11-15
 *  버    전 :  1.0
 *  기타사항 :
 *  Copyrights 2011 by ㈜ 유비원. All right reserved.
*# 
--%>
<%@page import="com.ubone.framework.data.DataList"%>
<%@page import="com.ubone.framework.util.ViewUtil"%>
<%@page import="java.util.Map"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/include/pageCommon.jsp" %>
<%@ page import="com.ubone.framework.data.Parameter"%>
<%@ page import="com.ubone.framework.ConstantHolder"%>
<%@ page import="com.ubone.framework.ConfigHolder"%>
<%@ page import="org.apache.commons.lang.StringUtils"%>
<%@ page import="com.ubone.ubmeta.page.util.JspUtils"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core"   prefix="c" %>


<!--  ========================================================================
  This page is generated with the UB-META™ ver4.0 
 
   - PAGE ID : CUP0003R00
   - PAGE TYPE : Meta
 
  Copyright ⓒ UBONE Co., Ltd. All rights reserved.
 ========================================================================
-->
<%
	DataList _dl_Coupon_Detail = ViewUtil.getResult().getDataList("CouponManageDAO.getCouponDetail");
	
    String CD_COUPON_OBJ	 = 	 _dl_Coupon_Detail.getString(0, "CD_COUPON_OBJ");
    String NM_COUPON_OBJ	 = 	 _dl_Coupon_Detail.getString(0, "NM_COUPON_OBJ");

    String CD_COUPON_TARGET  =   _dl_Coupon_Detail.getString(0, "CD_COUPON_TARGET"); /* 쿠폰대상(금액,상품)    */
    String CD_SALE_POLICY    =   _dl_Coupon_Detail.getString(0, "CD_SALE_POLICY");	/* 할인정책           */
    String TP_MEMBER         =   _dl_Coupon_Detail.getString(0, "TP_MEMBER");		/* 대상회원구분         */
    String FG_PUB            =   _dl_Coupon_Detail.getString(0, "FG_PUB");			/* 발행여부           */
    String VAL_SALE_POLICY   =   _dl_Coupon_Detail.getString(0, "VAL_SALE_POLICY");	/* 할인정책 금액/율 */

    String IMG_LIST 		 = _dl_Coupon_Detail.getString(0, "IMG_LIST");
    String IMG_DTL 		 	 = _dl_Coupon_Detail.getString(0, "IMG_DTL");
	String IMG_RWD			 = _dl_Coupon_Detail.getString(0, "IMG_RWD");

%>

<script type="text/javascript">

// var absoluteUrl = '${pageContext.request.scheme}' + '://' + '${pageContext.request.serverName}' + ':' + '${pageContext.request.serverPort}' + '/file/image.ub?imageId=';
var absoluteUrl = '<%=request.getContextPath()%>' + '/file/image.ub?imageId=';

uxl.onLoad(function(){
	
	// 레이블 두껍게
	$('#lbl_App').css('font-weight', 'bold');
	$('#lbl_Web').css('font-weight', 'bold');
	$('#lbl_Reward').css('font-weight', 'bold');
	
	// 리워드 이미지 숨김
	$('#basicLayout #layout-1_7_14,#basicLayout #layout-1_7_15').hide();
	
	// 매장 검색 텍스트 박스 더블클릭 시 초기화
	$('#NM_STORE_SEARCH').dblclick(function(){
		$(this).val('');
		searchStore();
		$(this).focus();
	});
	$('#NM_STORE_SEARCH').keydown(function() {
	    if (event.keyCode === 13) {
	    	searchStore();
	    }
	    return ;
	});

	// 콤보박스 셋팅
	uxl.bindComboCode('TP_STOR_ALL','CD_STORE', {emptyOption:'전체'});
	uxl.bindComboCode('TP_STOR_EX','CD_STORE', {emptyOption:'전체'});
	uxl.bindComboCode('TP_EXPIRY_DATE','TP_EXPIRY_DATE', {emptyOption:'전체'});

	var cd_type = $('#TP_STOR_EX').val();
	var cd_coupon = $('#CD_COUPON').val();
	uxl.bindComboCode('CD_STOR_EX', 'CD_STOR_EX', {emptyOption:'전체',parameter:{CD_TYPE:cd_type,CD_COUPON:cd_coupon}});
	
	// 제외매장 목록 세팅
	$('#TP_STOR_EX').change(function(){
		var test = $(this).val();
		$('#CD_STOR_EX option').each(function(){
			// value 값이 일치 한다면 삭제
			if(this.value.split('/')[0] != test){
				$(this).hide();
			}else{
				$(this).show();
			}
			
			if(test == ''){
				$(this).show();
			}
		});
	}).change();
	// 전체 매장 세팅
	$('#TP_STOR_ALL').change(function(){
		$("#CD_STOR_ALL option").remove();
		cd_type = $('#TP_STOR_ALL').val();
		if(cd_type == '99'){
			uxl.bindComboCode('CD_STOR_ALL', 'CD_MAIN_EX', {});
		}else{
			uxl.bindComboCode('CD_STOR_ALL', 'CD_STOR_ALL', {parameter:{CD_TYPE:cd_type}});			
		}
		fnCheckOverlap();
	}).change();
	
	// 첨부파일 
	uxl.ext.Upload('IMG_APP',{allowFileType : '*.jpg,*.png,*.jpeg',file_upload_limit:1});
	uxl.ext.Upload('IMG_WEB',{allowFileType : '*.jpg,*.png,*.jpeg',file_upload_limit:1});
	uxl.ext.Upload('IMG_REWARD',{allowFileType : '*.jpg,*.png,*.jpeg',file_upload_limit:1});
	// 최대 1개 업로드 경고문 초기화
	$('.upload-button').click(function(){
		$('#undefined').remove();
	});
	
	// 제품선택 , 회원전체 라디오 버튼 최초 숨김처리
	$('#basicInfo #layout-1_2, input:radio[name=TP_MEMBER][value=2], #lbl_all').hide();

	$('#listBtn').click(function (){
		uxl.returnToList('CUP0002');
	});
	
	// 데이터 셋팅
	fnSetData();
	
});


uxl.onLoadComplete(function(){
	$('html').scrollTop(0);
	$('h2.ub-control.title.hfold').attr('style','z-index:-1');
	$('.lbl_import').append('<span class="required">*</span>');
	
	// 이미지 추가
	$('#basicLayout #layout-1_5_11').append('<img width="200px" src="'+absoluteUrl+'<%=IMG_LIST%>'+'" alt="쿠폰 이미지(APP용)" />');
	$('#basicLayout #layout-1_6_13').append('<img width="200px" src="'+absoluteUrl+'<%=IMG_DTL%>'+'" alt="쿠폰 이미지(WEB용)" />');
	
	// 상세 이미지 td / 할인정책 숨김
	$('#detailInfo #layout-1_2 ').hide();
	
	$('#TP_STOR_EX option[value="99"]').remove();
});

//저장하기
function fnSave(){
	
	// 제외매장 셋팅
	var cd_store = [$('#CD_STOR_EX > option').length];
	var nm_store = [$('#CD_STOR_EX > option').length];
	
	$('#CD_STOR_EX option').each(function(index){
		cd_store[index] = $(this).val().split('/').length == 1 ? $(this).val():$(this).val().split('/')[1].toString();
		nm_store[index] = $(this).text();
	});
	
	if($('#detailInfo #layout-1_4').is(':visible')){
		$('#PRODUCT_PK, #PRODUCT_PK_REAL').attr('metaessential','1');
	}else{
		$('#PRODUCT_PK, #PRODUCT_PK_REAL').attr('metaessential','0');
	};
	
	var rate = $('#SALE_CUP_RATE').val();
	if(rate > 100){
		alert('할인율은 100%를 넘을 수 없습니다.');
		return;
	}
	
	// 날짜 유효성 검사
	var dtStart = new Date($('#DT_EXPIRY_START').val());
	var dtEnd = new Date($('#DT_EXPIRY_END').val());
	
	if(dtStart > dtEnd ){
		// 시작일이 종료일보다 늦을때
		alert('유효기간이 유효하지 않습니다.');
		return;
	};

	//필수정보 체크
	var url = uxl.getFunctionUrl(_SCREEN_ID,'MODIFY');
	var option = {
		  data:{
			  CD_STORE : cd_store ,
			  NM_STORE : nm_store
		  }
		,  validator:function(data,targetForm){
			var returnVal = false;
			//필수항목체크
			if(uxl.checkRequiredFields(targetForm)){
					returnVal = true;
			}
			return returnVal;
		}
		, success:function(result){
			$('html').scrollTop(0);
			uxl.reload();
		}
		, message : {
			 confirm : uxl.getMessage('@message.common.update.confirm'),
			 success : uxl.getMessage('@message.common.update.success'),
			 fail 	 : uxl.getMessage('@message.common.update.fail')
		}
		, async:true
	};
	uxl.callSubmitFunction( 'registForm', url , option );
}

// 쿠폰 삭제
function fnDelete(){
	
	if($('#CNT_PIN').val() != "0"){
		alert("발행한 핀이 존재함으로 삭제가 불가능합니다.");
		return;
	}
	
	//필수정보 체크
	var url = uxl.getFunctionUrl(_SCREEN_ID,'REMOVE');
	var option = {
		  data:{}
		, success:function(result){
			uxl.returnToList('CUP0002');
		}
		, message : {
			 confirm : uxl.getMessage('@message.common.delete.confirm'),
			 success : uxl.getMessage('@message.common.delete.success'),
			 fail 	 : uxl.getMessage('@message.common.delete.fail')
		}
		, async:true
	};
	uxl.callSubmitFunction( 'registForm', url , option );
}

// 제외매장 전체 등록,삭제
function fnAddAll(){
	$("#CD_STOR_ALL > option").attr("selected", "selected");
	$('select[name=CD_STOR_EX]').append($('select[name=CD_STOR_ALL] option:selected'));
	$('select[name=CD_STOR_ALL] option:selected').remove();
}
function fnDelAll(){
	$("#CD_STOR_EX > option").attr("selected", "selected");
	$('select[name=CD_STOR_ALL]').append($('select[name=CD_STOR_EX] option:selected'));
	$('select[name=CD_STOR_EX] option:selected').remove();
}


// 제외매장 선택 등록,삭제
function fnAddEx(){
	
	$('select[name=CD_STOR_EX]').append($('select[name=CD_STOR_ALL] option:selected'));
	$('select[name=CD_STOR_ALL] option:selected').remove();
}
function fnDelEx(){
	$('select[name=CD_STOR_ALL]').append($('select[name=CD_STOR_EX] option:selected'));
	$('select[name=CD_STOR_EX] option:selected').remove();
}

// 제외매장 중복 확인
function fnCheckOverlap(){
	// 제외매장 목록이 존재 시
	if($('#CD_STOR_EX option').length > 0){
		var test = "";
		var flag = "N";
		
		// 전체매장 옵션수만큼 반복
		$('#CD_STOR_ALL option').each(function(){
			flag = "N"
			test = this.value;
			
			// 제외매장 옵션수만큼 반봅
			$('#CD_STOR_EX option').each(function(){
				// value 값이 일치 한다면 삭제
				if(this.value.split('/').length > 1){
					if(this.value.split('/')[1] == test){
						flag = "Y";
					}
				}else{
					if(this.value.split('/')[0] == test){
						flag = "Y";
					}
				}
				
			});
			if(flag == "Y"){
				$(this).remove();
			}
		});
	};
}

// 화면 데이터 매핑
function fnSetData(){
	// 제외매장 css 수정
	$('#StoreExLayout.ub-control.table.normal td#layout-1_1_2,td#layout-1_1_4,td#layout-1_2_5,td#layout-1_2_6').css('border-bottom',0);
	
	// 쿠폰 대상
	var NM_COUPON_OBJ = '<%=NM_COUPON_OBJ%>';
	
	// 쿠폰 대상이 매장일때
	if(NM_COUPON_OBJ == '매장'){
		$('input:radio[name=TP_MEMBER][value=2], #lbl_all').show();
		$('#detailInfo #layout-1_4,#detailInfo #layout-1_5, #basicInfo #layout-1_6_10').hide();
		$('#MENU_CD, #MENU_CD_REAL').attr('metaessential','0');
		
	}else if(NM_COUPON_OBJ == '리워드'){
		$('input:radio[name=TP_MEMBER][value=2], #lbl_all, #basicInfo #layout-1_6_10').show();
		$('#detailInfo #layout-1_4,#detailInfo #layout-1_5').hide();
		$('#MENU_CD, #MENU_CD_REAL').attr('metaessential','0');
	}else{
		// 매장이 아닐때 
		$('#basicInfo #layout-1_2, input:radio[name=TP_MEMBER][value=2], #lbl_all, #basicInfo #layout-1_6_10').hide();
		$('#detailInfo #layout-1_4,#detailInfo #layout-1_5').show();
		$('#MENU_CD, #MENU_CD_REAL').attr('metaessential','1');
	};
	
	// 쿠폰 적용 대상에 따른 화면 컨트롤
	$('input:radio[name=CD_COUPON_TARGET]').change(function(){
// 		$('#PRODUCT_PK, #MENU_NM, #PRODUCT_PK_REAL, #MENU_NM_REAL').val('');
		// 금액
		if($(this).val()=='1'){

			// 쿠폰 적용 대상이 '금액'일 시 상품선택 불가 및 할인정책 disabled 해제
			$('input:radio[name=CD_SALE_POLICY]').attr('disabled',false);
			$('#detailInfo #layout-1_4,#detailInfo #layout-1_5').hide();
			$('#MENU_CD, #MENU_CD_REAL').attr('metaessential','0');

		}else{
			//상품
			// 쿠폰 대상이 '매장'아닐 때 적용상품 선택 가능
			if('<%=CD_COUPON_OBJ%>' != 3 && '<%=CD_COUPON_OBJ%>' != 4 ){
				$('#detailInfo #layout-1_4,#detailInfo #layout-1_5').show();
				$('#MENU_CD, #MENU_CD_REAL').attr('metaessential','1');
			}

			// 상품일 시 정액할인만 선택가능함.
			$('input:radio[name=CD_SALE_POLICY][value=1]').prop('checked',true);
			$('input:radio[name=CD_SALE_POLICY]').prop('disabled',true);
			
		};
	}).change();
	
	// 할인정책 변경 시
	$('input:radio[name=CD_SALE_POLICY]').change(function(){
		$('#VAL_SALE_POLICY').val('');
		// 정액할일
		if($(this).val()=='1'){
			$('#VAL_SALE_POLICY').attr('maxlength',7);
			$('#detailInfo #layout-1_2 #layout-1_2_4 .ub-control.label').text(' 원');
		}
		// 정율할인
		else{
			$('#VAL_SALE_POLICY').attr('maxlength',2);
			$('#detailInfo #layout-1_2 #layout-1_2_4 .ub-control.label').text(' %');
		}
	});
	
	$('input:radio[name="FG_PUB"][value="'+'<%=FG_PUB%>'+'"]').prop('checked',true);
	$('input:radio[name="CD_COUPON_TARGET"][value="'+'<%=CD_COUPON_TARGET%>'+'"]').prop('checked',true).change();
	$('input:radio[name="CD_SALE_POLICY"][value="'+'<%=CD_SALE_POLICY%>'+'"]').prop('checked',true).change();
	$('#VAL_SALE_POLICY').val('<%=VAL_SALE_POLICY%>');
	$('input:radio[name="TP_MEMBER"][value="'+'<%=TP_MEMBER%>'+'"]').prop('checked',true);
	$('#lbl_obj').html(NM_COUPON_OBJ);

	if('<%=CD_COUPON_TARGET%>' == "1" || '<%=NM_COUPON_OBJ%>' == "매장" || '<%=NM_COUPON_OBJ%>' == "리워드" ){
		$('#detailInfo #layout-1_4, #detailInfo #layout-1_5').hide();
	}
	
	if('<%=NM_COUPON_OBJ%>' == "리워드"){
		$('#basicLayout #layout-1_7_14,#basicLayout #layout-1_7_15').show();
		$('#basicLayout #layout-1_7_15').append('<img width="200px" src="'+absoluteUrl+'<%=IMG_RWD%>'+'" alt="" />');
	}
}

//상품 찾기 팝업
function fnPopupMenu(){
	var menu_tp = '<%=CD_COUPON_OBJ%>';
	if(menu_tp == '1' || menu_tp == '2'){
		uxl.openWindow('PopupMenuList', uxl.getScreenURL('POP0096')+"?MENU_TYPE="+menu_tp+"&MANAGE_TYPE=3", {width:'800',height:'620'}, fnSetMenu)
	}else{
		alert("쿠폰 대상을 선택해주세요");
		return ;
	}
};

//실제 상품 찾기 팝업
function fnPopupMenuReal(){
	
	var menu_tp = '<%=CD_COUPON_OBJ%>';
	if(menu_tp == '1' || menu_tp == '2'){
		uxl.openWindow('PopupMenuList', uxl.getScreenURL('POP0096')+"?MENU_TYPE="+menu_tp+"&MANAGE_TYPE=1&USE_YN=1", {width:'800',height:'620'}, fnSetMenuReal)		
	}else{
		alert("쿠폰 대상을 선택해주세요");
		return ;
	}
	
};

// 상품 찾기 팝업 콜백 함수
function fnSetMenu(rdata){
	$("#MENU_NM").val(rdata.MENU_NM);
	$("#NM_GOODS").val(rdata.MENU_NM);
	$("#PRODUCT_PK").val(rdata.MENU_CD);
	
}
function fnSetMenuReal (rdata){
	$("#MENU_NM_REAL").val(rdata.MENU_NM);
	$("#CD_GOODS").val(rdata.MENU_NM);
	$('#PRODUCT_PK_REAL').val(rdata.MENU_CD);

}

// 핀 현황 팝업
function fnPopupPin(){
	uxl.openWindow('POP0091', uxl.getScreenURL('POP0091')+"?CD_COUPON="+$('#CD_COUPON').val(), {width:'500', height:'400'});
}

// 전체매장 검색
function searchStore(){
	var str = $('#NM_STORE_SEARCH').val().toUpperCase();
	if(str == ''){
		$('#TP_STOR_ALL').change();
	}else{
		$('#CD_STOR_ALL option').each(function(index){
			if($(this).text().match(str) == null){
				$(this).remove();
			};
		});
	}
}


// 재등록 
function fnReReg(){
	uxl.openWindow('CUP0021', uxl.getScreenURL('CUP0021')+"?CD_COUPON="+$('#CD_COUPON').val(), {width:550,height:300}, function(){
		uxl.returnToList('CUP0002');
	});
}
</script>