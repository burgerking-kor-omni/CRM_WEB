<%--
#*
 *  파 일 명 :  SYS0004.jsp
 *  설    명 :  코드 유형 상세
 *  작 성 자 :  안신용
 *  작 성 일 :  2013-05-13
 *  버    전 :  1.0
 *  기타사항 :
 *  Copyrights 2013 by ㈜ 유비원. All right reserved.
*# 
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.ubone.framework.util.ViewUtil"%>
<%@ include file="/WEB-INF/jsp/include/pageCommon.jsp"%>
<%@ page import="com.ubone.framework.data.DataList"%>
<%@ page import="com.ubone.framework.data.Parameter"%>
<%@ page import="com.ubone.framework.ConstantHolder"%>
<%@ page import="com.ubone.framework.ConfigHolder"%>
<%@ page import="java.util.Map"%>
<%@ page import="org.apache.commons.lang.StringUtils"%>
<%@ page import="com.ubone.ubmeta.page.util.JspUtils"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core"   prefix="c" %>
<%
	DataList _dataList = null;		/* List Table default dataTable */ 
	DataList _dl_CODE_TP = ViewUtil.getResult().getDataList("Code.CODE_TP");
	DataList _dl_Code_selectCodeCategoryDetail = ViewUtil.getResult().getDataList("Code.selectCodeCategoryDetail");
	DataList _dl_FLAG_YN = ViewUtil.getResult().getDataList("Code.FLAG_YN");
	DataList _dl_STATUS = ViewUtil.getResult().getDataList("Code.STATUS");
%>


<style>
 	.ub-control.title .ub-layout.button.inner{position:absolute;top:4px;right:0}
</style>

