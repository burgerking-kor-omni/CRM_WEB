<%--
#*
 *  파 일 명 : VOC0005.jsp
 *  설    명 :  VOC유형 별 이메일 발송 대상 관리
 *  작 성 자 :  황민국
 *  작 성 일 :  2019.03.15
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
<style>
	.ui-jqgrid-bdiv tr { cursor : pointer; }
	.ui-jqgrid tr.jqgrow td { text-overflow: ellipsis;-o-text-overflow: ellipsis; }
</style>
<script type="text/javascript">

uxl.onLoad(function(){
	<%-- init --%>
	fnInit();
	<%-- event bind --%>
	fnEventBind();
});

<%-- init --%>
function fnInit(){
	<%-- 저장, 삭제 레이아웃 hide --%>
	$("#bottomLayout").hide();
	<%-- 그리드 그리기 --%>
	fnDrawGrid();
	<%-- 목록 조회 --%>
	fnSearch();
}
<%-- event bind --%>
function fnEventBind(){
	<%-- 더블클릭 시 초기화 --%>
	$('#searchForm').find("input, select").dblclick(function(){
		$(this).val(null);	
	});
	<%-- 폼 Enter시 조회 --%>
	$('#searchForm').keydown(function() {
	    if (event.keyCode === 13) {
	    	fnSearch();
	    }
	});
	<%-- 검색버튼 클릭 --%>
	$("#searchBtn").click(function(){
		fnSearch();
	});
	<%-- 등록버튼 클릭 --%>
	$('#registBtn').click(function(){
		fnEmailTargetRegist();
	});
	<%-- 수정버튼 클릭 --%>
	$('#saveBtn').click(function(){
		fnEmailTargetUpdate();
	});
	<%-- 삭제버튼 클릭 --%>
	$('#deleteBtn').click(function(){
		fnEmailTargetDelete();
	});
	<%-- 설명 TextArea 작성 가능 글자수 체크 --%>
	$('#DS_TARGET').keyup(function (e){
	    var content = $(this).val();
	    if (content.length > 100){
	        alert("최대 100자까지 입력 가능합니다.");
	        $(this).val(content.substring(0, 100));
	    }
	});

}

<%-- draw grid list --%>
function fnDrawGrid(){
	
	<%-- 이메일 발송 대상 목록 그리드 옵션 --%>
	var listOptions = {
			colNames:['ID_TARGET','이름','이메일','등록일','등록자','수정일','수정자','설명']
		  , colModel:[
				{name:'ID_TARGET', hidden:true}
			  , {name:'NM_TARGET', width:120, align:'center'}
			  , {name:'DS_EMAIL', width:255, align:'center'}
			  , {name:'DT_REG', width:115, align:'center'}
			  , {name:'NM_REG_USER', width:120, align:'center'}
			  , {name:'DT_UPT', hidden:true}
			  , {name:'NM_UPT_USER', hidden:true}
			  , {name:'DS_TARGET', hidden:true}
			]
		  /* , autowidth:true  */
		  , height : 580
		  , multiselect : true
		  , onSelectRow : function(rowId, iCol, cellContent, e) {
				<%-- 선택 값 초기화 --%>
				$('#list').resetSelection();
	 	    	$('#list').setSelection(rowId,false);
			  	<%-- 선택된 row data --%>
			  	var selectedRow = $(this).getRowData(rowId);
			  	<%-- 대상ID --%>
				var id_target = selectedRow.ID_TARGET;          
				<%-- VOC유형 별 상세 정보 조회 --%>
				fnDetailList(id_target);
		    }
		};
	
	<%-- 유형 별 상세 정보 그리드 옵션 --%>
	var listDtlOptions = {
			colNames:['ID_TARGET','CD_TARGET_VALUE','유형','참조여부','사용여부','등록일','등록자','수정일','수정자']
		  , colModel:[
				{name:'ID_TARGET', hidden:true}
			  , {name:'CD_TARGET_VALUE', hidden:true}
			  , {name:'CD_TARGET', width:220, align:'center'}
			  , {name:'FG_CC', width:165, align:'center', formatter : fnFgCcFormatter}
			  , {name:'FG_USE', width:165, align:'center', formatter : fnFgUseFormatter}
			  , {name:'DT_REG', width:93, align:'center', hidden:true}
			  , {name:'NM_REG_USER', width:93, align:'center', hidden:true}
			  , {name:'DT_UPT', hidden:true}
			  , {name:'NM_UPT_USER', hidden:true}
			]
		  , height : 400
		  , multiselect : false
		};
	
	uxl.grid('list', listOptions);
	uxl.grid('detailList', listDtlOptions);	
}

<%-- 참조 여부 formatter --%>
function fnFgCcFormatter(cellValue, options, rowObject){
	var yCheckValue =(cellValue == "Y")?'checked="checked"':'';
	var nCheckValue =(uxl.isEmpty(cellValue) || cellValue == "N")?'checked="checked"':'';
	var html = ''
			 + '<input class="ub-control radio readonly" type="radio" id="FG_CC_'+options.rowId+'" name="FG_CC_'+options.rowId+'" value="Y" '+yCheckValue+' />'
			 + '<label> Y</label>'
			 + '&nbsp;&nbsp;&nbsp;&nbsp;'
			 + '<input class="ub-control radio readonly" type="radio" id="FG_CC_'+options.rowId+'" name="FG_CC_'+options.rowId+'" value="N" '+nCheckValue+' />'
			 + '<label> N</label>';
	return html;
}

