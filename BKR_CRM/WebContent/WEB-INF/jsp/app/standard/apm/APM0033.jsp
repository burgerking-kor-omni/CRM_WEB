<%--
#*
 *  파 일 명 :  APM0033.jsp
 *  설    명 :  서비스쿼리 상세(팝업)
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
	DataList _dl_QUERY_TYPE = ViewUtil.getResult().getDataList("Code.APMD_QUERY_TYPE");
	DataList _dl_ServiceManageInquiry_getServiceQueryDetail = ViewUtil.getResult().getDataList("ServiceManageInquiry.getServiceQueryDetail");
%>


<!--  ========================================================================
  This page is generated with the UB-META™ ver4.0 
 
   - PAGE ID : APM0033R00
   - PAGE TYPE : JSP
 
  Copyright ⓒ UBONE Co., Ltd. All rights reserved.
 ========================================================================
--> 


<!-- layout-1 Start -->
<h1 class="ub-control title">서비스쿼리 상세</h1>
<form id="detailForm" name="detailForm"><div class="ub-layout details"><table class="ub-control table normal ">
<colgroup>
<col width="150px"/>
<col />
</colgroup>
<tbody>
<tr id="layout-1_1">
<th id="layout-1_1_1"><label class="ub-control label"             for="QUERY_ID">쿼리 ID</label></th>
<td id="layout-1_1_2"><input type=text  class="ub-control input-text " id="QUERY_ID" name="QUERY_ID" maxLength="50" metalength="50"       value="${paramMap.QUERY_ID}"  readonly              style="text-align:left;width:300px;"><input type=hidden id="SERVICE_ID" name="SERVICE_ID"    value="${paramMap.SERVICE_ID}"></td>
</tr>
<tr id="layout-1_2">
<th id="layout-1_2_3"><label class="ub-control label"             for="QUERY_TYPE">쿼리유형</label></th>
<td id="layout-1_2_4"><select id="QUERY_TYPE" name="QUERY_TYPE" class="ub-control select "     style="width:314px;" size="1" datacid="APMD_QUERY_TYPE" defaultvalue="<%=JspUtils.getDefaultValue(_dl_ServiceManageInquiry_getServiceQueryDetail, "QUERY_TYPE") %>"     metaessential="1"><%    if(!"선택안됨".equals("")){        out.println("<OPTION VALUE=\"\">선택안됨</OPTION>\r\n");    }    if(_dl_QUERY_TYPE != null){        for(int codeIdx=0; codeIdx < _dl_QUERY_TYPE.getRowCount(); codeIdx++){            String code = _dl_QUERY_TYPE.getString(codeIdx, ConstantHolder.CODE_COLUMN_CODE);            String name = _dl_QUERY_TYPE.getString(codeIdx, ConstantHolder.CODE_COLUMN_NAME);            String selected = code.equals(JspUtils.getDefaultValue(_dl_ServiceManageInquiry_getServiceQueryDetail, "QUERY_TYPE"))?"selected":"";            out.println("<option VALUE=\""+code+"\" "+selected+">"+name+"</option>\r\n");        }    }%></select></td>
</tr>
<tr id="layout-1_3">
<th id="layout-1_3_5"><label class="ub-control label"             for="RUN_ORDER">실행순서</label></th>
<td id="layout-1_3_6"><input type=text  class="ub-control input-text " id="RUN_ORDER" name="RUN_ORDER" maxLength="2" metalength="2"      metaformat="99" value="<%=JspUtils.getDefaultValue(_dl_ServiceManageInquiry_getServiceQueryDetail, "RUN_ORDER") %>"                style="text-align:left;width:300px;"></td>
</tr>
<tr id="layout-1_4">
<th id="layout-1_4_7"><label class="ub-control label"             for="DATALIST_ID">DATALIST ID</label></th>
<td id="layout-1_4_8"><input type=text  class="ub-control input-text " id="DATALIST_ID" name="DATALIST_ID" maxLength="50" metalength="50"       value="<%=JspUtils.getDefaultValue(_dl_ServiceManageInquiry_getServiceQueryDetail, "DATALIST_ID") %>"                style="text-align:left;width:300px;"></td>
</tr>
</tbody>
</table>
 
<div class="ub-layout button bottom"><span class="ub-control button bottom icon" id="btnUpdate"        title="저장">
    <a href="#none" title="Save"><span class="ico-save"></span>저장</a>
</span>
</div>
</div>
</form>

<!-- layout-1 End -->


<script type="text/javascript">
uxl.onLoad(function(){

	$('#btnUpdate').click(function() {
		updateServiceQuery();
	});
	
});

function updateServiceQuery() {
	var url = uxl.getFunctionUrl(_SCREEN_ID, 'MODIFY');
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
		  	opener.fnSearch();
		  	window.close();
		}
	  , async:true
	  , message : {
			confirm : uxl.getMessage('@message.common.update.confirm'),
			success : uxl.getMessage('@message.common.update.success'),
			fail : uxl.getMessage('@message.common.update.fail')
		}
	};
	uxl.callSubmitFunction('detailForm', url, option);
}

	
</script>