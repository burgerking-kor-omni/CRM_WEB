<%--
#*
*  파 일 명	: APM0068.jsp
*  작 성 자	: 관리자
*  작 성 일	: 2017년 10월 31일
*  버    전	: 1.0
*  기타사항	: 
*  Copyrights 2011 by ㈜ 유비원. All right reserved.
*#
--%>


<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/include/pageCommon.jsp" %>
<%@ page import="com.ubone.framework.data.DataList"%>
<%@ page import="com.ubone.framework.util.ViewUtil"%>
<%@ page import="com.ubone.framework.ConfigHolder"%>
<%@ page import="com.ubone.framework.ConstantHolder"%>
<%@ page import="com.ubone.framework.util.UserUtil"%>
<%@ include file="/WEB-INF/jsp/include/pageTagLibs.jsp"%>
<%@ page import="com.ubone.framework.data.Parameter"%>
<%@ page import="java.util.Map"%>
<%@ page import="org.apache.commons.lang.StringUtils"%>
<%@ page import="com.ubone.ubmeta.page.util.JspUtils"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core"   prefix="c" %>
<%
	DataList _dl_ScreenManageInquiry_getProjectPath = ViewUtil.getResult().getDataList("ScreenManageInquiry.getProjectPath");
%>


<!-- layout-1 Start -->
<h1 class="ub-control title">화면 복사</h1>
<div class="ub-layout details"><form id="copyForm" name="copyForm"><table class="ub-control table normal " id="SCREEN_TABLE">
<colgroup>
<col width="150px"/>
<col width="474px"/>
<col width="150px"/>
<col width="411px"/>
</colgroup>
<tbody>
<tr id="layout-1_1">
<th id="layout-1_1_1"><label class="ub-control label"             for="CATEGORY_CODE"><ub:message code="label.APM.category" text="분류"/></label></th>
<td id="layout-1_1_2"><select id="CATEGORY_CODE" name="CATEGORY_CODE" class="ub-control select "     style="width:200px;" size="1"       metaessential="1"></select></td>
<th id="layout-1_1_3"><label class="ub-control label"             for="SCREEN_ID"><ub:message code="label.APM.screen.id" text="화면ID"/></label></th>
<td id="layout-1_1_4"><input type=text  class="ub-control input-text " id="SCREEN_ID" name="SCREEN_ID" maxLength="7" metalength="7"            metaessential="1"           style="text-align:left;width:186px;"><input type=hidden id="SELECT_VALUE" name="SELECT_VALUE"><label id="lblMessage" name="lblMessage" class="ub-control label">ID체크 레이블</label><input type=hidden id="PARENT_SCREEN_ID" name="PARENT_SCREEN_ID"></td>
</tr>
<tr id="layout-1_2">
<th id="layout-1_2_5"><label class="ub-control label"             for="SCREEN_TYPE"><ub:message code="label.APM.screen.type" text="화면 유형"/></label></th>
<td id="layout-1_2_6"><select id="SCREEN_TYPE" name="SCREEN_TYPE" class="ub-control select "     style="width:200px;" size="1"       metaessential="1"></select></td>
<th id="layout-1_2_7"><label class="ub-control label"             for="LAYOUT_TYPE"><ub:message code="label.APM.layout.type" text="레이아웃 유형"/></label></th>
<td id="layout-1_2_8"><select id="LAYOUT_TYPE" name="LAYOUT_TYPE" class="ub-control select "     style="width:200px;" size="1"       metaessential="1"></select></td>
</tr>
<tr id="layout-1_3">
<th id="layout-1_3_9"><label class="ub-control label"             for="VIEW_TYPE"><ub:message code="label.APM.view.type" text="View 유형"/></label></th>
<td id="layout-1_3_10"><select id="VIEW_TYPE" name="VIEW_TYPE" class="ub-control select "     style="width:200px;" size="1"       metaessential="1"></select></td>
<th id="layout-1_3_11"><label class="ub-control label"             for="LOGIN_CHECK_YN"><ub:message code="label.APM.login.check.yn" text="로그인 체크 여부"/></label></th>
<td id="layout-1_3_12"><input class="ub-control input-checkbox" type="checkbox" id="LOGIN_CHECK_YN" name="LOGIN_CHECK_YN"    checked><label></label></input></td>
</tr>
<tr id="layout-1_4">
<th id="layout-1_4_13" class="meta_id"><label class="ub-control label"             for="PID"><ub:message code="label.APM.meta.id" text="메타ID"/></label></th>
<td id="layout-1_4_14" class="meta_id" colspan=3><select id="PID" name="PID" class="ub-control select "     style="width:414px;" size="1"       metaessential="1"></select></td>
</tr>
<tr id="layout-1_5">
<th id="layout-1_5_15"><label class="ub-control label"        class="value_jsp"     for="SCREEN_NAME"><ub:message code="label.APM.screen.name" text="화면명"/></label></th>
<td id="layout-1_5_16" colspan=3><input type=text  class="ub-control input-text " id="SCREEN_NAME" name="SCREEN_NAME"            metaessential="1"           style="text-align:left;width:400px;"></td>
</tr>
<tr id="layout-1_6">
<th id="layout-1_6_17"><label class="ub-control label"             for="FILE_PATH"><ub:message code="label.APM.file.path" text="파일경로"/></label></th>
<td id="layout-1_6_18" colspan=3><input type=text  class="ub-control input-text " id="FILE_PATH" name="FILE_PATH"            metaessential="1"           style="text-align:left;width:400px;"></td>
</tr>
<tr id="layout-1_7">
<th id="layout-1_7_19"><label class="ub-control label"             for="FILE_NAME"><ub:message code="label.APM.file.name" text="파일명"/></label></th>
<td id="layout-1_7_20" colspan=3><input type=text  class="ub-control input-text " id="FILE_NAME" name="FILE_NAME"            metaessential="1"           style="text-align:left;width:400px;"></td>
</tr>
<tr id="layout-1_8">
<th id="layout-1_8_21"><label class="ub-control label"             for="DESCRIPTION"><ub:message code="label.APM.description" text="설명"/></label></th>
<td id="layout-1_8_22" colspan=3><textarea class="ub-control textarea " id="DESCRIPTION" name="DESCRIPTION"       style="width:426px;" rows="5"                  rows="5"></textarea></td>
</tr>
</tbody>
</table>
 