<%-- 사용 여부 formatter --%>
function fnFgUseFormatter(cellValue, options, rowObject){
	var yCheckValue =(cellValue == "Y")?'checked="checked"':'';
	var nCheckValue =(uxl.isEmpty(cellValue) || cellValue == "N")?'checked="checked"':'';
	var html = ''
		 + '<input class="ub-control radio readonly" type="radio" id="FG_USE_'+options.rowId+'" name="FG_USE_'+options.rowId+'" value="Y" '+yCheckValue+' />'
		 + '<label> Y</label>'
		 + '&nbsp;&nbsp;&nbsp;&nbsp;'
		 + '<input class="ub-control radio readonly" type="radio" id="FG_USE_'+options.rowId+'" name="FG_USE_'+options.rowId+'" value="N" '+nCheckValue+' />'
		 + '<label> N</label>';
	return html;
}

<%-- 이메일 발송 대상 목록 조회 --%>
function fnSearch(registYn){
	var url = uxl.getFunctionUrl(_SCREEN_ID,'INQUIRY');
	var option = {
		  data:{
			  pageSize : 20
		  }	
		, success:function(result){
			<%-- 우측 상세 정보 초기화 --%>
			fnRightLayoutReset();
			<%-- data append --%>
			uxl.grid.appendData('list', result, true);
			<%-- 등록 이후에 조회 시 신규데이터에 대해 첫번째 로우 선택 (목록 정렬 기준이 이름, 등록일) --%>
			if(uxl.isNotEmpty(registYn) && uxl.isNotUndefined(registYn)){
				$('#list').jqGrid("setSelection", 0);
			}
		}
		, async:true
	};
	uxl.callSubmitFunction('searchForm', url, option);
}

<%-- VOC유형 별 상세 조회 --%>
function fnDetailList(id_target, listDetailSync){
	var url = uxl.getFunctionUrl(_SCREEN_ID,'USERDEFINED1');
	var option = {
		  data:{
			ID_TARGET : id_target				  
		  }	
		, success:function(result){
			<%-- uxl.grid.appendData('detailList', result, true); --%>
			<%-- 우측 상세 정보 초기화 --%>
			fnRightLayoutReset();
			<%-- 상세 기본정보 조회 --%>
			var dl = result.getDataList('EmailTargetManage.getEmailTargetList');
			var dlRows = dl.rows[0];
			$("#ID_TARGET").val(dlRows.ID_TARGET);
			$("#NM_TARGET").val(dlRows.NM_TARGET);
			$("#DS_EMAIL").val(dlRows.DS_EMAIL);
			$("#DT_REG").val(dlRows.DT_REG);
			$("#NM_REG_USER").val(dlRows.NM_REG_USER);
			$("#DT_UPT").val(dlRows.DT_UPT);
			$("#NM_UPT_USER").val(dlRows.NM_UPT_USER);
			$("#DS_TARGET").val(dlRows.DS_TARGET);
			<%-- 
				* 목록 데이터와 상세 정보 싱크 
				 -상세 기본정보 수정 후 우측 상세정보 데이터는 refresh 하지만
				   좌측 목록에 보여지는 기본정보는 refresh가 안된다.수정된 rowid를 가지고 다시 선택 시켜주는 방법이 있지만,
				   이는 페이징 내용을 고려 한다면 비효율적이라 판단되어 아래와 같이 진행함.
			--%>
			if(listDetailSync == "Y"){
				var $selector = $("#list");
				var selectedRowId = $selector.jqGrid('getGridParam','selrow');
				$selector.jqGrid('setCell', selectedRowId, 'NM_TARGET', dlRows.NM_TARGET);
				$selector.jqGrid('setCell', selectedRowId, 'DS_EMAIL', dlRows.DS_EMAIL);
				$selector.jqGrid('setCell', selectedRowId, 'DS_TARGET', dlRows.DS_TARGET);
				$selector.jqGrid('setCell', selectedRowId, 'NM_REG_USER', dlRows.NM_REG_USER);
			}
			<%-- 유형 별 상세 정보 목록 조회 --%>
			var $grid = $("#detailList");
			var gridRowCount = $grid.getGridParam("reccount");
			var listDl = result.getDataList('EmailTargetManage.getEmailTargetDetailList');
			var rowCount = listDl.rowCount;
			$grid.jqGrid("clearGridData");
			uxl.grid.init($grid);
			for(var i =0; i < rowCount ;  i++){
				$grid.jqGrid('addRowData',i+gridRowCount,listDl.rows[i]);
			}
			uxl.grid.initPaging($grid, result);
			<%-- 저장, 삭제 레이아웃 show --%>
			$("#bottomLayout").show();
		}
		, async:true
	};
	uxl.callFunction(url, option);
}

