<%--
#*
 *  파 일 명 :  SYS0213.jsp
 *  설    명 :  부서관리(사용자등록)
 *  작 성 자 :  이동엽
 *  작 성 일 :  2014-04-2
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
	DataList _dl_INCUMBENT_USER_CD = ViewUtil.getResult().getDataList("Code.INCUMBENT_USER_CD");
%>


<!--  ========================================================================
  This page is generated with the UB-META™ ver4.0 
 
   - PAGE ID : SYS0213R00
   - PAGE TYPE : JSP
 
  Copyright ⓒ UBONE Co., Ltd. All rights reserved.
 ========================================================================
--> 


<!-- layout-1 Start -->
<h1 class="ub-control title">사용자 등록</h1>
<div class="ub-layout button top"></div>
<div class="ub-layout details"><form id="detailForm" name="detailForm"><table class="ub-control table normal ">
<colgroup>
<col width="15%"/>
<col width="40%"/>
<col width="15%"/>
<col />
</colgroup>
<tbody>
<tr id="layout-1_1">
<th id="layout-1_1_1"><label class="ub-control label"             for="USER_NM">이름</label></th>
<td id="layout-1_1_2" colspan=3><input type=text  class="ub-control input-text " id="USER_NM" name="USER_NM"            metaessential="1"           style="text-align:left;width:120px;"></td>
</tr>
<tr id="layout-1_2">
<th id="layout-1_2_3"><label class="ub-control label"             for="LOGIN_ID">ID</label></th>
<td id="layout-1_2_4"><input type=text  class="ub-control input-text " id="LOGIN_ID" name="LOGIN_ID"            metaessential="1"           style="text-align:left;width:120px;"><span class="ub-control button inner icon" id="checkBtn">    <a href="#none" title="Add"><span class="ico-add"></span>중복확인</a></span><label id="dupAlertMsg" name="dupAlertMsg" class="ub-control label"     style="color:red;"></label></td>
<th id="layout-1_2_5"><label class="ub-control label"             for="PASSWD">비밀번호</label></th>
<td id="layout-1_2_6"><input type=password  class="ub-control input-text " id="PASSWD" name="PASSWD"     style="width:120px;"        metaessential="1"></td>
</tr>
<tr id="layout-1_3">
<th id="layout-1_3_7"><label class="ub-control label"             for="CD_ROLE">사용자권한</label></th>
<td id="layout-1_3_8" colspan=3><select id="CD_ROLE" name="CD_ROLE" class="ub-control select "     style="width:120px;" size="1"       metaessential="1"></select></td>
</tr>
<tr id="layout-1_4">
<th id="layout-1_4_9"><label class="ub-control label"             for="DEPT_NM">부서</label></th>
<td id="layout-1_4_10" colspan=3><input type=text  class="ub-control input-text " id="DEPT_NM" name="DEPT_NM"         readonly   metaessential="1"           style="text-align:left;width:100px;"><input type=hidden id="DEPT_ID" name="DEPT_ID"><a href="#none" title="search" class="ub-control button imgBtn img-search" id="searchDept" name="searchDept"><span>@@</span></a></td>
</tr>
<tr id="layout-1_5">
<th id="layout-1_5_11"><label class="ub-control label"             for="MOBILE_NO">핸드폰 번호</label></th>
<td id="layout-1_5_12"><input type=text  class="ub-control input-text " id="MOBILE_NO" name="MOBILE_NO"                       style="text-align:left;width:120px;"></td>
<td id="layout-1_5_13" colspan=2></td>
</tr>
<tr id="layout-1_6">
<th id="layout-1_6_14"><label class="ub-control label"             for="EMAIL_DS">이메일</label></th>
<td id="layout-1_6_15"><input type=text  class="ub-control input-text " id="EMAIL_DS" name="EMAIL_DS"                       style="text-align:left;width:200px;"></td>
<td id="layout-1_6_16" colspan=2></td>
</tr>
<tr id="layout-1_7">
<th id="layout-1_7_17"><label class="ub-control label"             for="INCUMBENT_CD">재직구분</label></th>
<td id="layout-1_7_18"><select id="INCUMBENT_CD" name="INCUMBENT_CD" class="ub-control select "     style="width:120px;" size="1" datacid="INCUMBENT_USER_CD"      metaessential="1"><%    if(!"선택".equals("")){        out.println("<OPTION VALUE=\"\">선택</OPTION>\r\n");    }    if(_dl_INCUMBENT_USER_CD != null){        for(int codeIdx=0; codeIdx < _dl_INCUMBENT_USER_CD.getRowCount(); codeIdx++){            String code = _dl_INCUMBENT_USER_CD.getString(codeIdx, ConstantHolder.CODE_COLUMN_CODE);            String name = _dl_INCUMBENT_USER_CD.getString(codeIdx, ConstantHolder.CODE_COLUMN_NAME);            out.println("<option VALUE=\""+code+"\">"+name+"</option>\r\n");        }    }%></select></td>
<th id="layout-1_7_19"><label class="ub-control label">수관기능</label></th>
<td id="layout-1_7_20"><input class="ub-control input-checkbox" type="checkbox" id="btnfgrecv" name="btnfgrecv"     value="Y"><label></label></input><input type=hidden id="FG_RECV" name="FG_RECV"></td>
</tr>
</tbody>
</table>
 
