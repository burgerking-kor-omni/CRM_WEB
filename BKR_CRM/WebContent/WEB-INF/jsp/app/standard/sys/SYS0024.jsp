<%--
#*
 *  파 일 명 :  SYS0024.jsp
 *  설    명 :  담당업무 등록
 *  작 성 자 :  이준철
 *  작 성 일 :  2013-06-03
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
<%@ page import="java.util.Map"%>
<%@ page import="org.apache.commons.lang.StringUtils"%>
<%@ page import="com.ubone.ubmeta.page.util.JspUtils"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core"   prefix="c" %>
<%
	DataList _dataList = null;		/* List Table default dataTable */ 
	DataList _dl_FLAG_YN = ViewUtil.getResult().getDataList("Code.FLAG_YN");
	DataList _dl_STATUS = ViewUtil.getResult().getDataList("Code.STATUS");
%>


<!--  ========================================================================
  This page is generated with the UB-META™ ver4.0 
 
   - PAGE ID : SYS0024R00
   - PAGE TYPE : JSP
 
  Copyright ⓒ UBONE Co., Ltd. All rights reserved.
 ========================================================================
--> 


<!-- layout-1 Start -->
<h1 class="ub-control title">권한 등록</h1>
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
<th id="layout-1_1_1"><label class="ub-control label">권한코드</label></th>
<td id="layout-1_1_2">
	<input type=text  class="ub-control input-text " id="ROLE_ID" name="ROLE_ID" style="text-align:left;width:200px;">
	<span class="ub-control button inner" id="checkRoleIdBtn">
		<a href="#none" title="중복확인">중복확인</a>
	</span>
	<label id="checkResult"></label>
</td>
</tr>
<tr id="layout-1_2">
<th id="layout-1_2_1"><label class="ub-control label">권한명</label></th>
<td id="layout-1_2_2"><input type=text  class="ub-control input-text " id="ROLE_NAME" name="ROLE_NAME"                       style="text-align:left;width:200px;"></td>
</tr>
<tr id="layout-1_3">
<th id="layout-1_3_3"><label class="ub-control label">설명</label></th>
<td id="layout-1_3_4"><textarea class="ub-control textarea " id="DESCRIPTION" name="DESCRIPTION"       style="width:600px;" rows="5"                  rows="5"></textarea></td>
</tr>
<tr id="layout-1_4">
<th id="layout-1_4_5"><label class="ub-control label">현재상태</label></th>
<td id="layout-1_4_6"><select id="STATUS" name="STATUS" class="ub-control select "     style="width:120px;" size="1" datacid="STATUS"><%    if(!"선택안됨".equals("")){        out.println("<OPTION VALUE=\"\">선택안됨</OPTION>\r\n");    }    if(_dl_STATUS != null){        for(int codeIdx=0; codeIdx < _dl_STATUS.getRowCount(); codeIdx++){            String code = _dl_STATUS.getString(codeIdx, ConstantHolder.CODE_COLUMN_CODE);            String name = _dl_STATUS.getString(codeIdx, ConstantHolder.CODE_COLUMN_NAME);            out.println("<option VALUE=\""+code+"\">"+name+"</option>\r\n");        }    }%></select></td>
</tr>
</tbody>
</table>
 
</form>
</div>
<div class="ub-layout button bottom"><span class="ub-control button bottom icon" id="register">
    <a href="#none" title="Register"><span></span>등록</a>
</span>
</div>

<!-- layout-1 End -->


<script type="text/javascript">
var isCheckRoleId = false;

uxl.onLoad(function(){
	
   //목록화면으로 이동
	$('#listb').click(function(){
		uxl.returnToList('SYS0022');
	});
	
	//담당업무관리 등록
	$('#register').click(function(){
		fnRegister();
	});
	
	//ROLE_ID 중복체크
	$('#checkRoleIdBtn').click(function(){
		if(uxl.isEmpty($('#ROLE_ID').val())){
			uxl.showMessage('권한코드를 입력해 주세요.');
			$('#ROLE_ID').focus();
			return;
		}
		fnCheckRoleId();
	});
	
	// ROLD_ID 수정시 중복체크 상태 클리어
	$('#ROLE_ID').change(function(){
		isCheckRoleId = false;
		$('#checkResult').text('').css('color','');
	});

});

function fnRegister(){
	var url = uxl.getFunctionUrl(_SCREEN_ID, 'REGIST');
	var option = {
			data : {},
			validator:function(data,targetForm) {
				if(!isCheckRoleId){
					uxl.showMessage('권한ID 중복체크를 다시 확인해 주세요.');
					$('#ROLE_ID').focus();
					return false;
				}
				return uxl.checkRequiredFields(targetForm);
			},
			success : function(result) {
				var role_id = result.getResultKey();
				uxl.moveLocation(uxl.getScreenURL('SYS0023') + '?ROLE_ID='+role_id);
			},
			async : true,
			message : {
				 confirm : uxl.getMessage('@message.common.insert.confirm'),
				 success : uxl.getMessage('@message.common.insert.success'),
				 fail 	 : uxl.getMessage('@message.common.insert.fail')
			 }
		};
		uxl.callSubmitFunction('detailForm', url, option);
}

function fnCheckRoleId(){
	var url = uxl.getFunctionUrl(_SCREEN_ID, 'USERDEFINED1');
	var option = {
		data:{ROLE_ID:$('#ROLE_ID').val()}
	  , success:function(result) {
			var datalist = result.getDataList(0);
			if(datalist.rowCount > 0){
				isCheckRoleId = false;
				$('#checkResult').text('이미 존재하는 권한코드 입니다.').css('color','red');
				$('#ROLE_ID').focus();
			}else{
				isCheckRoleId = true;
				$('#checkResult').text('사용가능한 권한코드 입니다.').css('color','green');
			}
		}
	  , async:true
	};
	uxl.callFunction(url, option);
}
</script>