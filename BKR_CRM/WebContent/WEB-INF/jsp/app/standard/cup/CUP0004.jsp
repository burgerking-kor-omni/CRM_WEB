<%--
#*
 *  파 일 명 :  CUP0004.jsp
 *  설    명 :  쿠폰 마스터 등록
 *  작 성 자 :  강현준
 *  작 성 일 :  2018-11-07
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
 
   - PAGE ID : CUP0004R00
   - PAGE TYPE : Meta
 
  Copyright ⓒ UBONE Co., Ltd. All rights reserved.
 ========================================================================
-->

<script type="text/javascript">
uxl.onLoad(function(){
	
	// 콤보박스 셋팅
	uxl.bindComboCode('TP_EXPIRY_DATE', 'TP_EXPIRY_DATE', {emptyOption:false});
	uxl.bindComboCode('TP_STOR_ALL','CD_STORE', {emptyOption:'전체'});

	// 제외매장 목록 세팅
	$('#TP_STOR_ALL').change(function(){
		cd_type = $('#TP_STOR_ALL').val();
		if(cd_type == '99'){
			uxl.bindComboCode('CD_STOR_ALL', 'CD_MAIN_EX', {});
		}else{
			uxl.bindComboCode('CD_STOR_ALL', 'CD_STOR_ALL', {parameter:{CD_TYPE:cd_type}});			
		}
		fnCheckOverlap();
	}).change();
	$('#TP_STOR_EX').hide();
	
	// 첨부파일 
	uxl.ext.Upload('IMG_APP',{allowFileType : '*.jpg,*.png,*.jpeg',file_upload_limit:1});
	uxl.ext.Upload('IMG_WEB',{allowFileType : '*.jpg,*.png,*.jpeg',file_upload_limit:1});
	uxl.ext.Upload('IMG_REWARD',{allowFileType : '*.jpg,*.png,*.jpeg',file_upload_limit:1});
	// 최대 1개 업로드 경고문 초기화
	$('.upload-button').click(function(){
		$('#undefined').remove();
	});
	
	// 제품선택 , 회원전체 라디오 버튼 최초 숨김처리
	$('#basicInfo #layout-1_2, input:radio[name=TP_MEMBER][value=2], #lbl_all, #basicInfo #layout-1_6_10').hide();

	// 쿠폰 대상에 따른 화면 컨트롤
	$('input:radio[name=CD_COUPON_OBJ]').change(function(){
		// 쿠폰 대상이 매장일때
		if($('input:radio[name=CD_COUPON_OBJ]:checked').val() == '3'){
			$('#basicInfo #layout-1_2, input:radio[name=TP_MEMBER][value=2], #lbl_all').show();
			$('#detailInfo #layout-1_4,#detailInfo #layout-1_5, #basicInfo #layout-1_6_10').hide();
			$('#MENU_CD, #MENU_CD_REAL').attr('metaessential','0');
			
		}else if($('input:radio[name=CD_COUPON_OBJ]:checked').val() == '4'){
			$('#basicInfo #layout-1_2, #basicInfo #layout-1_6_10').show();
			$('#detailInfo #layout-1_4,#detailInfo #layout-1_5, input:radio[name=TP_MEMBER][value=2], #lbl_all').hide();
			$('#MENU_CD, #MENU_CD_REAL').attr('metaessential','0');
		}else{
			// 매장이 아닐때 
			$('#basicInfo #layout-1_2, input:radio[name=TP_MEMBER][value=2], #lbl_all, #basicInfo #layout-1_6_10').hide();
			$('#detailInfo #layout-1_4,#detailInfo #layout-1_5').show();
			$('#MENU_CD, #MENU_CD_REAL').attr('metaessential','1');
		};
		$('#CD_COUPON_TARGET').val('1').attr('checked',true).change();
		$('#NO_REQ, #CD_GOODS, #NM_GOODS ,#IMG_GOODS').val('');
		$('#DAU_COUPON').remove();
	});
	
	// 쿠폰 적용 대상에 따른 화면 컨트롤
	$('input:radio[name=CD_COUPON_TARGET]').change(function(){
		$('#PRODUCT_PK, #MENU_NM, #PRODUCT_PK_REAL, #MENU_NM_REAL').val('');
		$('#VAL_SALE_POLICY, #VAL_LIMIT_PRICE').val('0');
		// 금액
		if($(this).val()=='1'){

			// 쿠폰 적용 대상이 '금액'일 시 상품선택 불가 및 할인정책 disabled 해제
			$('input:radio[name=CD_SALE_POLICY]').attr('disabled',false);
			$('#detailInfo #layout-1_4,#detailInfo #layout-1_5').hide();
			$('#MENU_CD, #MENU_CD_REAL').attr('metaessential','0');

		
		}else{
			//상품
			// 쿠폰 대상이 '매장'아닐 때 적용상품 선택 가능
			if($('input:radio[name=CD_COUPON_OBJ]:checked').val() != '3' && $('input:radio[name=CD_COUPON_OBJ]:checked').val() != '4'){
				$('#detailInfo #layout-1_4,#detailInfo #layout-1_5').show();
				$('#MENU_CD, #MENU_CD_REAL').attr('metaessential','1');
			}

			// 상품일 시 정액할인만 선택가능함.
			$('#detailInfo #LBL_POLICY').text(' 원');
			$('input:radio[name=CD_SALE_POLICY][value=1]').prop('checked',true);
			$('input:radio[name=CD_SALE_POLICY]').prop('disabled',true);
			
		};
	});
	
	// 할인정책 변경 시
	$('input:radio[name=CD_SALE_POLICY]').change(function(){
		$('#VAL_SALE_POLICY').val('');
		// 정액할일
		if($(this).val()=='1'){
			$('#VAL_SALE_POLICY').attr('maxlength',7);
			$('#detailInfo #LBL_POLICY').text(' 원');
		}
		// 정율할인
		else{
			$('#VAL_SALE_POLICY').attr('maxlength',2);
			$('#detailInfo #LBL_POLICY').text(' %');
		}
	});

	$('#listBtn').click(function (){
		uxl.returnToList('CUP0002');
	});
	
	// 입력폼 더블 클릭 시 값 초기화
	$('form').dblclick(function(e){
		e.target.value = "";
	});
	$('#CD_COUPON_TARGET').change();	
	
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
});

