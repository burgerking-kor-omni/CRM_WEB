<%--
#*
 *  파 일 명 :  MNG0005.jsp
 *  설    명 :  스탬프 이력 상세 팝업
 *  작 성 자 :  강현준
 *  작 성 일 :  2018-11-26
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
 
   - PAGE ID : CUS0021R00
   - PAGE TYPE : Meta
 
  Copyright ⓒ UBONE Co., Ltd. All rights reserved.
 ========================================================================
-->

<style>
	.ui-jqgrid tr.jqgrow td { text-overflow: ellipsis;-o-text-overflow: ellipsis; }
</style>

<%
	DataList dl_CD_GRADE = ViewUtil.getResult().getDataList("Code.CD_GRADE");
%>

<script type="text/javascript">
var no_prod = 0;
uxl.onLoad(function(){
	
	// 화면 세팅
	fnSetScreen();

	//적립기준 목록 JqGrid (왼쪽)
	var options1 = {
			//header name
			colNames:['상품코드','main','sub','상품명','CD_GRADE','멤버십','적립개수','사용여부','STR_MENU'] 
			
			//mapping column
			,colModel:[
					   {name:'ID_MENU' , width:6 ,align:'center',sortable:false}
					  ,{name:'MAIN' , hidden:true}
					  ,{name:'SUB' , hidden:true}
			          ,{name:'NM_MENU' , width:30 ,align:'center',sortable:false}
			          ,{name:'CD_GRADE' , hidden:true}
			          ,{name:'NM_GRADE' , width:5 ,align:'center' , codeCategory:'CD_GRADE',sortable:false}
			          ,{name:'CNT_ACCML' , width:5 ,align:'center',sortable:false}
			          ,{name:'FG_USE' , width:5 ,align:'center', sortable:false, hidden:true}
			          ,{name:'STR_MENU' , hidden:true}
			         ]
		,autowidth:true
		,height:200
		,onSelectRow:function(rowid, status, e){
			
			$('select').attr('disabled',false);
			
			var selRow = $(this).getRowData(rowid);
			
			// 정보 초기화
			$('#MENU_CATEGORY_1').val('').change();
			$('#MENU_NAME, #STAMP_CNT, #FG_USE').val('');
			$('input[name=CD_GRADE]').prop('checked',false);

			$('#MENU_CATEGORY_1').val(selRow.MAIN).change();
			$('#MENU_CATEGORY_2').val(selRow.SUB).change();
			$('#MENU_CATEGORY_3').val(selRow.ID_MENU).change();
			
			$('input[name=CD_GRADE][value="'+selRow.CD_GRADE+'"]').attr('checked','checked');
			
			$('#STAMP_CNT').val(selRow.CNT_ACCML);
			$('#FG_USE').val(selRow.FG_USE);
			
			$('#ID_ROW').val(rowid);
			
			$('select').attr('disabled',true);
		}
	};
	uxl.grid('list_prod', options1);
	
	//등급 쿠폰목록 (오른쪽 아래)
	options = {
			//header name
			colNames:['구분','제목','적용일자','변경일시','변경자'] 
			
			//mapping column
			,colModel:[
					   {name:'TP_SET', width:20, align:'center'}
			          ,{name:'DS_TITLE', width:10, align:'center' }
			          ,{name:'DT_APPLY', width:10, align:'center' }
			          ,{name:'DT_UPT', width:10, align:'center'}
			          ,{name:'NM_UPT_USER', width:10, align:'center' }
			         ]
			,autowidth:true
			,height:200
			,multiselect:true
		};
		uxl.grid('list_change', options);
	
	// 목록으로 이동	
	$('#listBtn').click(function(){
		uxl.returnToList('MNG0001');
	});
	
	
	// 구분, 적용기간, 제목 조회
	fnGetDetail();
	
	// 적립채널 조회
	fnGetStnd();
	
	// 적립기준 메뉴 조회
	fnGetMenu();
	
	// 화면 맨 위로
	$('html').scrollTop(0);
	
	$('select').click(function(event){
		event.preventDefault();
		return false;
	});
	
});