<div class="ub-layout button bottom"><span class="ub-control button bottom icon" id="copyBtn">
    <a href="#none" title="Save"><span class="ico-save"></span>복사</a>
</span>
</div>
</form>
</div>

<!-- layout-1 End -->



<script type="text/javascript">
	var viewType = '';
	var check = '';
	var screenId = '';
	var category = '';
	var fPath = '/<%=JspUtils.getDefaultValue(_dl_ScreenManageInquiry_getProjectPath, "CODE_NAME") %>/';
uxl.onLoad(function(){
	hsqlData.getCategoryCode("CATEGORY_CODE", {blankOption:"전체"});
	uxl.bindComboCode("SCREEN_TYPE", "APMD_SCREEN_TYPE");
	uxl.bindComboCode("LAYOUT_TYPE", "APMD_LAYOUT_TYPE");
	uxl.bindComboCode("VIEW_TYPE", "APMD_SCREEN_VIEW_TYPE");
	
	$("#FILE_PATH").val('');
	$("#SCREEN_TYPE").val($("#SCREEN_TYPE",opener.document).val());
	$("#LAYOUT_TYPE").val($("#LAYOUT_TYPE",opener.document).val());
	$("#VIEW_TYPE").val($("#VIEW_TYPE",opener.document).val());
	$("#PARENT_SCREEN_ID").val($("#SCREEN_ID",opener.document).val());
	$("#SCREEN_ID").val($("#SCREEN_ID",opener.document).val());
	$("#CATEGORY_CODE").val($("#CATEGORY_CODE",opener.document).val());
	$("#FILE_PATH").val(fPath);
	$('#lblMessage').html('');

	changeView($("#VIEW_TYPE").val());
	
	$("#VIEW_TYPE").change(function(){
		changeView($(this).val());
	});
	
$("#copyBtn").click(function(){
	if(screenId.length<7){
		alert("ID를 정확히 입력하세요.");
	}else if(check==''){
		alert("사용 불가능한 SCREEN ID입니다.");
	}else if(!screenId.startsWith(category.toUpperCase())){
		if(screenId.startsWith(category)){
			alert("SCREEN ID를 대문자로 입력하세요.");
		}else{
			alert("SCREEN ID와 CATEGORY가 일치하지 않습니다.");
		}
	}else{
		$("#LOGIN_CHECK_YN").val((($("#LOGIN_CHECK_YN").is(":checked")) ? "Y" : "N"));
		fnRegist();
	}
});


$("#SCREEN_ID").keyup(function(){
	screenId = $(this).val();
	var option = $("#CATEGORY_CODE").children("option");
	if(screenId.length>=7 && viewType=='M'){
		fnSearchMeta();
	}else if(screenId.length>=7){
		fnSearchJsp();
	}else{
		$('#lblMessage').html('');
		check = '';
	}
});

$("#VIEW_TYPE").change(function() {
	var scrnViewTpCd = $(this).val();
	$("#SCREEN_ID").attr('readonly',false);
	$('#SCREEN_ID').attr('class', 'ub-control input-text');
	$("#tblScrInfo #layout-1_4").hide();
	$("#PID option").remove();
	changeView(scrnViewTpCd);
});

$("#PID").change(function(){
	var value = $(this).val();
	var screenName = this.options[this.options.selectedIndex].title;
	$("#SCREEN_ID").val(value.substr(0,7));
	if(value != null && value != ''){
		fnSearchMeta();
	}else{
		$("#lblMessage").html('');
		$("#SCREEN_ID").val($("#CATEGORY_CODE").val());
	}
	$("#SCREEN_NAME").val(screenName); // 화면명 자동입력 처리
});

$("#CATEGORY_CODE").change(function(){
	if($(this).val() == '' || $(this).val() == null){
		$("#SCREEN_ID").attr("maxlength","0");
	}else{
		$("#SCREEN_ID").attr("maxlength","7");
	}
	$("#SCREEN_ID").val($(this).val());
	check = '';
	category = $(this).val().toLowerCase();
	$("#SELECT_VALUE").val($(this).val());
	$("#FILE_PATH").val(fPath+category+"/");
	$("#PID option").remove();
	hsqlData.getPidList("PID", {blankOption:"선택안됨", categoryCode:$("#CATEGORY_CODE").val()});
});

	

});