<script type="text/javascript">
uxl.onLoad(function(){
	
	// 리스트
	$('#listBtn').click(function(){
		uxl.returnToList('EXP9000');
	});

	// Dynamic 버튼 초기화
	if($('#CODE_TP').val()!="DN"){
		dynamicCodeWriterHide();
		originalRelativeHide();
	}else{
		if($('input[name=MAPPING_YN]:checked').val()=="N"){
			originalRelativeHide(true);	
		}
	}
	
	if($('#CODE_TP').val()!="EN"){
		enumHide();
	}
	
	// Dynamic 버튼 이벤트
	$('#CODE_TP').change(function(){
		if($(this).val()=="DN"){
			if($('input[name=MAPPING_YN]:checked').val()=="Y"){
				originalRelativeShow();
			}
			dynamicCodeWriterShow();
			enumHide();
		}else if($(this).val()=="EN"){
			dynamicCodeWriterHide();
			enumShow();
			originalRelativeHide(true);
		}else{
			dynamicCodeWriterHide();
			originalRelativeHide(true);
		}
	});
	
	
	// focus 이벤트
	$('#CODE_GROUP_ID').focus(function(){
		/* $('#CODE_GROUP_ID').val('');
		$('#CODE_GROUP_NM').val(''); */
		$('#list').resetSelection();
		$('#list2').resetSelection();
		$('#list2 :checkbox').attr('checked',false);
	});
	
	// focus 이벤트
	$('#CODE_GROUP_NM').focus(function(){
		$('#list').resetSelection();
		$('#list2').resetSelection();
		$('#list2 :checkbox').attr('checked',false);
	});
		
	// 코드 그룹 저장
	$('#insertGroupBtn').click(function(){
		if(uxl.isEmpty($('#CODE_GROUP_ID').val()) || uxl.isEmpty($('#CODE_GROUP_NM').val())){
			alert('코드그룹ID 또는 코드그룹명을 입력하세요.');
			return;
		}
		var CODES = [];
		var selarrrow = $( "#list2" ).jqGrid('getGridParam', "selarrrow" );
		if(selarrrow.length < 1){
			alert("그룹핑할 코드를 선택해주세요.");
			return;
		}else{
			for ( var i = 0; i < selarrrow.length; i++) {
				CODES[i] = $("#list2").jqGrid('getCell', selarrrow[i],'CODE');
			}
		}
		var parameter = {
			/* CODE_CATEGORY_ID:$('#CODE_CATEGORY_ID').val() 
		   ,CODE_GROUP_ID:$('#CODE_GROUP_ID').val()
		   ,CODE_GROUP_NM:$('#CODE_GROUP_NM').val() */
	 	   CODE:CODES
	 	  ,CODE_SIZE:CODES.length
		};
		insertCodeGroup(parameter);
	});
	
	// 코드 그룹 삭제
	$('#deleteGroupBtn').click(function(){
		
		var selrow = $('#list').jqGrid('getGridParam','selrow');
		var selectrow = $('#list').jqGrid('getRowData',selrow);
		parameter ={
				GROUP_ID:selectrow.CODE_GROUP_ID
		};
		deleteCodeGroup(parameter);
	});
	
	// 코드 그룹 조회
	var options = {
			//header name
			colNames:['코드그룹ID','코드그룹명'] 
			
			//mapping column
			, colModel:[
			           {name:'CODE_GROUP_ID',width:100}
			          ,{name:'CODE_GROUP_NM',width:100}
			         ]
			, autowidth:true
			, height:231
			, onSelectRow:function(){
				var selrow = $(this).jqGrid('getGridParam','selrow');
				var selectrow = $(this).jqGrid('getRowData',selrow);
				$('#CODE_GROUP_ID').val(selectrow.CODE_GROUP_ID);
				$('#CODE_GROUP_NM').val(selectrow.CODE_GROUP_NM);
				parameter ={
					GROUP_ID:selectrow.CODE_GROUP_ID
				};
				selectGroupCode(parameter);
			}
			, loadComplete:function(){
				if(records = $(this).jqGrid('getGridParam','records') < 1){
					selectCodeGroup(true);					
				}
			}
		};
	uxl.grid('list', options);
	
	// 코드 조회
	var options2 = {
			//header name
			colNames:['코드','코드명','코드설명','정렬순서','상위코드','상태','코드카테고리ID'] 
			
			//mapping column
			, colModel:[
			           {name:'CODE',width:90}
			          ,{name:'CODE_NAME',width:100,}
			          ,{name:'CODE_DS',width:200}
			          ,{name:'SORT_ORDER',width:100}
			          ,{name:'PARENT_CODE',width:100}
			          ,{name:'STATUS',width:100}
			          ,{name:'CODE_CATEGORY_ID',hidden:true}
			         ]
			, autowidth:true
			, height:300
			, multiselect:true
			, loadComplete:function(){
				if(records = $(this).jqGrid('getGridParam','records') < 1){
					selectCode();					
				}
			}
			,onCellSelect: function(rowid, iCol){
				if(iCol == 0){
					return false;
				}else{
					var selectedRow = $(this).getRowData(rowid);
					var listner = function(){};
					var url = uxl.getScreenURL('SYS0006') + '?CODE_CATEGORY_ID=' + selectedRow.CODE_CATEGORY_ID +'&CODE='+selectedRow.CODE;
					uxl.openWindow('Popup', url, { width:800 ,height:355 }, listner);
				}
			}
		};
	uxl.grid('list2', options2);
	
});

//Dynamic 코드부분
function dynamicCodeWriterShow(){
	$('#viewCodeBtn').parent().show();
	$('#CODE_QUERY_CONTENT').parent().parent().show();
}
function dynamicCodeWriterHide(){
	$('#viewCodeBtn').parent().hide();
	$('#CODE_QUERY_CONTENT').parent().parent().hide();
}
//Dynamic 코드부분

// ENUM 부분
function enumShow(){
	$('#ENUM_CLASS_NAME').parent().parent().show();
}
function enumHide(){
	$('#ENUM_CLASS_NAME').parent().parent().hide();
}
//ENUM 부분

//원천 관련 항목 validation
function originalRelativeShow(){
	$('label[for=TABLE_ID]').append('<span class="required">*</span>');
	$('label[for=CODE_COLUMN_ID]').append('<span class="required">*</span>');
	$('label[for=NAME_COLUMN_ID]').append('<span class="required">*</span>');
	$('#TABLE_ID').attr('metaessential','1').parent().parent().show();
	$('#CODE_COLUMN_ID').attr('metaessential','1').parent().parent().show();
	$('#NAME_COLUMN_ID').attr('metaessential','1').parent().parent().show();
}
function originalRelativeHide(clear){
	clear = clear || false;
	$('label[for=TABLE_ID]').find('span').remove();
	$('label[for=CODE_COLUMN_ID]').find('span').remove();
	$('label[for=NAME_COLUMN_ID]').find('span').remove();
	$('#TABLE_ID').removeAttr('metaessential').parent().parent().hide();
	$('#CODE_COLUMN_ID').removeAttr('metaessential').parent().parent().hide();
	$('#NAME_COLUMN_ID').removeAttr('metaessential').parent().parent().hide();
	if(clear){
		$('#TABLE_ID').val('');
		$('#CODE_COLUMN_ID').val('');
		$('#NAME_COLUMN_ID').val('');
	}
}
//원천 관련 항목 validation

