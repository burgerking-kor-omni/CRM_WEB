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


<!--  ========================================================================
  This page is generated with the UB-META™ ver4.0 
 
   - PAGE ID : SYS0004R00
   - PAGE TYPE : JSP
 
  Copyright ⓒ UBONE Co., Ltd. All rights reserved.
 ========================================================================
--> 


<!-- layout-1 Start -->
<h1 class="ub-control title">코드 유형 상세</h1>
<div class="ub-layout button top"><span class="ub-control button top icon" id="listBtn">
    <a href="#none" title="목록"><span class="ico-list"></span>목록</a>
</span>
</div>
<h2 class="ub-control title">기본정보</h2>
<form id="detailForm" name="detailForm"><div class="ub-layout details"><table class="ub-control table normal ">
<colgroup>
<col width="15%"/>
<col />
<col width="15%"/>
<col width="20%"/>
<col width="15%"/>
<col />
</colgroup>
<tbody>
<tr id="layout-1_1">
<th id="layout-1_1_1"><label class="ub-control label"             for="CODE_CATEGORY_ID">코드유형ID</label></th>
<td id="layout-1_1_2"><input type=text  class="ub-control input-text " id="CODE_CATEGORY_ID" name="CODE_CATEGORY_ID"       value="<%=JspUtils.getDefaultValue(_dl_Code_selectCodeCategoryDetail, "CODE_CATEGORY_ID") %>"  readonly   metaessential="1"           style="text-align:left;width:150px;"></td>
<th id="layout-1_1_3"><label class="ub-control label"             for="CODE_CATEGORY_NM">코드유형명</label></th>
<td id="layout-1_1_4"><input type=text  class="ub-control input-text " id="CODE_CATEGORY_NM" name="CODE_CATEGORY_NM"       value="<%=JspUtils.getDefaultValue(_dl_Code_selectCodeCategoryDetail, "CODE_CATEGORY_NM") %>"     metaessential="1"           style="text-align:left;width:150px;"></td>
<td id="layout-1_1_5"></td>
<td id="layout-1_1_6"></td>
</tr>
<tr id="layout-1_2">
<th id="layout-1_2_7"><label class="ub-control label"             for="CODE_TP">코드유형</label></th>
<td id="layout-1_2_8"><select id="CODE_TP" name="CODE_TP" class="ub-control select "     style="width:120px;" size="1" datacid="CODE_TP" defaultvalue="<%=JspUtils.getDefaultValue(_dl_Code_selectCodeCategoryDetail, "CODE_TP") %>"     metaessential="1"><%    if(!"".equals("")){        out.println("<OPTION VALUE=\"\"></OPTION>\r\n");    }    if(_dl_CODE_TP != null){        for(int codeIdx=0; codeIdx < _dl_CODE_TP.getRowCount(); codeIdx++){            String code = _dl_CODE_TP.getString(codeIdx, ConstantHolder.CODE_COLUMN_CODE);            String name = _dl_CODE_TP.getString(codeIdx, ConstantHolder.CODE_COLUMN_NAME);            String selected = code.equals(JspUtils.getDefaultValue(_dl_Code_selectCodeCategoryDetail, "CODE_TP"))?"selected":"";            out.println("<option VALUE=\""+code+"\" "+selected+">"+name+"</option>\r\n");        }    }%></select></td>
<th id="layout-1_2_9"><label class="ub-control label">상위코드</label></th>
<td id="layout-1_2_10"><input type=text  class="ub-control input-text " id="CODE_CATEGORY_ID_UP" name="CODE_CATEGORY_ID_UP"       value="<%=JspUtils.getDefaultValue(_dl_Code_selectCodeCategoryDetail, "CODE_CATEGORY_ID_UP") %>"  readonly              style="text-align:left;width:150px;"></td>
<td id="layout-1_2_11"></td>
<td id="layout-1_2_12"></td>
</tr>
<tr id="layout-1_3">
<th id="layout-1_3_13"><label class="ub-control label"             for="CONSTANT_REG_YN">상수등록여부</label></th>
<td id="layout-1_3_14"><select id="CONSTANT_REG_YN" name="CONSTANT_REG_YN" class="ub-control select "     style="width:120px;" size="1" datacid="FLAG_YN" defaultvalue="<%=JspUtils.getDefaultValue(_dl_Code_selectCodeCategoryDetail, "CONSTANT_REG_YN") %>"     metaessential="1"></select></td>
<th id="layout-1_3_15"><label class="ub-control label"             for="CACHE_YN">캐쉬여부</label></th>
<td id="layout-1_3_16"><select id="CACHE_YN" name="CACHE_YN" class="ub-control select "     style="width:120px;" size="1" datacid="FLAG_YN" defaultvalue="<%=JspUtils.getDefaultValue(_dl_Code_selectCodeCategoryDetail, "CACHE_YN") %>"     metaessential="1"><%    if(!"".equals("")){        out.println("<OPTION VALUE=\"\"></OPTION>\r\n");    }    if(_dl_FLAG_YN != null){        for(int codeIdx=0; codeIdx < _dl_FLAG_YN.getRowCount(); codeIdx++){            String code = _dl_FLAG_YN.getString(codeIdx, ConstantHolder.CODE_COLUMN_CODE);            String name = _dl_FLAG_YN.getString(codeIdx, ConstantHolder.CODE_COLUMN_NAME);            String selected = code.equals(JspUtils.getDefaultValue(_dl_Code_selectCodeCategoryDetail, "CACHE_YN"))?"selected":"";            out.println("<option VALUE=\""+code+"\" "+selected+">"+name+"</option>\r\n");        }    }%></select></td>
<td id="layout-1_3_17"></td>
<td id="layout-1_3_18"></td>
</tr>
<tr id="layout-1_4">
<th id="layout-1_4_19"><label class="ub-control label"             for="STATUS">상태</label></th>
<td id="layout-1_4_20"><select id="STATUS" name="STATUS" class="ub-control select "     style="width:120px;" size="1" datacid="STATUS" defaultvalue="<%=JspUtils.getDefaultValue(_dl_Code_selectCodeCategoryDetail, "STATUS") %>"     metaessential="1"><%    if(!"".equals("")){        out.println("<OPTION VALUE=\"\"></OPTION>\r\n");    }    if(_dl_STATUS != null){        for(int codeIdx=0; codeIdx < _dl_STATUS.getRowCount(); codeIdx++){            String code = _dl_STATUS.getString(codeIdx, ConstantHolder.CODE_COLUMN_CODE);            String name = _dl_STATUS.getString(codeIdx, ConstantHolder.CODE_COLUMN_NAME);            String selected = code.equals(JspUtils.getDefaultValue(_dl_Code_selectCodeCategoryDetail, "STATUS"))?"selected":"";            out.println("<option VALUE=\""+code+"\" "+selected+">"+name+"</option>\r\n");        }    }%></select></td>
<th id="layout-1_4_21"><label class="ub-control label">코드맵핑사용여부</label></th>
<td id="layout-1_4_22"><input class="ub-control radio" type=radio  id="MAPPING_YN" name="MAPPING_YN"    <%= ("Y".equals(JspUtils.getDefaultValue(_dl_Code_selectCodeCategoryDetail, "MAPPING_YN")))?"checked":"" %> value="Y"><label>사용</label><input class="ub-control radio" type=radio  id="MAPPING_YN" name="MAPPING_YN"    <%= ("N".equals(JspUtils.getDefaultValue(_dl_Code_selectCodeCategoryDetail, "MAPPING_YN")))?"checked":"" %> value="N"><label>미사용</label></td>
<td id="layout-1_4_23"></td>
<td id="layout-1_4_24"></td>
</tr>
<tr id="layout-1_5">
<th id="layout-1_5_25"><label class="ub-control label">ENUM 클래스</label></th>
<td id="layout-1_5_26" colspan=5><input type=text  class="ub-control input-text " id="ENUM_CLASS_NAME" name="ENUM_CLASS_NAME"       value="<%=JspUtils.getDefaultValue(_dl_Code_selectCodeCategoryDetail, "ENUM_CLASS_NAME") %>"                style="text-align:left;width:500px;"></td>
</tr>
<tr id="layout-1_6">
<th id="layout-1_6_27"><label class="ub-control label">코드정의쿼리</label></th>
<td id="layout-1_6_28" colspan=5><textarea class="ub-control textarea " id="CODE_QUERY_CONTENT" name="CODE_QUERY_CONTENT"       style="width:600px;" rows="5"                  rows="5"><%=JspUtils.getDefaultValue(_dl_Code_selectCodeCategoryDetail, "CODE_QUERY_CONTENT") %></textarea><div class="ub-layout button inner"><span class="ub-control button inner icon" id="viewCodeBtn">    <a href="#none" title="코드보기"><span></span>코드보기</a></span></div></td>
</tr>
<tr id="layout-1_7">
<th id="layout-1_7_29"><label class="ub-control label"             for="TABLE_ID">원천코드테이블ID</label></th>
<td id="layout-1_7_30"><input type=text  class="ub-control input-text " id="TABLE_ID" name="TABLE_ID"       value="<%=JspUtils.getDefaultValue(_dl_Code_selectCodeCategoryDetail, "TABLE_ID") %>"                style="text-align:left;width:100px;"></td>
<th id="layout-1_7_31"><label class="ub-control label"             for="CODE_COLUMN_ID">원천코드컬럼ID</label></th>
<td id="layout-1_7_32"><input type=text  class="ub-control input-text " id="CODE_COLUMN_ID" name="CODE_COLUMN_ID"       value="<%=JspUtils.getDefaultValue(_dl_Code_selectCodeCategoryDetail, "CODE_COLUMN_ID") %>"                style="text-align:left;width:100px;"></td>
<th id="layout-1_7_33"><label class="ub-control label"             for="NAME_COLUMN_ID">원천명칭컬럼ID</label></th>
<td id="layout-1_7_34"><input type=text  class="ub-control input-text " id="NAME_COLUMN_ID" name="NAME_COLUMN_ID"       value="<%=JspUtils.getDefaultValue(_dl_Code_selectCodeCategoryDetail, "NAME_COLUMN_ID") %>"                style="text-align:left;width:100px;"></td>
</tr>
</tbody>
</table>
 
