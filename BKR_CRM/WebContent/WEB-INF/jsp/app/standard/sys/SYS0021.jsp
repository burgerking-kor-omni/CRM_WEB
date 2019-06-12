<%--
#*
 *  파 일 명 :  SYS0021.jsp
 *  설    명 :  사용자관리 목록 
 *  작 성 자 :  이동엽
 *  작 성 일 :  2013-06-03
 *  버    전 :  1.0
 *  기타사항 :
 *  Copyrights 2011 by ㈜ 유비원. All right reserved.
*#
--%>
<%@page import="com.ubone.framework.engine.domain.User"%>
<%@page import="com.ubone.framework.util.ViewUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/include/pageCommon.jsp" %>
<%@ page import="com.ubone.framework.util.UserUtil"%>
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
	DataList _dl_CD_BRANCH = ViewUtil.getResult().getDataList("Code.CD_BRANCH");
	DataList _dl_INCUMBENT_USER_CD = ViewUtil.getResult().getDataList("Code.INCUMBENT_USER_CD");
%>


<!--  ========================================================================
  This page is generated with the UB-META™ ver4.0 
 
   - PAGE ID : SYS0021R00
   - PAGE TYPE : JSP
 
  Copyright ⓒ UBONE Co., Ltd. All rights reserved.
 ========================================================================
--> 
<style>
	.ui-jqgrid-bdiv tr { cursor : pointer; }
</style>


<!-- layout-1 Start -->
<h1 class="ub-control title">사용자 관리</h1>
<div class="ub-layout search">
    <span class="search-ltbg"></span>
    <span class="search-rtbg"></span>
    <span class="search-lbbg"></span>
    <span class="search-rbbg"></span>
<span class="ub-control button search" id="search">
<a href="#none" title="Search">검색</a>
</span>
<form id="searchForm" name="searchForm"><table class="ub-control table normal ">
<colgroup>
<col width="120px"/>
<col width="150px"/>
<col width="80px"/>
<col width="150px"/>
<col width="80px"/>
<col width="150px"/>
<col width="80px"/>
<col />
</colgroup>
<tbody>
<tr id="layout-1_1">
<th id="layout-1_1_1"><label class="ub-control label">영업점</label></th>
<td id="layout-1_1_2" colspan=7>
	<select id="CD_BRANCH" name="CD_BRANCH" class="ub-control select "     style="width:120px;" size="1" datacid="CD_BRANCH" defaultvalue="${paramMap.CD_BRANCH}"></select>
	<select id="CD_TEAM" name="CD_TEAM" class="ub-control select "     style="width:120px;" size="1"  defaultvalue="${paramMap.CD_TEAM}"></select></td>
</tr>
<tr id="layout-1_2">
<th id="layout-1_2_3"><label class="ub-control label">재직여부</label></th>
<td id="layout-1_2_4"><select id="INCUMBENT_CD" name="INCUMBENT_CD" class="ub-control select "     style="width:120px;" size="1" datacid="INCUMBENT_USER_CD" defaultvalue="${paramMap.INCUMBENT_CD}"><%    if(!"전체".equals("")){        out.println("<OPTION VALUE=\"\">전체</OPTION>\r\n");    }    if(_dl_INCUMBENT_USER_CD != null){        for(int codeIdx=0; codeIdx < _dl_INCUMBENT_USER_CD.getRowCount(); codeIdx++){            String code = _dl_INCUMBENT_USER_CD.getString(codeIdx, ConstantHolder.CODE_COLUMN_CODE);            String name = _dl_INCUMBENT_USER_CD.getString(codeIdx, ConstantHolder.CODE_COLUMN_NAME);            String selected = code.equals(ViewUtil.getParameter().getValue("INCUMBENT_CD"))?"selected":"";            out.println("<option VALUE=\""+code+"\" "+selected+">"+name+"</option>\r\n");        }    }%></select></td>
<th id="layout-1_2_5" style='text-align:Right'><label class="ub-control label">이름</label></th>
<td id="layout-1_2_6"><input type=text  class="ub-control input-text " id="USER_NM" name="USER_NM"       value="${paramMap.USER_NM}"                style="text-align:left;width:100px;"></td>
<th id="layout-1_2_7" style='text-align:Right'><label class="ub-control label">ID</label></th>
<td id="layout-1_2_8"><input type=text  class="ub-control input-text " id="LOGIN_ID" name="LOGIN_ID"       value="${paramMap.LOGIN_ID}"                style="text-align:left;width:100px;"></td>
<th id="layout-1_2_9" style='text-align:Right'><label class="ub-control label">사번</label></th>
<td id="layout-1_2_10"><input type=text  class="ub-control input-text " id="EMP_NO" name="EMP_NO"       value="${paramMap.EMP_NO}"                style="text-align:left;width:100px;"></td>
</tr>
</tbody>
</table>
 
</form>

</div>
<div class="ub-layout list"><div class="ub-control temp" style="border:2px solid gray;width:100%;height:300px;text-align:center;"><h3 style="padding-top:120px;">Grid Control</h3></div>
<table class="ub-control grid" id="list" name="list"></table> 
	
</div>
<div class="ub-layout pagging"><div class="ub-control temp" style="border:2px solid gray;width:100%;height:30px;text-align:center;"><h3 style="padding-top:3px;">Paging Navigation</h3></div>
<div class="ub-control pagging" for="list" formId="searchForm" function="fnSearch"></div>
</div>
<div class="ub-layout button top"><span class="ub-control button top icon" id="newBtn">
    <a href="#none" title="신규등록"><span class="ico-register"></span>신규등록</a>
