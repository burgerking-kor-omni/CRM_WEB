<%--
#*
 *  파 일 명 :  SYS0023.jsp
 *  설    명 :  담당업무 목록 상세
 *  작 성 자 :  이준철
 *  작 성 일 :  2013-06-03
 *  버    전 :  1.0
 *  기타사항 :
 *  Copyrights 2011 by ㈜ 유비원. All right reserved.
*#
--%>
<%@page import="com.ubone.framework.util.ViewUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
	DataList _dl_POSITION_CD = ViewUtil.getResult().getDataList("Code.POSITION_CD");
	DataList _dl_ROLE_COMPOSITION_TYPE = ViewUtil.getResult().getDataList("Code.ROLE_COMPOSITION_TYPE");
	DataList _dl_STATUS = ViewUtil.getResult().getDataList("Code.STATUS");
	DataList _dl_TaskManageInquiry_getTaskDetail = ViewUtil.getResult().getDataList("TaskManageInquiry.getTaskDetail");
%>


<!--  ========================================================================
  This page is generated with the UB-META™ ver4.0 
 
   - PAGE ID : SYS0023R00
   - PAGE TYPE : JSP
 
  Copyright ⓒ UBONE Co., Ltd. All rights reserved.
 ========================================================================
--> 


<!-- layout-1 Start -->
<h1 class="ub-control title">담당업무관리</h1>
<div class="ub-layout button top"><span class="ub-control button top icon" id="listb">
    <a href="#none" title="목록"><span class="ico-list"></span>목록</a>
</span>
</div>
<h2 class="ub-control title">기본정보</h2>
<div class="ub-layout details"><form id="detailForm" name="detailForm"><table class="ub-control table normal ">
<colgroup>
<col width="15%"/>
<col />
</colgroup>
<tbody>
<tr id="layout-1_1">
<th id="layout-1_1_1"><label class="ub-control label">담당업무 권한명</label></th>
<td id="layout-1_1_2"><input type=text  class="ub-control input-text " id="ROLE_NAME" name="ROLE_NAME"       value="<%=JspUtils.getDefaultValue(_dl_TaskManageInquiry_getTaskDetail, "ROLE_NAME") %>"                style="text-align:left;width:200px;"><input type=hidden id="ROLE_ID" name="ROLE_ID"    value="<%=JspUtils.getDefaultValue(_dl_TaskManageInquiry_getTaskDetail, "ROLE_ID") %>"></td>
</tr>
<tr id="layout-1_2">
<th id="layout-1_2_3"><label class="ub-control label">설정</label></th>
<td id="layout-1_2_4"><textarea class="ub-control textarea " id="DESCRIPTION" name="DESCRIPTION"       style="width:600px;" rows="5"                  rows="5"><%=JspUtils.getDefaultValue(_dl_TaskManageInquiry_getTaskDetail, "DESCRIPTION") %></textarea></td>
</tr>
<tr id="layout-1_3">
<th id="layout-1_3_5"><label class="ub-control label">현재상태</label></th>
<td id="layout-1_3_6"><select id="STATUS" name="STATUS" class="ub-control select "     style="width:120px;" size="1" datacid="STATUS" defaultvalue="<%=JspUtils.getDefaultValue(_dl_TaskManageInquiry_getTaskDetail, "STATUS") %>"><%    if(!"".equals("")){        out.println("<OPTION VALUE=\"\"></OPTION>\r\n");    }    if(_dl_STATUS != null){        for(int codeIdx=0; codeIdx < _dl_STATUS.getRowCount(); codeIdx++){            String code = _dl_STATUS.getString(codeIdx, ConstantHolder.CODE_COLUMN_CODE);            String name = _dl_STATUS.getString(codeIdx, ConstantHolder.CODE_COLUMN_NAME);            String selected = code.equals(JspUtils.getDefaultValue(_dl_TaskManageInquiry_getTaskDetail, "STATUS"))?"selected":"";            out.println("<option VALUE=\""+code+"\" "+selected+">"+name+"</option>\r\n");        }    }%></select></td>
</tr>
<tr id="layout-1_4">
<th id="layout-1_4_7"><label class="ub-control label">관리자여부</label></th>
<td id="layout-1_4_8"><select id="ADMIN_YN" name="ADMIN_YN" class="ub-control select "     style="width:120px;" size="1" datacid="FLAG_YN" defaultvalue="<%=JspUtils.getDefaultValue(_dl_TaskManageInquiry_getTaskDetail, "ADMIN_YN") %>"><%    if(!"".equals("")){        out.println("<OPTION VALUE=\"\"></OPTION>\r\n");    }    if(_dl_FLAG_YN != null){        for(int codeIdx=0; codeIdx < _dl_FLAG_YN.getRowCount(); codeIdx++){            String code = _dl_FLAG_YN.getString(codeIdx, ConstantHolder.CODE_COLUMN_CODE);            String name = _dl_FLAG_YN.getString(codeIdx, ConstantHolder.CODE_COLUMN_NAME);            String selected = code.equals(JspUtils.getDefaultValue(_dl_TaskManageInquiry_getTaskDetail, "ADMIN_YN"))?"selected":"";            out.println("<option VALUE=\""+code+"\" "+selected+">"+name+"</option>\r\n");        }    }%></select></td>
</tr>
<tr id="layout-1_5">
<th id="layout-1_5_9"><label class="ub-control label">코드매핑여부</label></th>
<td id="layout-1_5_10"><select id="EXCEPT_MAP_YN" name="EXCEPT_MAP_YN" class="ub-control select "     style="width:120px;" size="1" datacid="FLAG_YN" defaultvalue="<%=JspUtils.getDefaultValue(_dl_TaskManageInquiry_getTaskDetail, "EXCEPT_MAP_YN") %>"><%    if(!"".equals("")){        out.println("<OPTION VALUE=\"\"></OPTION>\r\n");    }    if(_dl_FLAG_YN != null){        for(int codeIdx=0; codeIdx < _dl_FLAG_YN.getRowCount(); codeIdx++){            String code = _dl_FLAG_YN.getString(codeIdx, ConstantHolder.CODE_COLUMN_CODE);            String name = _dl_FLAG_YN.getString(codeIdx, ConstantHolder.CODE_COLUMN_NAME);            String selected = code.equals(JspUtils.getDefaultValue(_dl_TaskManageInquiry_getTaskDetail, "EXCEPT_MAP_YN"))?"selected":"";            out.println("<option VALUE=\""+code+"\" "+selected+">"+name+"</option>\r\n");        }    }%></select></td>
</tr>
</tbody>
</table>
 