uxl.onLoadComplete(function(){
	$('select').attr('disabled',true);
});

//화면 세팅
function fnSetScreen(){
	// 코드 세팅
	uxl.bindComboCode('FG_USE', 'FLAG_YN', {emptyOption:'선택안됨'});
	uxl.bindComboCode('FG_USE_MAIN', 'FLAG_YN', {emptyOption:false});
	uxl.bindComboCode('MENU_CATEGORY_1', 'ALL_MENU_CATEGORY_1', {emptyOption:'전체' });
	uxl.chainCombo('MENU_CATEGORY_1', 'MENU_CATEGORY_2', 'ALL_MENU_CATEGORY_2', {parameter:{DEPTH:'2'},emptyOption:'전체'});
	uxl.chainCombo('MENU_CATEGORY_2', 'MENU_CATEGORY_3', 'ALL_MENU_CATEGORY_2', {parameter:{DEPTH:'3'},emptyOption:'전체'});

	var noStampRecord = $('#NO_STAMP_RECODE').val();
	uxl.bindComboCode('CD_STOR_EX', 'CD_STAMP_EX_RECORD', {emptyOption:'전체',parameter:{CD_TYPE:'',NO_STAMP_RECODE:noStampRecord}});
	uxl.bindComboCode('CD_STOR_ALL', 'CD_STOR_ALL', {emptyOption:'전체',parameter:{CD_TYPE:''}});
	fnCheckOverlap();
	
	// 고객등급 체크박스 추가
	var htmlStr = "";
<%
	int cnt = dl_CD_GRADE.getRowCount();
	String code = "";
	String name = "";
	for(int i = 0; i < cnt; i++){
		code = dl_CD_GRADE.getString(i, ConstantHolder.CODE_COLUMN_CODE);            
		name = dl_CD_GRADE.getString(i, ConstantHolder.CODE_COLUMN_NAME);  
%>
	htmlStr +='<input class="ub-control input-checkbox" type="checkbox" id="CD_GRADE_'+'<%=code%>'+'" name="CD_GRADE" value="'+'<%=code%>'+'">';
	htmlStr +='<label for="CD_GRADE_'+'<%=code%>'+'" id="lbl_'+'<%=code%>'+'">'+'<%=name%>'+'</label>';
<%
	}
%>
	$('#stdlayout #layout-1_4_9').append(htmlStr);
	$('form input[type="checkbox"]').attr('disabled',true);
}

