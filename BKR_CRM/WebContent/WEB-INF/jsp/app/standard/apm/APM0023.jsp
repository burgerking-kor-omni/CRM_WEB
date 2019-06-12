<%--
#*
 *  파 일 명 :  APM0023.jsp
 *  설    명 :  화면관리 목록 (팝업)
 *  작 성 자 :  유기태
 *  작 성 일 :  2015.02.23
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
	DataList _dl_FLAG_YN = ViewUtil.getResult().getDataList("Code.FLAG_YN");
	DataList _dl_SCREEN_TYPE = ViewUtil.getResult().getDataList("Code.APMD_SCREEN_TYPE");
	DataList _dl_SCREEN_VIEW_TYPE = ViewUtil.getResult().getDataList("Code.APMD_SCREEN_VIEW_TYPE");
%>


<!--  ========================================================================
  This page is generated with the UB-META™ ver4.0 
 
   - PAGE ID : APM0023R00
   - PAGE TYPE : JSP
 
  Copyright ⓒ UBONE Co., Ltd. All rights reserved.
 ========================================================================
--> 


<!-- layout-1 Start -->
<h1 class="ub-control title">화면 선택</h1>
<div class="ub-layout button top"></div>
<form id="searchForm" name="searchForm"><div class="ub-layout search">
    <span class="search-ltbg"></span>
    <span class="search-rtbg"></span>
    <span class="search-lbbg"></span>
    <span class="search-rbbg"></span>
<table class="ub-control table normal ">
<colgroup>
<col />
<col />
<col />
<col />
<col />
<col />
</colgroup>
<tbody>
<tr id="layout-1_1">
<th id="layout-1_1_1"><label class="ub-control label">분류</label></th>
<td id="layout-1_1_2"><select id="CATEGORY_CODE" name="CATEGORY_CODE" class="ub-control select "     style="width:120px;" size="1"></select></td>
<th id="layout-1_1_3"><label class="ub-control label">화면ID</label></th>
<td id="layout-1_1_4"><input type=text  class="ub-control input-text " id="SCREEN_ID" name="SCREEN_ID" maxLength="7" metalength="7"                       style="text-align:left;width:106px;"></td>
<th id="layout-1_1_5"><label class="ub-control label">화면명</label></th>
<td id="layout-1_1_6"><input type=text  class="ub-control input-text " id="SCREEN_NAME" name="SCREEN_NAME"                       style="text-align:left;width:106px;"></td>
</tr>
<tr id="layout-1_2">
<th id="layout-1_2_7"><label class="ub-control label">화면유형</label></th>
<td id="layout-1_2_8"><select id="SCREEN_TYPE" name="SCREEN_TYPE" class="ub-control select "     style="width:120px;" size="1" datacid="APMD_SCREEN_TYPE"><%    if(!"전체".equals("")){        out.println("<OPTION VALUE=\"\">전체</OPTION>\r\n");    }    if(_dl_SCREEN_TYPE != null){        for(int codeIdx=0; codeIdx < _dl_SCREEN_TYPE.getRowCount(); codeIdx++){            String code = _dl_SCREEN_TYPE.getString(codeIdx, ConstantHolder.CODE_COLUMN_CODE);            String name = _dl_SCREEN_TYPE.getString(codeIdx, ConstantHolder.CODE_COLUMN_NAME);            out.println("<option VALUE=\""+code+"\">"+name+"</option>\r\n");        }    }%></select></td>
<th id="layout-1_2_9"><label class="ub-control label">View유형</label></th>
<td id="layout-1_2_10"><select id="VIEW_TYPE" name="VIEW_TYPE" class="ub-control select "     style="width:120px;" size="1" datacid="APMD_SCREEN_VIEW_TYPE"><%    if(!"전체".equals("")){        out.println("<OPTION VALUE=\"\">전체</OPTION>\r\n");    }    if(_dl_SCREEN_VIEW_TYPE != null){        for(int codeIdx=0; codeIdx < _dl_SCREEN_VIEW_TYPE.getRowCount(); codeIdx++){            String code = _dl_SCREEN_VIEW_TYPE.getString(codeIdx, ConstantHolder.CODE_COLUMN_CODE);            String name = _dl_SCREEN_VIEW_TYPE.getString(codeIdx, ConstantHolder.CODE_COLUMN_NAME);            out.println("<option VALUE=\""+code+"\">"+name+"</option>\r\n");        }    }%></select></td>
<th id="layout-1_2_11"><label class="ub-control label">로그인 체크여부</label></th>
<td id="layout-1_2_12"><select id="LOGIN_CHECK_YN" name="LOGIN_CHECK_YN" class="ub-control select "     style="width:120px;" size="1" datacid="FLAG_YN" defaultvalue="${paramMap.LOGIN_CHECK_YN}"><%    if(!"전체".equals("")){        out.println("<OPTION VALUE=\"\">전체</OPTION>\r\n");    }    if(_dl_FLAG_YN != null){        for(int codeIdx=0; codeIdx < _dl_FLAG_YN.getRowCount(); codeIdx++){            String code = _dl_FLAG_YN.getString(codeIdx, ConstantHolder.CODE_COLUMN_CODE);            String name = _dl_FLAG_YN.getString(codeIdx, ConstantHolder.CODE_COLUMN_NAME);            String selected = code.equals(ViewUtil.getParameter().getValue("LOGIN_CHECK_YN"))?"selected":"";            out.println("<option VALUE=\""+code+"\" "+selected+">"+name+"</option>\r\n");        }    }%></select></td>
</tr>
</tbody>
</table>
 