</form>
</div>
<h2 class="ub-control title" id="List_Title" name="List_Title">담당업무권한구성</h2>
<div class="ub-layout list" id="List_Authority" name="List_Authority"><div class="ub-layout button inner gap01"  style="text-align:right;"><select id="ROLE_COMPOSITION_TYPE" name="ROLE_COMPOSITION_TYPE" class="ub-control select "     style="width:120px;" size="1" datacid="ROLE_COMPOSITION_TYPE"U'">
<%
    if(!"".equals("")){
        out.println("<OPTION VALUE=\"\"></OPTION>\r\n");
    }
    if(_dl_ROLE_COMPOSITION_TYPE != null){
        for(int codeIdx=0; codeIdx < _dl_ROLE_COMPOSITION_TYPE.getRowCount(); codeIdx++){
            String code = _dl_ROLE_COMPOSITION_TYPE.getString(codeIdx, ConstantHolder.CODE_COLUMN_CODE);
            String name = _dl_ROLE_COMPOSITION_TYPE.getString(codeIdx, ConstantHolder.CODE_COLUMN_NAME);
            String selected = code.equals('U')?"selected":"";
            out.println("<option VALUE=\""+code+"\" "+selected+">"+name+"</option>\r\n");
        }    }%>
</select>
<select id="POSITION_CD" name="POSITION_CD" class="ub-control select "     style="width:120px;" size="1" datacid="POSITION_CD">
<%
    if(!"".equals("")){
        out.println("<OPTION VALUE=\"\"></OPTION>\r\n");
    }
    if(_dl_POSITION_CD != null){
        for(int codeIdx=0; codeIdx < _dl_POSITION_CD.getRowCount(); codeIdx++){
            String code = _dl_POSITION_CD.getString(codeIdx, ConstantHolder.CODE_COLUMN_CODE);
            String name = _dl_POSITION_CD.getString(codeIdx, ConstantHolder.CODE_COLUMN_NAME);
            out.println("<option VALUE=\""+code+"\">"+name+"</option>\r\n");
        }    }%>
</select>
<span class="ub-control button inner icon" id="add">
    <a href="#none" title="Add"><span class="ico-add"></span>추가</a>
</span>
<span class="ub-control button inner icon" id="delete">
    <a href="#none" title="Delete"><span class="ico-delete"></span>삭제</a>
</span>
</div>
<div class="ub-control temp" style="border:2px solid gray;width:100%;height:300px;text-align:center;"><h3 style="padding-top:120px;">Grid Control</h3></div>
<table class="ub-control grid" id="list" name="list"></table> 
	