<div class="ub-layout button bottom"><span class="ub-control button bottom icon" id="updateBtn">
    <a href="#none"><span></span>수정</a>
</span>
<span class="ub-control button bottom icon" id="deleteBtn">
    <a href="#none" title="Delete"><span></span>삭제</a>
</span>
</div>
</div>
<div class="ub-layout floatBox"><div class="ub-layout leftBox"   style="width:40%;"><h2 class="ub-control title">코드 그룹 정보<div class="ub-layout button inner"><span class="ub-control button inner icon" id="insertGroupBtn">
    <a href="#none" title="Add"><span class="ico-add"></span>그룹저장</a>
</span>
<span class="ub-control button inner icon" id="deleteGroupBtn">
    <a href="#none" title="Delete"><span class="ico-delete"></span>그룹삭제</a>
</span>
</div></h2>
<div class="ub-layout details"><table class="ub-control table normal ">
<colgroup>
<col />
<col />
</colgroup>
<tbody>
<tr id="layout-1_1">
<th id="layout-1_1_1"><label class="ub-control label">코드그룹ID</label></th>
<th id="layout-1_1_2"><label class="ub-control label">코드그룹명</label></th>
</tr>
<tr id="layout-1_2">
<td id="layout-1_2_3"><input type=text  class="ub-control input-text " id="CODE_GROUP_ID" name="CODE_GROUP_ID"                       style="text-align:left;width:100px;"></td>
<td id="layout-1_2_4"><input type=text  class="ub-control input-text " id="CODE_GROUP_NM" name="CODE_GROUP_NM"                       style="text-align:left;width:100px;"></td>
</tr>
</tbody>
</table>

