<%--
#*
 *  파 일 명 :  APM0064.jsp
 *  설    명 :  코드 상세(다국어용)
 *  작 성 자 :  김병기
 *  작 성 일 :  2016-09-30
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
	DataList _dl_Code_selectCode = ViewUtil.getResult().getDataList("CodeML.selectCode");
	DataList _dl_STATUS = ViewUtil.getResult().getDataList("Code.STATUS");
%>


<!--  ========================================================================
  This page is generated with the UB-META™ ver5.0 
 
   - PAGE ID : APM0064R00
   - PAGE TYPE : JSP
 
  Copyright ⓒ UBONE Co., Ltd. All rights reserved.
 ========================================================================
--> 


<!-- layout-1 Start -->
<h1 class="ub-control title">코드 상세</h1>
<div class="ub-layout "><h2 class="ub-control title">코드 정보</h2>
</div>
<form id="insertForm" name="insertForm"><div class="ub-layout details"><table class="ub-control table normal ">
<colgroup>
<col />
<col />
</colgroup>
<tbody>
<tr id="layout-1_1">
<th id="layout-1_1_1"><label class="ub-control label"             for="CODE">코드</label></th>
<td id="layout-1_1_2"><input type=text  class="ub-control input-text " id="CODE" name="CODE"       value="<%=JspUtils.getDefaultValue(_dl_Code_selectCode, "CODE") %>"  readonly   metaessential="1"           style="text-align:left;width:100px;"><input type=hidden id="CODE_CATEGORY_ID" name="CODE_CATEGORY_ID"    value="<%=JspUtils.getDefaultValue(_dl_Code_selectCode, "CODE_CATEGORY_ID") %>"></td>
</tr>
<tr id="layout-1_2">
<th id="layout-1_2_3"><label class="ub-control label"             for="CODE_NAME">코드명</label></th>
<td id="layout-1_2_4"><ub:message-column id="CODE_NAME" table="SYS_CODE" column="RES_ID" essential="true" style="width:100px;" value='<%=JspUtils.getDefaultValue(_dl_Code_selectCode, "CODE_NAME") %>' resId='<%=JspUtils.getDefaultValue(_dl_Code_selectCode, "RES_ID") %>' /></td>
</tr>
<tr id="layout-1_3">
<th id="layout-1_3_5"><label class="ub-control label"             for="STATUS">상태</label></th>
<td id="layout-1_3_6"><ub:code-select id="STATUS" codeCategory="STATUS" style="width:120px;" essential="true" defaultValue='<%=JspUtils.getDefaultValue(_dl_Code_selectCode, "STATUS") %>' /></td>
</tr>
<tr id="layout-1_4">
<th id="layout-1_4_7"><label class="ub-control label"             for="SORT_ORDER">정렬순서</label></th>
<td id="layout-1_4_8"><input type=text  class="ub-control input-text " id="SORT_ORDER" name="SORT_ORDER"       value="<%=JspUtils.getDefaultValue(_dl_Code_selectCode, "SORT_ORDER") %>"     metaessential="1"           style="text-align:left;width:100px;"></td>
</tr>
<tr id="layout-1_5">
<th id="layout-1_5_9"><label class="ub-control label">상위코드</label></th>
<td id="layout-1_5_10"><input type=text  class="ub-control input-text " id="PARENT_CODE" name="PARENT_CODE"       value="<%=JspUtils.getDefaultValue(_dl_Code_selectCode, "PARENT_CODE") %>"                style="text-align:left;width:100px;"></td>
</tr>
<tr id="layout-1_6">
<th id="layout-1_6_11"><label class="ub-control label">코드설명</label></th>
<td id="layout-1_6_12"><textarea class="ub-control textarea " id="CODE_DS" name="CODE_DS"       style="width:600px;" rows="5"                  rows="5"><%=JspUtils.getDefaultValue(_dl_Code_selectCode, "CODE_DS") %></textarea></td>
</tr>
</tbody>
</table>
 
<div class="ub-layout button bottom"><span class="ub-control button inner icon" id="updateBtn">
    <a href="#none"><span class="ico-register"></span>수정</a>
</span>
</div>
</div>
</form>

<!-- layout-1 End -->


<script type="text/javascript">
uxl.onLoad(function(){
	
	// 코드 수정
	$('#updateBtn').click(function(){
		var parameter ={
			CATEGORY_ID:$('#CODE_CATEGORY_ID').val()	
		};
		updateCode(parameter);
	});
});	

//코드 수정
function updateCode(parameter){
	var url = uxl.getFunctionUrl(_SCREEN_ID,'MODIFY');
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
				opener.selectCode();
				this.close();	
			}
			, async:true
			, message : {
				 confirm : uxl.getMessage('@message.common.update.confirm'),
				 success : uxl.getMessage('@message.common.update.success'),
				 fail : uxl.getMessage('@message.common.update.fail')
			  }
			
	};
	uxl.callSubmitFunction('insertForm' , url , option );
}
</script>