</div>
<div class="ub-layout pagging"><div class="ub-control temp" style="border:2px solid gray;width:100%;height:30px;text-align:center;"><h3 style="padding-top:3px;">Paging Navigation</h3></div>
<div id="paging" name="paging" class="ub-control pagging" for="list" formId="detailForm" function="fnSearch"></div>
</div>
<h2 class="ub-control title">변경이력</h2>
<div class="ub-layout details"><table class="ub-control table normal ">
<colgroup>
<col />
<col />
<col />
<col />
</colgroup>
<tbody>
<tr id="layout-1_1">
<th id="layout-1_1_1"><label class="ub-control label">최초등록일</label></th>
<td id="layout-1_1_2"><input type=text  class="ub-control input-text "       value="<%=JspUtils.getDefaultValue(_dl_TaskManageInquiry_getTaskDetail, "REG_DATETIME") %>"  readonly              style="text-align:left;width:150px;"></td>
<th id="layout-1_1_3"><label class="ub-control label">최초등록자</label></th>
<td id="layout-1_1_4"><input type=text  class="ub-control input-text "       value="<%=JspUtils.getDefaultValue(_dl_TaskManageInquiry_getTaskDetail, "REG_USER_ID") %>"  readonly              style="text-align:left;width:150px;"></td>
</tr>
<tr id="layout-1_2">
<th id="layout-1_2_5"><label class="ub-control label">최종수정일</label></th>
<td id="layout-1_2_6"><input type=text  class="ub-control input-text "       value="<%=JspUtils.getDefaultValue(_dl_TaskManageInquiry_getTaskDetail, "UPD_DATETIME") %>"  readonly              style="text-align:left;width:150px;"></td>
<th id="layout-1_2_7"><label class="ub-control label">최종수정자</label></th>
<td id="layout-1_2_8"><input type=text  class="ub-control input-text "       value="<%=JspUtils.getDefaultValue(_dl_TaskManageInquiry_getTaskDetail, "UPD_USER_ID") %>"  readonly              style="text-align:left;width:150px;"></td>
</tr>
</tbody>
</table>
 
</div>
<div class="ub-layout button bottom"><span class="ub-control button bottom icon" id="save">
    <a href="#none" title="Save"><span class="ico-save"></span>수정</a>
</span>
<span class="ub-control button bottom icon" id="remove">
    <a href="#none" title="Save"><span class="ico-save"></span>삭제</a>
</span>
</div>

<!-- layout-1 End -->