uxl.onLoadComplete(function(){
	
	// 날짜 세팅
	var d = new Date();
	var day = d.getDay(), 
				diff = d.getDate() - day + (day == 0 ? -6:1);
	var dd = new Date(d.setDate(diff));
	var year = dd.getFullYear();
	var month = (dd.getMonth()+1);
	month = month.toString().length == 1 ? '0'+month : month;
	var date = dd.getDate();
	date = date.toString().length == 1 ? '0'+date : date;
	$("#DT_EXPIRY_START").val(year+"-"+month+"-"+date);
	
	var d2 = new Date();
	d2.setDate(d.getDate() + 6);
	year = d2.getFullYear();
	month = (d2.getMonth()+1);
	month = month.toString().length == 1 ? '0'+month : month;
	date = d2.getDate();
	date = date.toString().length == 1 ? '0'+date : date;
	$("#DT_EXPIRY_END").val(year+"-"+month+"-"+date);
	
	// css 수정
	$('#StoreExLayout.ub-control.table.normal td#layout-1_1_2,td#layout-1_1_4,td#layout-1_2_5,td#layout-1_2_6').css('border-bottom',0);
	$('#lbl_App').css('font-weight', 'bold');
	$('#lbl_Web').css('font-weight', 'bold');
	$('#lbl_Reward').css('font-weight', 'bold');
	$('#lbl_Web').css('font-weight', 'bold');
	
	// 적용상품 필수 표시
	$('#detailInfo #layout-1_4_7').append('<span class="required">*</span>');
	$('.lbl_import').append('<span class="required">*</span>');
	
	// td 숨김
	$('#detailInfo #layout-1_2').hide();
	
	$('h2.ub-control.title.hfold').attr('style','z-index:-1');
	$('#DS_COUPON').attr('maxlength','250');
	$('html').scrollTop(0);
});