</div>
<div class="ub-layout list"><div class="ub-control temp" style="border:2px solid gray;width:100%;height:300px;text-align:center;"><h3 style="padding-top:120px;">Grid Control</h3></div>
<table class="ub-control grid" id="list" name="list"></table> 
	
</div>
</div>
<div class="ub-layout rightBox"   style="width:59%;"><h2 class="ub-control title">코드 상세 정보<div class="ub-layout button inner"  style="text-align:right;"><span class="ub-control button inner icon" id="insertBtn">
    <a href="#none" title="Add"><span class="ico-add"></span>코드추가</a>
</span>
</div></h2>

<div class="ub-layout list"><div class="ub-control temp" style="border:2px solid gray;width:100%;height:300px;text-align:center;"><h3 style="padding-top:120px;">Grid Control</h3></div>
<table class="ub-control grid" id="list2" name="list2"></table> 
	
</div>
</div>
</div>
</form>

<!-- layout-1 End -->
<style>
 	.ub-control.title .ub-layout.button.inner{position:absolute;top:4px;right:0}
</style>

<script type="text/javascript">
uxl.onLoad(function(){
	
	uxl.bindComboCode('CONSTANT_REG_YN','FLAG_YN',{emptyOption:false});
	
	// 리스트
	$('#listBtn').click(function(){
		uxl.returnToList('SYS0002');
	});

	// 코드 등록 팝업창
	$('#insertBtn').click(function(){
		var listner = function(){};
		var url = uxl.getScreenURL('SYS0005') + '?CODE_CATEGORY_ID=' + $('#CODE_CATEGORY_ID').val();
		uxl.openWindow('Popup', url, { width:800 ,height:430 }, listner);		
	});
	
	// 코드 유형 수정
	$('#updateBtn').click(function(){
		updateCodeCategory();
	});
	
	// 코드 유형 삭제
	$('#deleteBtn').click(function(){
		deleteCodeCategory();
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
	
	// Dynamic 코드 조회
	$('#viewCodeBtn').click(function(){
		var listner = function(){};
		var url = uxl.getScreenURL('SYS0007') + '?CODE_CATEGORY_ID=' + $("#CODE_CATEGORY_ID").val();
		var option = {width:600,height:400};
		uxl.openWindow('Popup', url, option, listner);
	});
	
	// 코드맵핑사용여부
	$('input[name=MAPPING_YN]').change(function(){
			if($(this).val()=="Y"){
				if($('#CODE_TP').val()=="DN"){
					if(!$('label[for=TABLE_ID]').find('span').is('span')){
						originalRelativeShow();
					}
				}
			}else{
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
					uxl.openWindow('Popup', url, { width:800 ,height:430 }, listner);
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