<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.ubone.framework.util.ViewUtil"%>
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
%>


<!--  ========================================================================
  This page is generated with the UB-META™ ver4.0 
 
   - PAGE ID : ALM0001
   - PAGE TYPE : JSP
 
  Copyright ⓒ UBONE Co., Ltd. All rights reserved.
 ========================================================================
--> 


<!-- layout-1 Start -->
<h1 class="ub-control title">알리미 발송</h1>
<div class="ub-layout details">
<form id="registForm" name="registForm">
<table class="ub-control table normal ">
<colgroup>
<col />
<col />
</colgroup>
<tbody>
<tr id="layout-1_1">
<th id="layout-1_1_1"><label class="ub-control label">제목</label></th>
<td id="layout-1_1_2"><input type=text  class="ub-control input-text " id="TITLE" name="TITLE" style="text-align:left;width:600px;"></td>
</tr>
<tr id="layout-1_2">
<th id="layout-1_2_3"><label class="ub-control label">내용</label></th>
<td id="layout-1_2_4"><textarea class="ub-control textarea" id="CONTENTS" name="CONTENTS" style="width:600px;" rows="7" rows="7"></textarea></td>
</tr>
<tr id="layout-1_3">
<th id="layout-1_3_5"><label class="ub-control label">LINK주소</label></th>
<td id="layout-1_3_6"><input type=text  class="ub-control input-text " id="URL" name="URL" style="text-align:left;width:600px;"></td>
</tr>
</tbody>
</table>
</form>
</div>
<div class="ub-layout button bottom"><span class="ub-control button bottom icon" id="save">
    <a href="#none" title="Save"><span class="ico-save"></span>발송</a>
</span>
</div>
<!-- layout-1 End -->



<script type="text/javascript">
uxl.onLoad(function() {
	
	$('#URL').val('http://www.naver.com');
	
	$('#URL').dblclick(function(){   $(this).val(''); }); 
	
	$('#save').click(function() {
		callbackData();
	});
})


function callbackData(){
	
    var contents = $('#CONTENTS').val();
    var title = $('#TITLE').val();
    var url = $('#URL').val();
    
	var returnData = {
		 "CONTENTS" : contents
		,"TITLE" : title
	    ,"URL" : url 
	};
	uxl.pushToParent(returnData);
	self.close();	
}



</script>