// 코드 조회
function selectCode(){
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
					uxl.grid.appendData('list2' ,result , true );
				}
				, async:true
		};
		uxl.callSubmitFunction('detailForm' , url , option );
}

//특정 그룹의 코드 조회
function selectGroupCode(parameter){
	var url = uxl.getFunctionUrl(_SCREEN_ID,'USERDEFINED4');
	var option = {
				  data:parameter
				, validator:function(data,targetForm){
						var returnVal = false;
						//필수항목체크
						if(uxl.checkRequiredFields(targetForm)){
							returnVal = true;
						}
						return returnVal;
				}
				, success:function(result){
					$('#list2 :checkbox').attr('checked',false);
					$('#list2').resetSelection();
					var codeInfo = result.getDataList(0).rows;
					var allRowsInGrid = $('#list2').jqGrid('getRowData');
					for (var i = 0; i < codeInfo.length; i++){
						for (var j = 0; j < allRowsInGrid.length; j++) {  //그리드 전체 Rows
							if(codeInfo[i].CODE == allRowsInGrid[j].CODE){
								$('#list2').setSelection(j);
								$('#list2 tr[id='+j+'] :checkbox').attr('checked', true);
							}
						}	
					}
				}
				, async:true
		};
		uxl.callSubmitFunction('detailForm' , url , option );
}

//코드 카테고리 수정
function updateCodeCategory(){
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
				}
				, async:true
				, message : {
					 confirm : uxl.getMessage('@message.common.update.confirm'),
					 success : uxl.getMessage('@message.common.update.success'),
					 fail : uxl.getMessage('@message.common.update.fail')
				}
		};
		uxl.callSubmitFunction('detailForm' , url , option );
}

//코드 카테고리 삭제
function deleteCodeCategory(){
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
				uxl.moveLocation(uxl.getScreenURL('SYS0002'));
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

//코드 그룹 조회
function selectCodeGroup(gridClear){
	var url = uxl.getFunctionUrl(_SCREEN_ID,'USERDEFINED1');
	var option = {
				  data:{}
				, success:function(result){
					uxl.grid.appendData('list' ,result , gridClear);
				}
				, async:false
		};
		uxl.callSubmitFunction('detailForm' , url , option );
}

//코드 그룹 등록
function insertCodeGroup(parameter){
	var url = uxl.getFunctionUrl(_SCREEN_ID,'USERDEFINED2');
	var option = {
				  data:parameter
				, success:function(result){
					$('#CODE_GROUP_ID').val('');
					$('#CODE_GROUP_NM').val('');
					$('#CODE_GROUP_ID').focus();
					selectCodeGroup(true);
				}
				, async:false
				, message : {
					 confirm : uxl.getMessage('@message.common.insert.confirm'),
					 success : uxl.getMessage('@message.common.insert.success'),
					 fail : uxl.getMessage('@message.common.insert.fail')
				}
		};
		uxl.callSubmitFunction('detailForm' , url , option );
}
//코드 그룹 삭제
function deleteCodeGroup(parameter){
	var url = uxl.getFunctionUrl(_SCREEN_ID,'USERDEFINED3');
	var option = {
			  data:parameter
			, success:function(result){
				$('#CODE_GROUP_ID').val('');
				$('#CODE_GROUP_NM').val('');
				$('#CODE_GROUP_ID').focus();
				$('#list2 :checkbox').attr('checked',false);
				$('#list2').resetSelection();
				selectCodeGroup(true);
			}
			, async:false
			, message : {
				 confirm : uxl.getMessage('@message.common.delete.confirm'),
				 success : uxl.getMessage('@message.common.delete.success'),
				 fail : uxl.getMessage('@message.common.delete.fail')
			}
	};
	uxl.callSubmitFunction('detailForm' , url , option );
}

// 라디오 버튼 생성
function radio(value, options, rowObject){
	var radioHtml = '<input type="radio" value='+ value + ' name="radioid" />';
	return radioHtml;
}
</script>