<span class="ub-control button search" id="search">
<a href="#none" title="Search">검색</a>
</span>

</div>
</form>
<div class="ub-layout list"><div class="ub-control temp" style="border:2px solid gray;width:100%;height:300px;text-align:center;"><h3 style="padding-top:120px;">Grid Control</h3></div>
<table class="ub-control grid" id="list" name="list"></table> 
	
</div>
<div class="ub-layout pagging"><div class="ub-control temp" style="border:2px solid gray;width:100%;height:30px;text-align:center;"><h3 style="padding-top:3px;">Paging Navigation</h3></div>
<div id="page" name="page" class="ub-control pagging" for="list" formId="searchForm" function="fnSearch"></div>
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
		var index = $("input[name='rdoScreen']").index($("input[name='rdoScreen']:checked"));
		var scrnId = $("input[name='rdoScreen']:checked").val();
		var data = $('#list').jqGrid('getRowData', index);

		if (uxl.isNull(scrnId)) {
			alert(uxl.getMessage('@message.common.noselected'));
			return;
		} else {
			var returnData = {"SCREEN_ID" : scrnId, "SCREEN_NAME" : data.SCREEN_NAME};

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
		colNames:[
            '선택'
          , '분류'
	      , '화면ID'
	      , '화면명'
	      , '화면유형'
	      , 'View유형'
	      , '로그인 체크여부'
        ]

		//mapping column
	  , colModel:[
	  		{name:'radioButton',  width:3,  align:'center', formatter:setRadioButton}
		  , {name:'CATEGORY_CODE',    width:10, align:'center'}
		  , {name:'SCREEN_ID',       width:10, align:'center'}
		  , {name:'SCREEN_NAME',       width:38, align:'left'}
		  , {name:'SCREEN_TYPE',     width:10, align:'center'}
		  , {name:'VIEW_TYPE', width:10, align:'center'}
		  , {name:'LOGIN_CHECK_YN',  width:15, align:'center'}
		]
	  , autowidth:true
	  , multiselect:false
	  , onSelectRow: function(rowid){
		    $("input[name='rdoScreen']").removeAttr("checked");
			$("input[name='rdoScreen']")[rowid].checked = true;
		},loadComplete: function (gridData) {
			 $("#jqgh_list_radioButton").css("cursor", "default");
			 $("#jqgh_list_radioButton").removeClass("ui-jqgrid-sortable");
		}
	};
	
	uxl.grid('list', options);

	/* //자동완성 기능
	uxl.autocomplete('SCREEN_ID', uxl.getFunctionUrl(_SCREEN_ID,'USERDEFINED1'), {
			minLength : 3,
			itemExtractor : function(row) {
				var item = {
					value : row.SCREEN_ID,
					label : '[' + row.SCREEN_ID + ']  ' + row.SCREEN_NAME
				};
				return item;
			},
			select: function(event, ui) {
				$("#SCREEN_ID").val(ui.item.id);
				$("#SCREEN_NAME").val(ui.item.value);
				return false;
			}
		});
		
		uxl.autocomplete('SCREEN_NAME', uxl.getFunctionUrl(_SCREEN_ID,'USERDEFINED1'), {
			itemExtractor : function(row) {
				var item = {
					id : row.SCREEN_ID,
					value : row.SCREEN_NAME,
					label : row.SCREEN_NAME + ' [' + row.SCREEN_ID + ']'
				};
				return item;
			},
			select: function(event, ui) {
				$("#SCREEN_ID").val(ui.item.id);
				$("#SCREEN_NAME").val(ui.item.value);
				return false;
			}
		}); */
	
	//조회 이벤트
	$('#search').click(function() {
		uxl.grid.init('list');
		fnSearch();
	});
		
	//Enter Key 이벤트
	$('#SCREEN_ID, #SCREEN_NAME').keydown(function(event) {
		if(event.keyCode == '13') {
			fnSearch();
			return false;
		}
	});
	
});

function setRadioButton(cellValue, opts, rowObject) {
	return "<input type='radio' name='rdoScreen' value='" + rowObject.SCREEN_ID + "'>";
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