//저장하기
function fnSave(){
	
	if($('#detailInfo #layout-1_4').is(':visible')){
		$('#PRODUCT_PK, #PRODUCT_PK_REAL').attr('metaessential','1');
	}else{
		$('#PRODUCT_PK, #PRODUCT_PK_REAL').attr('metaessential','0');
	};
	
	// 제외매장 셋팅
	$('#CD_STOR_EX > option').attr("selected","selected");
	
	var cd_store = [$('#CD_STOR_EX > option').length];
	var nm_store = [$('#CD_STOR_EX > option').length];
	
	$('#CD_STOR_EX option').each(function(index){
		cd_store[index] = $(this).val();
		nm_store[index] = $(this).text();
	});
	
	var rate = $('#SALE_CUP_RATE').val();
	if(rate > 100){
		alert('할인율은 100%를 넘을 수 없습니다.');
		return;
	}
	
	if($('input:radio[name=CD_COUPON_OBJ]:checked').length < 1){
		alert("쿠폰대상을 선택해주세요.");
		$('input:radio[name=CD_COUPON_OBJ]').focus();
		return;
	}
	if($('input:radio[name=CD_COUPON_TARGET]:checked').length < 1){
		alert("쿠폰 적용대상을 선택해주세요.");
		$('input:radio[name=CD_COUPON_TARGET]').focus();
		return;
	}
	if($('input:radio[name=CD_SALE_POLICY]:checked').length < 1){
		alert("할인 정책을 선택해주세요.");
		$('input:radio[name=CD_SALE_POLICY]').focus();
		return;
	}
	if($('input:radio[name=TP_MEMBER]:checked').length < 1){
		alert("대상 회원을 선택해주세요.");
		$('input:radio[name=TP_MEMBER]').focus();
		return;
	}
	if($('input:radio[name=FG_PUB]:checked').length < 1){
		alert("발행 여부를 선택해주세요.");
		$('input:radio[name=FG_PUB]').focus();
		return;
	}
	
	if($('input[name="CD_COUPON_OBJ"]:checked').val() == '3'){
		if($('#NO_REQ').val() == ''){
			alert('다우 쿠폰 상품을 선택해야 합니다.');
			$('html').scrollTop(0);
			return;
		}
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
	var url = uxl.getFunctionUrl(_SCREEN_ID,'REGIST');
	var option = {
		  data:{
			  CD_STORE : cd_store ,
			  NM_STORE : nm_store
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
			uxl.returnToList('CUP0002');
		}
		, message : {
			 confirm : uxl.getMessage('@message.common.insert.confirm'),
			 success : uxl.getMessage('@message.common.insert.success'),
			 fail 	 : uxl.getMessage('@message.common.insert.fail')
		}
		, async:true
	};
	uxl.callSubmitFunction( 'registForm', url , option );
}

// 상품 찾기 팝업
function fnPopupMenu(){
	var menu_tp = $('input:radio[name=CD_COUPON_OBJ]:checked').val();
	if(menu_tp == '1' || menu_tp == '2'){
		uxl.openWindow('PopupMenuList', uxl.getScreenURL('POP0096')+"?MENU_TYPE="+menu_tp+"&MANAGE_TYPE=3", {width:'800',height:'620'}, fnSetMenu)
	}else{
		alert("쿠폰 대상을 선택해주세요");
		return ;
	}
};

//실제 상품 찾기 팝업
function fnPopupMenuReal(){
	
	var menu_tp = $('input:radio[name=CD_COUPON_OBJ]:checked').val();
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

// 다우상품 선택 팝업
function fnPopupDau(){
	uxl.openWindow('PopupDauProdList', uxl.getScreenURL('POP0095'), {width:'800',height:'620'}, fnSetDauProd);
}

// 다우상품 콜백 함수
function fnSetDauProd(rdata){
	$('#DAU_COUPON').remove();
	$('#basicInfo #layout-1_2_4').append('<div id="DAU_COUPON"><br /><b>상품코드 : '+rdata.NO_REQ+'<br />'+
											 '상품명 : ' +rdata.NM_REQ+'</b> <br />'+
											   '<img src="'+rdata.IMG_SRC+'" width="100"></div>');
	$('#NO_REQ').val(rdata.NO_REQ);
	$('#CD_GOODS').val(rdata.CD_GOODS);
	$('#NM_GOODS').val(rdata.NM_GOODS);
	$('#IMG_GOODS').val(rdata.IMG_SRC);
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
				if(this.value == test){
					flag = "Y";
				}
			});
			if(flag == "Y"){
				$(this).remove();
			}
		});
	};
}

//전체매장 검색
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

</script>