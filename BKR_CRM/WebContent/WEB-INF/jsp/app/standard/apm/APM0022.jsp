<%--
#*
 *  파 일 명 :  APM0022.jsp
 *  설    명 :  서비스관리 목록 (팝업)
 *  작 성 자 :  유기태
 *  작 성 일 :  2015.02.23
 *  버    전 :  1.0
 *  기타사항 :
 *  수정이력 :  2016-10-10 다국어 호환 작업 - by 이창섭
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
	DataList _dl_CALL_TYPE = ViewUtil.getResult().getDataList("Code.APMD_CALL_TYPE");
	DataList _dl_FLAG_YN = ViewUtil.getResult().getDataList("Code.FLAG_YN");
	DataList _dl_SERVICE_TYPE = ViewUtil.getResult().getDataList("Code.APMD_SERVICE_TYPE");
%>


<!--  ========================================================================
  This page is generated with the UB-META™ ver4.0 
 
   - PAGE ID : APM0022R00
   - PAGE TYPE : JSP
 
  Copyright ⓒ UBONE Co., Ltd. All rights reserved.
 ========================================================================
--> 


<!-- layout-1 Start -->
<h1 class="ub-control title"><ub:message code="title.APM0022.title" text="서비스 선택"/></h1>
<div class="ub-layout button top"></div>
<div class="ub-layout search">
    <span class="search-ltbg"></span>
    <span class="search-rtbg"></span>
    <span class="search-lbbg"></span>
    <span class="search-rbbg"></span>
<form id="searchForm" name="searchForm"><table class="ub-control table normal ">
<colgroup>
<col width="120px"/>
<col />
<col width="120px"/>
<col />
<col width="120px"/>
<col />
</colgroup>
<tbody>
<tr id="layout-1_1">
<th id="layout-1_1_1"><label class="ub-control label"><ub:message code="title.APM0022.title" text="분류"/></label></th>
<td id="layout-1_1_2"><select id="CATEGORY_CODE" name="CATEGORY_CODE" class="ub-control select "     style="width:120px;" size="1"  defaultvalue="${paramMap.CATEGORY_CODE}"></select></td>
<th id="layout-1_1_3"><label class="ub-control label">서비스유형</label></th>
<td id="layout-1_1_4"><select id="SERVICE_TYPE" name="SERVICE_TYPE" class="ub-control select "     style="width:120px;" size="1" datacid="APMD_SERVICE_TYPE" defaultvalue="${paramMap.SERVICE_TYPE}"><%    if(!"전체".equals("")){        out.println("<OPTION VALUE=\"\">전체</OPTION>\r\n");    }    if(_dl_SERVICE_TYPE != null){        for(int codeIdx=0; codeIdx < _dl_SERVICE_TYPE.getRowCount(); codeIdx++){            String code = _dl_SERVICE_TYPE.getString(codeIdx, ConstantHolder.CODE_COLUMN_CODE);            String name = _dl_SERVICE_TYPE.getString(codeIdx, ConstantHolder.CODE_COLUMN_NAME);            String selected = code.equals(ViewUtil.getParameter().getValue("SERVICE_TYPE"))?"selected":"";            out.println("<option VALUE=\""+code+"\" "+selected+">"+name+"</option>\r\n");        }    }%></select></td>
<th id="layout-1_1_5"><label class="ub-control label">호출유형</label></th>
<td id="layout-1_1_6"><select id="CALL_TYPE" name="CALL_TYPE" class="ub-control select "     style="width:120px;" size="1" datacid="APMD_CALL_TYPE" defaultvalue="${paramMap.CALL_TYPE}"><%    if(!"전체".equals("")){        out.println("<OPTION VALUE=\"\">전체</OPTION>\r\n");    }    if(_dl_CALL_TYPE != null){        for(int codeIdx=0; codeIdx < _dl_CALL_TYPE.getRowCount(); codeIdx++){            String code = _dl_CALL_TYPE.getString(codeIdx, ConstantHolder.CODE_COLUMN_CODE);            String name = _dl_CALL_TYPE.getString(codeIdx, ConstantHolder.CODE_COLUMN_NAME);            String selected = code.equals(ViewUtil.getParameter().getValue("CALL_TYPE"))?"selected":"";            out.println("<option VALUE=\""+code+"\" "+selected+">"+name+"</option>\r\n");        }    }%></select></td>
</tr>
<tr id="layout-1_2">
<th id="layout-1_2_7"><label class="ub-control label">서비스ID</label></th>
<td id="layout-1_2_8"><input type=text  class="ub-control input-text " id="SERVICE_ID" name="SERVICE_ID" maxLength="10" metalength="10"       value="${paramMap.SERVICE_ID}"                style="text-align:left;width:106px;"></td>
<th id="layout-1_2_9"><label class="ub-control label">서비스명</label></th>
<td id="layout-1_2_10"><input type=text  class="ub-control input-text " id="SERVICE_NAME" name="SERVICE_NAME"       value="${paramMap.SERVICE_NAME}"                style="text-align:left;width:106px;"></td>
<th id="layout-1_2_11"><label class="ub-control label">로그인 체크여부</label></th>
<td id="layout-1_2_12"><select id="LOGIN_CHECK_YN" name="LOGIN_CHECK_YN" class="ub-control select "     style="width:120px;" size="1" datacid="FLAG_YN" defaultvalue="${paramMap.LOGIN_CHECK_YN}"><%    if(!"전체".equals("")){        out.println("<OPTION VALUE=\"\">전체</OPTION>\r\n");    }    if(_dl_FLAG_YN != null){        for(int codeIdx=0; codeIdx < _dl_FLAG_YN.getRowCount(); codeIdx++){            String code = _dl_FLAG_YN.getString(codeIdx, ConstantHolder.CODE_COLUMN_CODE);            String name = _dl_FLAG_YN.getString(codeIdx, ConstantHolder.CODE_COLUMN_NAME);            String selected = code.equals(ViewUtil.getParameter().getValue("LOGIN_CHECK_YN"))?"selected":"";            out.println("<option VALUE=\""+code+"\" "+selected+">"+name+"</option>\r\n");        }    }%></select></td>
</tr>
</tbody>
</table>
 