</span>
</div>

<!-- layout-1 End -->


<script type="text/javascript">

uxl.onLoad(function(){
	
// 	$('#txt_pass').hide();
	
	//$('#newBtn').hide();//신규등록버튼제거

//	$('#CD_BRANCH').val('${user.cdBranch}');
//	$('#CD_BRANCH').attr('disabled', true);
	uxl.bindComboCode('CD_BRANCH', 'CD_BRANCH', {emptyOption:'전체'});
	
//	uxl.chainCombo($('#CD_BRANCH'), $('#CD_TEAM') , 'CD_TEAM', {parameter : {PARENT_CODE:'${user.cdBranch}'}});
	uxl.chainCombo('CD_BRANCH', 'CD_TEAM', 'CD_TEAM', {emptyOption:'전체'});
// 	uxl.chainCombo('CD_BRANCH', 'CD_TEAM' , 'CD_TEAM', {emptyOption:'전체',PARENT_CODE:$('#CD_BRANCH').val()});

// 	$('#CD_BRANCH').change(function(){
// 		uxl.bindComboCode('CD_TEAM', 'CD_TEAM', {emptyOption:'전체',parameter:{PARENT_CODE:$('#CD_BRANCH').val()}});
// 	}).change();
	
	/*
	그리드 옵션
	colNames : 그리드 Header 정보,
	colModel : 그리드 Contents 의 바인딩 정보
	*/
	var options = {
		//header name
		colNames:['사번','USER_ID', 'ID','이름','직책', '부서', '핸드폰 번호', '이메일', '재직여부']

		//mapping column
		,colModel:[
				  {name:'EMP_NO',width:50, align:'center', hidden:true}
				 ,{name:'USER_ID',width:50, align:'center', hidden:true}
				 ,{name:'LOGIN_ID',width:50, align:'center'}
				 ,{name:'USER_NM',width:50, align:'center'}
				 ,{name:'DUTY_CD',width:50, align:'center' , codeCategory:'CD_DUTY' }
				 ,{name:'DEPT_NM',width:50, align:'center'}
				 ,{name:'MOBILE_NO',width:50, align:'center', formatter: setPhoneNo}
				 ,{name:'EMAIL_DS',width:50, align:'center'}
				 ,{name:'INCUMBENT_CD',width:50, codeCategory:'INCUMBENT_USER_CD', align:'center'}
			]
		,autowidth:true
		,rowNum: 10
		,height:290
		, onSelectRow: function(rowid){
			var selectedRow = $(this).getRowData(rowid);
			uxl.moveLocation(uxl.getScreenURL('SYS0211') + '?USER_ID='+selectedRow.USER_ID+ '&EMP_NO='+selectedRow.EMP_NO);
		}
	};
	uxl.grid('list', options);

	//조회 이벤트
	$('#search').click(function(event){
// 		uxl.grid.init('list');
		fnSearch();
	});
	
	//Enter Key 이벤트
	$('#USER_NM').keydown(function(event) {
		if(event.keyCode == '13') {
			fnSearch();
			return false;
		}
	});	
	
	$('#DEPT_NM').keydown(function(event) {
		if(event.keyCode == '13') {
			fnSearch();
			return false;
		}
	});
	
	//엔터키 검색 전체적용
	$('#searchForm').keydown(function(event) {
		if(event.keyCode == '13') {
			fnSearch();
			return false;
		}
	});
	
	//조회 이벤트
	$('#newBtn').click(function(event){
		fnRegist();
	});
});

//조회
function fnSearch(){
	//필수정보 체크
	var url = uxl.getFunctionUrl(_SCREEN_ID,'INQUIRY');
	var option = {
			  data: uxl.grid.getParam('list')
			, validator:function(data,targetForm){
					var returnVal = false;
					//필수항목체크
					if(uxl.checkRequiredFields(targetForm)){
						returnVal = true;
					}
					
					return returnVal;
			}
			/*
			 * 조회한 데이터를 그리드에 추가함.
			 * @param {String} 그리드로 변환할 테이블ID
			 * @param {Result} 조회된 데이터 객체 result
			 * @param {boolean} 데이터 추가시 기존데이터의 clear 여부
			 */
			, success:function(result){
				var rows = result.getDataList(0).rows;
				uxl.grid.appendData('list' ,result , true );
			}
			, async:true
	};
	uxl.callSubmitFunction('searchForm' , url , option );		
}

//신규사용자 등록
function fnRegist(){
// 	uxl.moveLocation(uxl.getScreenURL('SYS0148'));
	uxl.moveLocation(uxl.getScreenURL('SYS0149'));
}

// 전화번호 형식
function setPhoneNo(cellValue, options, rowdata, action){
	var formatNum = '';
    if(cellValue.length==11){
    	formatNum = cellValue.replace(/(\d{3})(\d{4})(\d{4})/, '$1-$2-$3');
    }else if(cellValue.length==8){
        formatNum = cellValue.replace(/(\d{4})(\d{4})/, '010-$1-$2');
    }else if(cellValue.length==10){
    	formatNum = cellValue.replace(/(\d{3})(\d{3})(\d{4})/, '$1-$2-$3');
    }if(cellValue.length==9){
        	formatNum = cellValue.replace(/(\d{2})(\d{3})(\d{4})/, '$1-$2-$3');
    }
    return formatNum;
	
}
</script>