</form>
<div class="ub-layout button bottom"><span class="ub-control button bottom icon" id="btnRegist">
    <a href="#none" title="Save"><span class="ico-save"></span>등록</a>
</span>
</div>
</div>

<!-- layout-1 End -->


<script type="text/javascript">
uxl.onLoad(function(){
	
	uxl.bindComboCode('CD_ROLE', 'CD_ROLE', {parameter : {}, emptyOption:'전체'});
	
	uxl.bindComboCode('CD_BRANCH', 'CD_BRANCH_REPORT', {parameter : {CD_BRANCH:'1999010110000000000'}, emptyOption:'선택안됨'});
	uxl.chainCombo($('#CD_BRANCH'), $('#CD_TEAM'), 'CD_TEAM', {emptyOption:'전체'});
	
	$('#btnRegist').click(function(){
		if(fnCheckPwd($('#PASSWD').val())){
			fnRegist();
		}
	});
	
	$('#btnList').click(function(){
		uxl.returnToList('SYS0021');
	});
	
	//부서검색팝업화면호출
	$('#deptPop').click(function(event) {
		uxl.openWindow('Popup', uxl.getScreenURL('POP0002'), { width:'425px' ,height:'578px' }, callBackRegDept);
	});
	
	
	/**
	  계정ID 중복체크
	*/
	$('#checkBtn').click(function(){
		fnCheck();
	});
	
	$('#searchDept').click(function(){
		uxl.openWindow('deptSearchPop', uxl.getScreenURL('POP0002'), { width:'425px' ,height:'578px' }, callBackRegDept);
	});
	
	
	$('#LOGIN_ID').keyup(function(){
		$('#dupAlertMsg').text('');
	});
	
	/**
	  비밀번호 확인
	$('#PASSWD_CFM').keyup(function(){
		if(this.value == $('#PASSWD').val()){
			$('#pwdConfirmMsg').text('');
		}else{
			$('#pwdConfirmMsg').text('비밀번호가 일치하지 않습니다.');	
		}
	});
	*/
	
});

/**
function callBackRegDept(deptData){
	$('#DEPT_NM').val(deptData.nmDept);
	$('#DEPT_ID').val(deptData.idDept);
}
*/



function fnRegist(){
	
	if($('input[name=btnfgrecv]:checked').val() == 'Y'){
		$('#FG_RECV').val('Y');
	}else{
		$('#FG_RECV').val('N');
	}
	
	var url = uxl.getFunctionUrl(_SCREEN_ID, 'REGIST');
	var option = {
		data:{}
	  , validator:function(data,targetForm) {
			var returnVal = false;
			//필수항목체크
			if(uxl.checkRequiredFields(targetForm)) {
				returnVal = true;
			}
			return returnVal;
		}
	  , success:function(result) {
		  	var successFlag = "Y";
			uxl.pushToParent(successFlag);
			self.close();
		}
	  , async:true
	  , message : {
		     confirm : uxl.getMessage('@message.common.confirm','저장'),
			 success : uxl.getMessage('@message.common.success','저장'),
			 fail : uxl.getMessage('@message.common.fail','저장')
		}
	  
	};
	uxl.callSubmitFunction('detailForm', url, option);
}

function fnCheck(){
	var url = uxl.getFunctionUrl(_SCREEN_ID,'CHECK');
	var option = {
			  data: {}
			, validator:function(data,targetForm){
					var returnVal = false;
					if($('#LOGIN_ID').val().length > 0){
						returnVal = true;
					}else{
						$('#LOGIN_ID').focus();
					}
					return returnVal;
			}
			, success:function(result){
				var duplicationCnt = result.getDataList(0).rows[0].DUP_CNT;
				if( duplicationCnt > 0 ){
					$('#dupAlertMsg').text('이미 사용중인 계정입니다.');
				}else{
					$('#dupAlertMsg').text('사용가능한 계정입니다.');
				}
			}
			, async:true
	};
	uxl.callSubmitFunction('detailForm' , url , option );		
}


function fnCheckPwd(pwd){
	var returnb = false;
	if ( 7 < pwd.length &&  pwd.length < 10){ //8자리 이상
		returnb = validationPwd_8(pwd);
		if(!returnb){
			alert('비밀번호는 영문+숫자+기호 중 3가지 이상으로 구성되어야 합니다. ');
		}
		return returnb;
	}else if(pwd.length > 9){  //10자리 이상
		returnb = validationPwd_10(pwd);
		if(!returnb){
			alert('비밀번호는 영문+숫자+기호 중 2가지 이상으로 구성되어야 합니다. ');
		}
		return returnb;
	}else{
		alert('비밀번호는 최소 8자리 이상이어야 합니다.');
		return false;
	} 
}

function validationPwd_10(pwd){
	var regx =/^.*(?=.{10,20})(?=.*[0-9])(?=.*[a-zA-Z]).*$/;
	return regx.test(pwd);
}

function validationPwd_8(pwd){
	var regx =/^.*(?=.{8,10})(?=.*[0-9])(?=.*[a-zA-Z])(?=.*[!@#$%^*+=-]).*$/;
	return regx.test(pwd);
}

function callBackRegDept(deptData){
	$('#DEPT_NM').val(deptData.nmDept);
	$('#DEPT_ID').val(deptData.idDept);
}

</script>