<span class="ub-control button search" id="btnSearch"        title="검색">
<a href="#none" title="Search">검색</a>
</span>
</form>

</div>
<div class="ub-layout list"><div class="ub-control temp" style="border:2px solid gray;width:100%;height:300px;text-align:center;"><h3 style="padding-top:120px;">Grid Control</h3></div>
<table class="ub-control grid" id="list" name="list"></table> 
	
</div>
<div class="ub-layout pagging"><div class="ub-control temp" style="border:2px solid gray;width:100%;height:30px;text-align:center;"><h3 style="padding-top:3px;">Paging Navigation</h3></div>
<div class="ub-control pagging" for="list" formId="searchForm" function="fnSearch"></div>
</div>
<div class="ub-layout button bottom"><span class="ub-control button bottom icon" id="btnConfirm">
    <a href="#none" title="Add"><span class="ico-add"></span>확인</a>
</span>
</div>

<!-- layout-1 End -->


<script type="text/javascript">
uxl.onLoad(function(){
// 	hsqlData.getCategoryCode("CATEGORY_CODE", {blankOption:"전체"});
	uxl.bindComboCode('CATEGORY_CODE', 'CATEGORY_CODE', {emptyOption:'전체'});
	
	$('#btnConfirm').click(function() {
		var index = $("input[name='rdoService']").index($("input[name='rdoService']:checked"));
		var svcId = $("input[name='rdoService']:checked").val();
		var data = $('#list').jqGrid('getRowData', index);
		 
		if (uxl.isNull(svcId)) {
			alert(uxl.getMessage('@message.common.noselected'));
			return;
		} else {
			var returnData = {"SERVICE_ID" : svcId, "SERVICE_NAME" : data.SERVICE_NAME};

			uxl.pushToParent(returnData);
			self.close();
		}
	});
	
	/*
	그리드 옵션
	colNames : 그리드 Header 정보,
	colModel : 그리드 Contents 의 바인딩 정보
	*/
	
	var options = {
		//header name
		colNames:['선택', '분류', '서비스ID', '서비스명', '서비스 유형', '호출유형', '로그인 체크여부']
		//mapping column
	  , colModel:[
	  		{name:'radioButton', width:3,  align:'center', formatter:setRadioButton}
		  , {name:'CATEGORY_CODE',   width:10, align:'center'}
		  , {name:'SERVICE_ID',       width:10, align:'center'}
		  , {name:'SERVICE_NAME',       width:38, align:'left'}
		  , {name:'SERVICE_TYPE',     width:10, align:'center'}
		  , {name:'CALL_TYPE',    width:10, align:'center'}
		  , {name:'LOGIN_CHECK_YN',  width:15, align:'center'}
		]
	  , autowidth:true
	  , height:261
	  , multiselect:false
	  , onSelectRow: function(rowid){
		    $("input[name='rdoService']").removeAttr("checked");
			$("input[name='rdoService']")[rowid].checked = true;
		},loadComplete: function (gridData) {
			 $("#jqgh_list_radioButton").css("cursor", "default");
			 $("#jqgh_list_radioButton").removeClass("ui-jqgrid-sortable");
		}
	};
	uxl.grid('list', options);

	/* 
	//자동완성 기능
	uxl.autocomplete('SERVICE_ID', uxl.getFunctionUrl(_SCREEN_ID, 'USERDEFINED1') ,{
		minLength : 3
	  , itemExtractor : function(row) {
			var item = {
				id : row.SERVICE_ID
			  , value : row.SERVICE_NAME
			  , label : '[' + row.SERVICE_ID + ']  ' + row.SERVICE_NAME
			};
			return item;
		}
	  , select: function(event, ui) {
			$("#SERVICE_ID").val(ui.item.id);
			$("#SERVICE_NAME").val(ui.item.value);
			return false;
		}
	});

	//자동완성 기능
	uxl.autocomplete('SERVICE_NAME', uxl.getFunctionUrl(_SCREEN_ID, 'USERDEFINED1') ,{
		minLength : 3
	  , itemExtractor : function(row) {
			var item = {
				id : row.SERVICE_ID
			  , value : row.SERVICE_NAME
			  , label : '[' + row.SERVICE_ID + ']  ' + row.SERVICE_NAME
			};
			return item;
		}
	  , select: function(event, ui) {
			$("#SERVICE_ID").val(ui.item.id);
			$("#SERVICE_NAME").val(ui.item.value);
			return false;
		}
	}); */
	
	//조회 이벤트
	$('#btnSearch').click(function() {
		uxl.grid.init('list');
		fnSearch();
	});
	
	//Enter Key 이벤트
	$('#SERVICE_ID, #SERVICE_NAME').keydown(function(event) {
		if(event.keyCode == '13') {
			fnSearch();
			return false;
		}
	});
	
});

function setRadioButton(cellValue, opts, rowObject) {
	return "<input type='radio' name='rdoService' value='" + rowObject.SERVICE_ID + "'>";
}

//조회
function fnSearch() {
	//필수정보 체크
	var url = uxl.getFunctionUrl(_SCREEN_ID, 'INQUIRY');
	var option = {
		data:uxl.grid.getParam('list')
		
	    /*
		 * 조회한 데이터를 그리드에 추가함.
		 * @param {String} 그리드로 변환할 테이블ID
		 * @param {Result} 조회된 데이터 객체 result
		 * @param {boolean} 데이터 추가시 기존데이터의 clear 여부
		 */
	  , success:function(result) {
			uxl.grid.appendData('list', result, true);
		}
	  , async:true
	};
	uxl.callSubmitFunction('searchForm', url, option);		
}
</script>