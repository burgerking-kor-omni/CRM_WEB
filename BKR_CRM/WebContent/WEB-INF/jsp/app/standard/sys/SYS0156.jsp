<%--
#*
 *  파 일 명 :  SYS0156.jsp
 *  설    명 :  마스크관리 등록
 *  작 성 자 :  
 *  작 성 일 :  
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
	DataList _dl_TP_MASK = ViewUtil.getResult().getDataList("Code.TP_MASK");
%>


<!--  ========================================================================
  This page is generated with the UB-META™ ver4.0 
 
   - PAGE ID : SYS0156R00
   - PAGE TYPE : JSP
 
  Copyright ⓒ UBONE Co., Ltd. All rights reserved.
 ========================================================================
--> 


<!-- layout-1 Start -->
<h1 class="ub-control title">마스크 등록</h1>
<div class="ub-layout button top"></div>
<form id="registForm" name="registForm"><h2 class="ub-control title">기본정보</h2>
<div class="ub-layout details"><table class="ub-control table normal ">
<colgroup>
<col width="150px"/>
<col />
</colgroup>
<tbody>
<tr id="layout-1_1">
<th id="layout-1_1_1"><label class="ub-control label"             for="NM_MASK">마스크명</label></th>
<td id="layout-1_1_2"><input type=text  class="ub-control input-text " id="NM_MASK" name="NM_MASK"            metaessential="1"           style="text-align:left;width:300px;"></td>
</tr>
<tr id="layout-1_2">
<th id="layout-1_2_3"><label class="ub-control label"             for="TP_MASK">마스크유형</label></th>
<td id="layout-1_2_4"><select id="TP_MASK" name="TP_MASK" class="ub-control select "     style="width:314px;" size="1" datacid="TP_MASK"      metaessential="1"><%    if(!"선택안됨".equals("")){        out.println("<OPTION VALUE=\"\">선택안됨</OPTION>\r\n");    }    if(_dl_TP_MASK != null){        for(int codeIdx=0; codeIdx < _dl_TP_MASK.getRowCount(); codeIdx++){            String code = _dl_TP_MASK.getString(codeIdx, ConstantHolder.CODE_COLUMN_CODE);            String name = _dl_TP_MASK.getString(codeIdx, ConstantHolder.CODE_COLUMN_NAME);            out.println("<option VALUE=\""+code+"\">"+name+"</option>\r\n");        }    }%></select></td>
</tr>
<tr id="layout-1_3">
<th id="layout-1_3_5"><label class="ub-control label"             for="DS_INPUT">입력문자열</label></th>
<td id="layout-1_3_6"><input type=text  class="ub-control input-text " id="DS_INPUT" name="DS_INPUT"                       style="text-align:left;width:300px;"></td>
</tr>
<tr id="layout-1_4">
<th id="layout-1_4_7"><label class="ub-control label"             for="DS_OUTPUT">출력문자열</label></th>
<td id="layout-1_4_8"><input type=text  class="ub-control input-text " id="DS_OUTPUT" name="DS_OUTPUT"                       style="text-align:left;width:300px;"></td>
</tr>
<tr id="layout-1_5">
<th id="layout-1_5_9"><label class="ub-control label"             for="DS_CLASS">구현클래스</label></th>
<td id="layout-1_5_10"><input type=text  class="ub-control input-text " id="DS_CLASS" name="DS_CLASS"                       style="text-align:left;width:300px;"></td>
</tr>
</tbody>
</table>
 
</div>
</form>
<div class="ub-layout button bottom"><span class="ub-control button bottom icon" id="btnRegist">
    <a href="#none" title="등록"><span></span>등록</a>
</span>
<span class="ub-control button bottom icon" id="btnCancle">
    <a href="#none" title="취소"><span></span>취소</a>
</span>
</div>

<!-- layout-1 End -->


<script type="text/javascript">
uxl.onLoad(function(){	
	$('#btnRegist').click(function() {
		fnRegist();
	});
	
	$('#btnCancle').click(function() {
		uxl.returnToList(uxl.getScreenURL('SYS0154'));
	});
});

function fnRegist() {
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
		  	var param = "?ID_MASK="+result.getResultKey();
		  	uxl.moveLocation(uxl.getScreenURL('SYS0155')+param);
		}
	  , async:true
	  , message : {
		    confirm : uxl.getMessage('@message.common.insert.confirm'),
			success : uxl.getMessage('@message.common.insert.success'),
			fail : uxl.getMessage('@message.common.insert.fail')
		}
	};
	uxl.callSubmitFunction("registForm", url, option);
}

	
</script>