// 적립기준 추가
function fnCheck(str){
	
	var flag = 'Y';
	
	// 필수 입력 확인
	if($('#DT_APPLY_START').val() == '' || $('#DT_APPLY_END').val() == ''){
		alert('적용기간을 입력해주세요.');
		return;
	}
	if($('#MENU_CATEGORY_2').val() == '' ){
		alert('상품을 선택해주세요.\n(최소 2단계까지 선택해주세요)');
		return;
	}
	if($('input[name="CD_GRADE"]:checked').length < 1 ){
		alert('멤버십을 1개이상 선택해주세요.');
		return;
	}
	if($('#STAMP_CNT').val() == ''){
		alert('적립개수를 입력해주세요.');
		return;
	}
	if($("#FG_USE").val() == ''){
		alert('사용여부를 선택해주세요.');
		return;
	}
	
	// 유효성 검사를 위한 배열
	var cd_grade = [];
	var cd_menu  = [];
	var nm_menu = [];
	var nm_menu_over = [];
	
	// 등급 배열 인덱스 초기화
	var index = 0;
	
	// 기존에 등록 되었는지 확인
	var allData = $("#list_prod").getRowData();
	var allRowCnt = $("#list_prod").getGridParam("reccount");
	
	// 선택된 멤버십 개수만큼 반복
	$.each($('input[name="CD_GRADE"]:checked'),function(){
		cd_grade[index] = $(this).val();
		// 제품코드 비교
		if( $('#MENU_CATEGORY_3').val() != ''){
			if(allRowCnt > 0 ){
				for(var i = 0; i < allRowCnt; i++){
					if( $('#MENU_CATEGORY_3').val() == allData[i].ID_MENU 
							&& $(this).val() == allData[i].CD_GRADE){
						flag = 'N';
					}
				}
			}
			cd_menu[0] = $('#MENU_CATEGORY_3').val();
			nm_menu[0] = $('#MENU_CATEGORY_3 option:selected').text();
			
		// 중분류 코드 비교
		}else{
			if( $('#MENU_CATEGORY_2').val() != null || $('#MENU_CATEGORY_2').val() != '' ){
				var cnt_menu = $('#MENU_CATEGORY_3 option[value!=""]').length;
				var indexOver = 0;
				for(var j = 0; j < cnt_menu; j++){
					nm_menu[j] = $('#MENU_CATEGORY_3 option:eq('+(j+1)+')').text();
					cd_menu[j] = $('#MENU_CATEGORY_3 option:eq('+(j+1)+')').val();
					if(allRowCnt > 0 ){
						for(var i = 0; i < allRowCnt; i++){
							if(cd_menu[j] == allData[i].ID_MENU
									&& $(this).val() == allData[i].CD_GRADE){
								flag = 'N';
								if(allData[i].NM_MENU != '' && allData[i].NM_MENU != null){
										nm_menu_over[indexOver] = allData[i].NM_MENU + "\n";
										indexOver++;
								}
							}
						}
					}
				}
			}
		}
		index++;
	});
	if(flag == 'Y'){
		fnCheckMenu(cd_grade, cd_menu, nm_menu, str);
	}else{
		alert('이미 등록된 상품입니다.\n'+nm_menu_over);
	}
}

// 다른 이벤트에 등록되어 있는지 체크
function fnCheckMenu(cd_grade, cd_menu, nm_menu, str){
	//필수정보 체크
	var url = uxl.getFunctionUrl('MNG0003','CHECK');
	var option = {
			  data:{
				  CD_GRADE : cd_grade ,
				  CD_MENU : cd_menu,
				  NM_MENU : nm_menu,
				  DT_APPLY_START : $('#DT_APPLY_START').val() ,
				  DT_APPLY_END 	 : $('#DT_APPLY_END').val(),
				  FLAG : str
			  }
			, success:function(result){
				if(str == 'insert'){
					alert('추가되었습니다.');
				}else{
					var rowid = $('#ID_ROW').val();
					$('#list_prod').jqGrid('delRowData', rowid);
					alert('변경되었습니다.');
				}
				
				var cnt = cd_menu.length;
				$.each($('input[name="CD_GRADE"]:checked'),function(){
					for(var i = 0; i < cnt; i++){
						no_prod = no_prod+1;
						$('#list_prod').jqGrid('addRowData', no_prod , {
							MAIN	 : $('#MENU_CATEGORY_1').val(),
							SUB 	 : $('#MENU_CATEGORY_2').val(),
							ID_MENU  : cd_menu[i],
							NM_MENU  : $('#MENU_CATEGORY_3 option[value="'+cd_menu[i]+'"]').text(),
							CD_GRADE : $(this).val(),
							NM_GRADE : $('#lbl_'+$(this).val()).text(),
							CNT_ACCML: $('#STAMP_CNT').val(),
							FG_USE 	 : $('#FG_USE').val(),
							STR_MENU : $(this).val() +'/'+ cd_menu[i] +'/'+ nm_menu[i] +'/'+ $('#STAMP_CNT').val() +'/'+ $('#FG_USE').val()
						});
					}
					
				});
				// 정보 초기화
				$('#MENU_CATEGORY_1').val('').change();
				$('#MENU_NAME, #STAMP_CNT, #FG_USE').val('');
				$('input[name=CD_GRADE]').prop('checked',false);
			}
			, async:true
	};
	uxl.callFunction( url , option );
}