<%-- 이메일 발송 대상 등록 --%>
function fnEmailTargetRegist(){
	var url = uxl.getFunctionUrl(_SCREEN_ID,'REGIST');
	var option = {
		success:function(result){
			<%-- 등록 후 조회 전 검색조건 초기화 --%>
			$("#NM_TARGET_SEARCH, #DS_EMAIL_SEARCH").val("");
			<%-- 이메일 발송 대상 목록 조회 --%>
			fnSearch("Y");
		}
		, async:true
	};
	uxl.callFunction(url, option);
}

<%-- 이메일 발송 대상 관리 수정 --%>
function fnEmailTargetUpdate(){
	<%-- 유형 별 상세정보 목록 정보 배열 반환 함수 --%>
	var jsonData = fnCreateArrayData();
	var url = uxl.getFunctionUrl(_SCREEN_ID,'MODIFY');
	var option = {
		  data:{
			  ARRAY_DATA : JSON.stringify(jsonData) 
		  }	
		, validator:function(data,targetForm){
			var returnVal = false;
			<%-- 필수항목체크 --%>
			if(uxl.checkRequiredFields(targetForm)){
				returnVal = true;
			}else{
				returnVal = false;
				return false;
			}
			<%-- 이메일 형식 확인 --%>
			if(uxl.isEmail($("#DS_EMAIL").val())){
				returnVal = true;
			}else{
				alert("이메일 형식을 확인해주세요");
				<%-- 컨트롤 백그라운드 컬러 변경 --%>
				$("#DS_EMAIL").addClass("ui-state-error");
				returnVal = false;
				return false;
			}
			return returnVal;
		}
		, success:function(result){
			var id_target = $("#ID_TARGET").val();
			<%-- 유형 별 상세 정보 목록 조회 --%>
			fnDetailList(id_target,"Y");
		}
		, async:true
		, message : {
			  confirm : uxl.getMessage('@message.common.confirm','수정'),
			  success : uxl.getMessage('@message.common.success','수정'),
			  fail : uxl.getMessage('@message.common.fail','수정')
		}
	};
	uxl.callSubmitFunction('detailForm', url, option);
}

<%-- 이메일 발송 대상 관리 삭제 --%>
function fnEmailTargetDelete(){
	var id_target_val = $("#ID_TARGET").val();
	var url = uxl.getFunctionUrl(_SCREEN_ID,'REMOVE');
	var option = {
		  data:{
			ID_TARGET : id_target_val
		  }	
		, validator:function(data,targetForm){
			var returnVal = false;
			<%-- ID_TARGET 값 체크 --%>
			if(uxl.isNotEmpty(id_target_val)){
				returnVal = true;	
			}else{
				alert("선택값을 확인해주세요.");
			}
			return returnVal;
		}
		, success:function(result){
			<%-- 이메일 발송 대상 목록 조회 --%>
			fnSearch();
		}
		, async:true
		, message : {
			  confirm : uxl.getMessage('@message.common.confirm','삭제'),
			  success : uxl.getMessage('@message.common.success','삭제'),
			  fail : uxl.getMessage('@message.common.fail','삭제')
		}
	};
	uxl.callFunction(url, option);
}

<%-- 유형 별 상세 정보 목록 배열 생성 --%>
function fnCreateArrayData(){
	var $list = $('#detailList');
	var rowData = $list.getRowData();
	var rowDataIds = $list.getDataIDs();
	var size = rowData.length;
	var idsSize = rowDataIds.length;
	var array = new Array();
	var arrayCnt = 0;
	for(var i=0; i<idsSize; i++){
		var id_target = $("#ID_TARGET").val();
	    var obj = new Object();
	    var rowDtData = rowData[i];
	    var cd_target_value = rowDtData.CD_TARGET_VALUE;
	    var cd_target = rowDtData.CD_TARGET;
	    var fg_cc = $('input[name="FG_CC_'+rowDataIds[i]+'"]:checked').val();
	    var fg_use = $('input[name="FG_USE_'+rowDataIds[i]+'"]:checked').val();
	    obj["YN_ADD"] = (fg_cc == "Y" || fg_use == "Y")?"Y":"N";	//데이터 추가 여부
	    obj["ID_TARGET"] = id_target;
	    obj["CD_TARGET"] = cd_target_value;
	    obj["CD_TARGET_TEXT"] = cd_target;
	    obj["FG_CC"] = fg_cc;
	    obj["FG_USE"] = fg_use;
	    array[arrayCnt] = obj;
	    arrayCnt++;
	}
	return array;
}

<%-- 우측 상세정보 초기화 --%>
function fnRightLayoutReset(){
	<%-- 기본정보 컨트롤 초기화 --%>
	var $layoutSelector = $("#detailLayout").find("input, textarea"); 
	$layoutSelector.val("");
	<%-- 유형 별 상세 그리드 목록 초기화 --%>
	uxl.grid.clearGridData("detailList");
	<%-- 컨트롤 백그라운드 컬러 초기화 --%>
	$layoutSelector.removeClass("ui-state-error");
	<%-- 저장, 삭제 레이아웃 hide --%>
	$("#bottomLayout").hide();
}

</script>