function fnSearchMeta() {
	screenId = $("#SCREEN_ID").val();
	//필수정보 체크
	var url = uxl.getFunctionUrl(_SCREEN_ID, 'INQUIRY');
	var option = {
		data:{
			SCREEN_ID : screenId
		}
	    /*
		 * @param {Result} 조회된 데이터 객체 result
		 */
	  , success:function(result) {
		  var d = result.getDataList(0);
		  if(d.rowCount>0){
			  check = d.rows[0].PID;
			  $("#SELECT_VALUE").val(check);
			  $('#lblMessage').html('<strong class="txt-color02">사용 가능한 화면ID입니다.</strong>');
		  }else{
			  $('#lblMessage').html('<strong class="txt-color01">사용 불가능한 화면ID입니다.</strong>');
			  check = '';
		  }
		}
	  , async:true
	};
	uxl.callFunction(url, option);
}

function fnSearchJsp(){
	var scrnId = $("#SCREEN_ID").val();
	var url = uxl.getFunctionUrl(_SCREEN_ID, 'USERDEFINED1');
	var option = {
		data:{"SCREEN_ID" : scrnId}
	  , success:function(result) {
			var rowCount = result.getDataList(0).rowCount;
			
			if (rowCount > 0) {
				check = '';
				$("#lblMessage").html('<strong class="txt-color01">등록된 화면ID입니다.</strong>');
			} else{
				$("#FILE_PATH").val(fPath+category+"/");
				$("#lblMessage").html('<strong class="txt-color02">사용가능한 화면ID입니다.</strong>');
				check = scrnId;
			}
			$("#lblMessage").show();
	    }
	  , async:true
	};
	uxl.callFunction(url, option);
}

function changeView(data){
	$("#PID").setRequired(false);
	viewType = data;
	$("#CATEGORY_CODE").val($("#CATEGORY_CODE",opener.document).val());
	$("#SCREEN_ID").val($("#SCREEN_ID",opener.document).val());
	$("#FILE_NAME").val($("#FILE_NAME",opener.document).val());
	$("#DESCRIPTION").val($("#DESCRIPTION",opener.document).val());
	$("#SCREEN_NAME").val($("#SCREEN_NAME",opener.document).val());
	category = $("#CATEGORY_CODE").val().toLowerCase();
	$("#FILE_PATH").val(fPath+category+"/");
	if(data=='j'){
		$(".meta_id").attr("hidden",true);
		fnSearchJsp();
	}else{
		$("#PID").setRequired(true);
		$(".meta_id").attr("hidden",false);
		hsqlData.getPidList("PID", {blankOption:"선택안됨", categoryCode:$("#CATEGORY_CODE").val()});
		$("#tblScrInfo #layout-1_4").show();
		$("#SCREEN_ID").attr('readonly',true);
		$('#SCREEN_ID').attr('class', 'ub-control input-text readonly');
		fnSearchMeta();
	}
}

/*
 * 등록.
 */
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
			  var screenUrl = result.getResultKey();
			  data = {
					  URL : screenUrl
			  }
			  uxl.pushToParent(data);
			  self.close();
			}
		  , async:true
		  , message : {
				confirm : uxl.getMessage('@message.common.insert.confirm'),
				success : uxl.getMessage('@message.common.insert.success'),
				fail : uxl.getMessage('@message.common.insert.fail')
			}
		};
		uxl.callSubmitFunction('copyForm', url, option);
}
</script>