//제외매장 중복 확인
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
//제외매장 전체 등록,삭제
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

// 목록에서 삭제
function fnDelList(id_grid){
	
	var id = "#"+id_grid;
	
	var recs = $(id).jqGrid('getGridParam', 'selarrrow');
	var rows = recs.length;
	
	for (var i = rows - 1; i >= 0; i--) {
	      $(id).jqGrid('delRowData', recs[i]);
	}

	// 정보 초기화
	$('#MENU_CATEGORY_1').val('').change();
	$('#MENU_NAME, #STAMP_CNT, #FG_USE').val('');
	$('input[name=CD_GRADE]').prop('checked',false);
	
	// 전체선택 해제
	$("#cb_" + id_grid).prop("checked",false);
			
}

// 저장
function fnSave(){
	var cnt_check = $('#standardInfo input[type=checkbox]:checked').length;
	var cnt_list = $('#list_prod').getGridParam("reccount");
	
	if(cnt_check < 1){
		alert("적립채널을 하나 이상 선택해주세요.");
		$('#standardInfo input[type=checkbox]').focus();
		return;
	}
	if(cnt_list < 1){
		alert("적립기준 메뉴를 한가지 이상 등록해주세요.");
		$('#MENU_NAME').focus();
		return;
	}
	// 제외매장 세팅
	var cd_store = [$('#CD_STOR_EX > option').length];
	var nm_store = [$('#CD_STOR_EX > option').length];
	
	$('#CD_STOR_EX option').each(function(index){
		cd_store[index] = $(this).val();
		nm_store[index] = $(this).text();
	});
	
	// 메뉴 배열
	var allData = $("#list_prod").getRowData();
	var rowCnt = $("#list_prod").getGridParam("reccount");
	
	var strMenu 	 = [rowCnt];
	var j = 0;
	for(var i = 0; i < rowCnt; i++){
		strMenu[i] =  allData[i].STR_MENU;
	}
	
	//필수정보 체크
	var url = uxl.getFunctionUrl(_SCREEN_ID,'REGIST');
	var option = {
		  data:{
			  CD_STORE : cd_store,
			  NM_STORE : nm_store,
			  STR_MENU  : strMenu
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

// 스탬프 적립기준 메뉴 조회
function fnGetMenu(){
	var url = uxl.getFunctionUrl(_SCREEN_ID,'INQUIRY');
	var option = {
			  data:uxl.grid.getParam('list_prod')
			, success:function(result){
				uxl.grid.appendData('list_prod' ,result , true );
			}
			, async:true
	};
	uxl.callSubmitFunction('registForm' , url , option );
}

// 스탬프 적립채널 조회
function fnGetStnd(){
	var url = uxl.getFunctionUrl(_SCREEN_ID,'USERDEFINED1');
	var option = {
			  data:{}
			, success:function(result){
				var rows = result.getDataList(0).rows;
				var cnt = result.getDataList(0).rowCount;
				for(var i = 0; i < cnt; i++){
					$('input:checkbox[value="'+rows[i].CD_MTH_CHNN+'"]').prop('checked',true);
				};
			}
			, async:true
	};
	uxl.callSubmitFunction('registForm' , url , option );
}

// 상세 조회
function fnGetDetail(){
	var url = uxl.getFunctionUrl(_SCREEN_ID,'EXECUTE');
	var option = {
			  data:{}
			, success:function(result){
				var rows = result.getDataList(0).rows[0];
				
				$('#TP_SET').val(rows.TP_SET);
				$('#DT_APPLY_START').val(rows.DT_APPLY_START);
				$('#DT_APPLY_END').val(rows.DT_APPLY_END);
				$('#DS_TITLE').val(rows.DS_TITLE);
			}
			, async:true
	};
	uxl.callSubmitFunction('registForm' , url , option );
}

</script>