<script type="text/javascript">
	uxl.onLoad(function() {
		
		$('#ROLE_COMPOSITION_TYPE').change(function(){
			if(this.value == 'P'){
				$('#POSITION_CD').show();
			}else{
				$('#POSITION_CD').hide();
			}
		}).change();
		
		/*
		그리드 옵션
		colNames : 그리드 Header 정보,
		colModel : 그리드 Contents 의 바인딩 정보
		 */
		var options = {

			//header name
			colNames : [ '권한구성유형', '권한구성유형명', '권한구성코드', '권한구성명', '등록자ID', '등록자', '등록일' ]

			//mapping column
			,
			colModel : [ {
				name : 'ROLE_COMPOSITION_TYPE',
				width : 20,
				hidden : true
			},{
				name : 'ROLE_COMPOSITION_TYPE_NM',
				width : 80
			},{
				name : 'ROLE_COMPOSITION_CODE',
				width : 20,
				hidden : true
			},{
				name : 'ROLE_COMPOSITION_CODE_NM',
				width : 80
			},{
				name : 'REG_USER_ID',
				width : 20,
				hidden : true
			},{
				name : 'REG_USER_NM',
				width : 80
			},{
				name : 'REG_DATETIME',
				width : 80, 
				formatter:'date'
			} ],
			autowidth : true,
			multiselect : true,
			height : 231,
			rowNum : 10,
			onSelectRow : function(rowid) {

			}
		
		};
		uxl.grid('list', options);

		fnSearch();

		//목록화면으로 이동
		$('#listb').click(function() {
			uxl.returnToList('SYS0022');
		});

		//직원 팝업으로 이동
		$('#add').click(function() {
			var vtype = $('#ROLE_COMPOSITION_TYPE').val();
			if(vtype == 'U'){
				uxl.openWindow('empSearch', uxl.getScreenURL('POP0001'), {width : '750px' ,height : '592px' }, callBackUser);
			}else if(vtype == 'D'){
				uxl.openWindow('Popup', uxl.getScreenURL('POP0002'), { width:'425px' ,height:'578px' }, callBackDept);
			}else if(vtype == 'P'){
				callBackPosion($('#POSITION_CD').val());
			}
		});

		//저장(수정)
		$('#save').click(function() {
			fnSave();
		});


		//권한자 삭제
		$('#delete').click(function() {
			fnDeleteComposer();
		});
		
		//$('#List_Title').hide();
		//$('#List_Authority').hide();
		//$('#paging').hide();
		
		$('#remove').click(function() {
			fnRemoveTask();	
		});
		

	});
	
	//직원검색 callback Function
	function callBackUser(userData) {

		var url = uxl.getFunctionUrl(_SCREEN_ID, 'REGIST');
		var option = {
			//사용자 ID를 파라미터에 담는다.
			data : {
				"ROLE_COMPOSITION_TYPE" : 'U'
				,"ROLE_COMPOSITION_CODE" : userData.idUser
			},
			success : function(result) {
				result.getServiceMessage();
				uxl.reload();
			},
			async : true
		};
		uxl.callSubmitFunction('detailForm', url, option);

	}
	
	function callBackDept(deptData) {

		var url = uxl.getFunctionUrl(_SCREEN_ID, 'REGIST');
		var option = {
			//사용자 ID를 파라미터에 담는다.
			data : {
				"ROLE_COMPOSITION_TYPE" : 'D'
				,"ROLE_COMPOSITION_CODE" : deptData.idDept
			},
			success : function(result) {
				result.getServiceMessage();
				uxl.reload();
			},
			async : true
		};
		uxl.callSubmitFunction('detailForm', url, option);

	}
	
	function callBackPosion(position) {

		var url = uxl.getFunctionUrl(_SCREEN_ID, 'REGIST');
		var option = {
			//사용자 ID를 파라미터에 담는다.
			data : {
				"ROLE_COMPOSITION_TYPE" : 'P'
				,"ROLE_COMPOSITION_CODE" : position
			},
			success : function(result) {
				result.getServiceMessage();
				uxl.reload();
			},
			async : true
		};
		uxl.callSubmitFunction('detailForm', url, option);

	}
	//조회
	function fnSearch() {
		//필수정보 체크
		var url = uxl.getFunctionUrl(_SCREEN_ID, 'INQUIRY');
		var option = {
			data : uxl.grid.getParam('list')

			/*
			 * 조회한 데이터를 그리드에 추가함.
			 * @param {String} 그리드로 변환할 테이블ID
			 * @param {Result} 조회된 데이터 객체 result
			 * @param {boolean} 데이터 추가시 기존데이터의 clear 여부
			 */
			,
			success : function(result) {
				uxl.grid.appendData('list', result, true);
				//opener.uxl.reload();
			},
			async : true
		};
		uxl.callSubmitFunction('detailForm', url, option);
	}
	
	//저장
	function fnSave() {
		//필수정보 체크
		var url = uxl.getFunctionUrl(_SCREEN_ID, 'USERDEFINED1');
		var option = {
			data : uxl.grid.getParam('list')
			,
			success : function(result) {
				uxl.moveLocation('SYS0022');
			},
			async : true
			, message : {
				 confirm : uxl.getMessage('@message.common.insert.confirm'),
				 success : uxl.getMessage('@message.common.insert.success'),
				 fail : uxl.getMessage('@message.common.insert.fail')
			  }
		};
		uxl.callSubmitFunction('detailForm', url, option);
	}

	//권한관련자 삭제
	function fnDeleteComposer() {
		var rowids = $('#list').jqGrid('getGridParam', 'selarrrow');

		//체크박스에 선택된 rowdata가 없을 경우 예외처리
		if (rowids.length == null || rowids.length == '0') {
			alert("삭제할 권한자를 선택하세요");
			return;
		}
		var rowdatas = new Array(rowids.length);
		var compoCode = new Array(rowids.length);
		for ( var i = 0; i < rowids.length; i++) {
			rowdatas[i] = $('#list').jqGrid('getRowData', rowids[i]);
			compoCode[i] = rowdatas[i].ROLE_COMPOSITION_CODE;
		}

		var url = uxl.getFunctionUrl(_SCREEN_ID, 'REMOVE');
		var option = {
			data : {
				'compoCodes' : compoCode
			},
			success : function(result) {
				uxl.reload();
			},
			async : true,
			message : {
				confirm : uxl.getMessage('@message.common.delete.confirm'),
				success : uxl.getMessage('@message.common.delete.success'),
				fail : uxl.getMessage('@message.common.delete.fail')
			}

		};
		uxl.callSubmitFunction('detailForm', url, option);
	}
	
	//권한관련자 삭제
	function fnRemoveTask() {
		
		var url = uxl.getFunctionUrl(_SCREEN_ID, 'USERDEFINED2');
		var option = {
			data : {}
			, success : function(result) {
				uxl.moveLocation('SYS0022');
			},
			async : true,
			message : {
				confirm : uxl.getMessage('@message.common.delete.confirm'),
				success : uxl.getMessage('@message.common.delete.success'),
				fail : uxl.getMessage('@message.common.delete.fail')
			}

		};
		uxl.callSubmitFunction('detailForm', url, option);
	}
</script>
