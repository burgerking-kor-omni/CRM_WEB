<%--
#*
 *  파 일 명 :  SYS0306.jsp
 *  설    명 :  게시판관리 게시판상세 유형정보 (TabContent)
 *  작 성 자 :  유기태
 *  작 성 일 :  2015.05.12
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
	DataList _dl_BOARD_TYPE_CD = ViewUtil.getResult().getDataList("Code.BOARD_TYPE_CD");
	DataList _dl_BoardManage_getTypeDetail = ViewUtil.getResult().getDataList("BoardManage.getTypeDetail");
%>


<!--  ========================================================================
  This page is generated with the UB-META™ ver4.0 
 
   - PAGE ID : SYS0306R00
   - PAGE TYPE : JSP
 
  Copyright ⓒ UBONE Co., Ltd. All rights reserved.
 ========================================================================
--> 


<!-- layout-1 Start -->

<h2 class="ub-control title">유형정보</h2>
<div class="ub-layout details">
<form id="detailForm" name="detailForm">
	<table class="ub-control table normal ">
		<colgroup>
			<col width="150px"/>
			<col width="150px"/>
			<col />
		</colgroup>
		<tbody>
			<tr id="layout-1_1">
				<th id="layout-1_1_1"><label class="ub-control label" >게시판 유형</label></th>
				<td id="layout-1_1_2" colspan="2">
					<select id="ID_BOARD_TYPE" name="ID_BOARD_TYPE" class="ub-control select " style="width:200px;" size="1" datacid="BOARD_TYPE_CD" metaessential="1"  defaultvalue="<%=JspUtils.getDefaultValue(_dl_BoardManage_getTypeDetail, "ID_BOARD_TYPE") %>">
						<%   if(_dl_BOARD_TYPE_CD != null){
								for(int codeIdx=0; codeIdx < _dl_BOARD_TYPE_CD.getRowCount(); codeIdx++){
									String code = _dl_BOARD_TYPE_CD.getString(codeIdx, ConstantHolder.CODE_COLUMN_CODE);
									String name = _dl_BOARD_TYPE_CD.getString(codeIdx, ConstantHolder.CODE_COLUMN_NAME);
									String selected = code.equals(JspUtils.getDefaultValue(_dl_BoardManage_getTypeDetail, "ID_BOARD_TYPE"))?"selected":"";
									out.println("<option VALUE=\""+code+"\" "+selected+">"+name+"</option>\r\n");
								}
							}
						%>						
					</select>
				</td>
			</tr>
			<tr id="layout-1_2">
				<th id="layout-1_2_3" rowspan="2"><label class="ub-control label" >데이터 항목 표시</label></th>
				<td id="layout-1_2_4" colspan="2">
					<input type="radio" class="ub-control radio" id="FG_DATA_ITEM" name="FG_DATA_ITEM" <%= ("Y".equals(JspUtils.getDefaultValue(_dl_BoardManage_getTypeDetail, "FG_DATA_ITEM")))?"checked":"" %> value="Y"/><label class="ub-control label">사용</label>
					<input type="radio" class="ub-control radio" id="FG_DATA_ITEM" name="FG_DATA_ITEM" <%= ("N".equals(JspUtils.getDefaultValue(_dl_BoardManage_getTypeDetail, "FG_DATA_ITEM")))?"checked":"" %> value="N"/><label class="ub-control label">미사용</label>
				</td>
				
			</tr>
			<tr id="layout-1_3">
				<td id="layout-1_2_5" colspan="2">
					<input type="checkbox" value="Y" name="FG_DATA_ITEM_NEW" id="FG_DATA_ITEM_NEW" class="ub-control input-checkbox" <%= ("Y".equals(JspUtils.getDefaultValue(_dl_BoardManage_getTypeDetail, "FG_DATA_ITEM_NEW")))?"checked":"" %>><label class="ub-control label">새로운 글 표시</label>
					<input type="checkbox" value="Y" name="FG_DATA_ITEM_FILE" id="FG_DATA_ITEM_FILE" class="ub-control input-checkbox" <%= ("Y".equals(JspUtils.getDefaultValue(_dl_BoardManage_getTypeDetail, "FG_DATA_ITEM_FILE")))?"checked":"" %>><label class="ub-control label">첨부파일 표시</label>
					<input type="checkbox" value="Y" name="FG_DATA_ITEM_REPLY" id="FG_DATA_ITEM_REPLY" class="ub-control input-checkbox" <%= ("Y".equals(JspUtils.getDefaultValue(_dl_BoardManage_getTypeDetail, "FG_DATA_ITEM_REPLY")))?"checked":"" %>><label class="ub-control label">댓글개수 표시</label>
				</td>
			</tr>
			<tr id="layout-1_4">
				<th id="layout-1_4_6" rowspan="2"><label class="ub-control label" >공지글</label></th>
				<td id="layout-1_4_7" colspan="2">
					<input type="radio" class="ub-control radio" id="FG_NOTICE" name="FG_NOTICE" <%= ("Y".equals(JspUtils.getDefaultValue(_dl_BoardManage_getTypeDetail, "FG_NOTICE")))?"checked":"" %> value="Y"/><label class="ub-control label">사용</label>
					<input type="radio" class="ub-control radio" id="FG_NOTICE" name="FG_NOTICE" <%= ("N".equals(JspUtils.getDefaultValue(_dl_BoardManage_getTypeDetail, "FG_NOTICE")))?"checked":"" %> value="N"/><label class="ub-control label">미사용</label>
				</td>
			</tr>
			<tr id="layout-1_5">
				<th id="layout-1_5_8"><label class="ub-control label" >공지글 표시 개수</label></th>
				<td id="layout-1_5_9">
					<input type=text  class="ub-control input-text " id="CNT_NOTICE" name="CNT_NOTICE" value="<%=JspUtils.getDefaultValue(_dl_BoardManage_getTypeDetail, "CNT_NOTICE") %>" style="text-align:right;width:30px;"><label class="ub-control label">개</label>
				</td>
			</tr>
			<tr id="layout-1_6">
				<th id="layout-1_6_10" rowspan="4"><label class="ub-control label" >파일 첨부</label></th>
				<td id="layout-1_6_11" colspan="2">
					<input type="radio" class="ub-control radio" id="FG_FILE" name="FG_FILE" <%= ("Y".equals(JspUtils.getDefaultValue(_dl_BoardManage_getTypeDetail, "FG_FILE")))?"checked":"" %> value="Y"/><label class="ub-control label">사용</label>
					<input type="radio" class="ub-control radio" id="FG_FILE" name="FG_FILE" <%= ("N".equals(JspUtils.getDefaultValue(_dl_BoardManage_getTypeDetail, "FG_FILE")))?"checked":"" %> value="N"/><label class="ub-control label">미사용</label>
				</td>
			</tr>
			<tr id="layout-1_7">
				<th id="layout-1_7_12"><label class="ub-control label" >파일첨부 확장자</label></th>
				<td id="layout-1_7_13">
					<input type=text  class="ub-control input-text " id="DS_FILE_EXTENSION" name="DS_FILE_EXTENSION" value="<%=JspUtils.getDefaultValue(_dl_BoardManage_getTypeDetail, "DS_FILE_EXTENSION") %>" style="text-align:left;width:100px;"><label class="ub-control label">'|' 로 구분  EX) jpg|png|bmp</label>
				</td>
			</tr>
			<tr id="layout-1_8">
				<th id="layout-1_8_14"><label class="ub-control label" >파일첨부 용량</label></th>
				<td id="layout-1_8_15">
					<input type=text  class="ub-control input-text " id="DS_FILE_VOLUME" name="DS_FILE_VOLUME" value="<%=JspUtils.getDefaultValue(_dl_BoardManage_getTypeDetail, "DS_FILE_VOLUME") %>" style="text-align:right;width:100px;"><label class="ub-control label">KB</label>
				</td>
			</tr>
			<tr id="layout-1_9">
				<th id="layout-1_9_16"><label class="ub-control label" >최대 첨부파일 개수</label></th>
				<td id="layout-1_9_17">
					<input type=text  class="ub-control input-text " id="CNT_MAX_FILE" name="CNT_MAX_FILE" value="<%=JspUtils.getDefaultValue(_dl_BoardManage_getTypeDetail, "CNT_MAX_FILE") %>" style="text-align:right;width:30px;"><label class="ub-control label">개</label>
				</td>
			</tr>
			
			<tr id="layout-1_10">
				<th id="layout-1_10_18"><label class="ub-control label" >답글</label></th>
				<td id="layout-1_10_19" colspan="2">
					<input type="radio" class="ub-control radio" id="FG_ANSWER" name="FG_ANSWER" <%= ("Y".equals(JspUtils.getDefaultValue(_dl_BoardManage_getTypeDetail, "FG_ANSWER")))?"checked":"" %> value="Y"/><label class="ub-control label">사용</label>
					<input type="radio" class="ub-control radio" id="FG_ANSWER" name="FG_ANSWER" <%= ("N".equals(JspUtils.getDefaultValue(_dl_BoardManage_getTypeDetail, "FG_ANSWER")))?"checked":"" %> value="N"/><label class="ub-control label">미사용</label>
				</td>	
			</tr>
			
			<tr id="layout-1_11">
				<th id="layout-1_11_20"><label class="ub-control label" >댓글</label></th>
				<td id="layout-1_11_21" colspan="2">
					<input type="radio" class="ub-control radio" id="FG_REPLY" name="FG_REPLY" <%= ("Y".equals(JspUtils.getDefaultValue(_dl_BoardManage_getTypeDetail, "FG_REPLY")))?"checked":"" %> value="Y"/><label class="ub-control label">사용</label>
					<input type="radio" class="ub-control radio" id="FG_REPLY" name="FG_REPLY" <%= ("N".equals(JspUtils.getDefaultValue(_dl_BoardManage_getTypeDetail, "FG_REPLY")))?"checked":"" %> value="N"/><label class="ub-control label">미사용</label>
				</td>	
			</tr>
			
			<tr id="layout-1_12">
				<th id="layout-1_12_22"><label class="ub-control label" >이전글 / 다음글</label></th>
				<td id="layout-1_12_23" colspan="2">
					<input type="radio" class="ub-control radio" id="FG_PRE_NEXT" name="FG_PRE_NEXT" <%= ("Y".equals(JspUtils.getDefaultValue(_dl_BoardManage_getTypeDetail, "FG_PRE_NEXT")))?"checked":"" %> value="Y"/><label class="ub-control label">사용</label>
					<input type="radio" class="ub-control radio" id="FG_PRE_NEXT" name="FG_PRE_NEXT" <%= ("N".equals(JspUtils.getDefaultValue(_dl_BoardManage_getTypeDetail, "FG_PRE_NEXT")))?"checked":"" %> value="N"/><label class="ub-control label">미사용</label>
				</td>	
			</tr>
			
			<tr id="layout-1_13">
				<th id="layout-1_13_24"><label class="ub-control label" >추천 / 비추천</label></th>
				<td id="layout-1_13_25" colspan="2">
					<input type="radio" class="ub-control radio" id="FG_GOOD_BAD" name="FG_GOOD_BAD" <%= ("Y".equals(JspUtils.getDefaultValue(_dl_BoardManage_getTypeDetail, "FG_GOOD_BAD")))?"checked":"" %> value="Y"/><label class="ub-control label">사용</label>
					<input type="radio" class="ub-control radio" id="FG_GOOD_BAD" name="FG_GOOD_BAD" <%= ("N".equals(JspUtils.getDefaultValue(_dl_BoardManage_getTypeDetail, "FG_GOOD_BAD")))?"checked":"" %> value="N"/><label class="ub-control label">미사용</label>
				</td>	
			</tr>
			
			<tr id="layout-1_14">
				<th id="layout-1_14_26"><label class="ub-control label" >엑셀 다운로드</label></th>
				<td id="layout-1_14_27" colspan="2">
					<input type="radio" class="ub-control radio" id="FG_EXCEL_DOWN" name="FG_EXCEL_DOWN" <%= ("Y".equals(JspUtils.getDefaultValue(_dl_BoardManage_getTypeDetail, "FG_EXCEL_DOWN")))?"checked":"" %> value="Y"/><label class="ub-control label">사용</label>
					<input type="radio" class="ub-control radio" id="FG_EXCEL_DOWN" name="FG_EXCEL_DOWN" <%= ("N".equals(JspUtils.getDefaultValue(_dl_BoardManage_getTypeDetail, "FG_EXCEL_DOWN")))?"checked":"" %> value="N"/><label class="ub-control label">미사용</label>
				</td>	
			</tr>
			
			<tr id="layout-1_15">
				<th id="layout-1_15_28"><label class="ub-control label" >임시저장</label></th>
				<td id="layout-1_15_29" colspan="2">
					<input type="radio" class="ub-control radio" id="FG_TEMP_SAVE" name="FG_TEMP_SAVE" <%= ("Y".equals(JspUtils.getDefaultValue(_dl_BoardManage_getTypeDetail, "FG_TEMP_SAVE")))?"checked":"" %> value="Y"/><label class="ub-control label">사용</label>
					<input type="radio" class="ub-control radio" id="FG_TEMP_SAVE" name="FG_TEMP_SAVE" <%= ("N".equals(JspUtils.getDefaultValue(_dl_BoardManage_getTypeDetail, "FG_TEMP_SAVE")))?"checked":"" %> value="N"/><label class="ub-control label">미사용</label>
				</td>	
			</tr>
			
			<tr id="layout-1_16">
				<th id="layout-1_16_30"><label class="ub-control label" >텍스트에디터</label></th>
				<td id="layout-1_16_31" colspan="2">
					<input type="radio" class="ub-control radio" id="FG_TEXT_EDITOR" name="FG_TEXT_EDITOR" <%= ("Y".equals(JspUtils.getDefaultValue(_dl_BoardManage_getTypeDetail, "FG_TEXT_EDITOR")))?"checked":"" %> value="Y"/><label class="ub-control label">사용</label>
					<input type="radio" class="ub-control radio" id="FG_TEXT_EDITOR" name="FG_TEXT_EDITOR" <%= ("N".equals(JspUtils.getDefaultValue(_dl_BoardManage_getTypeDetail, "FG_TEXT_EDITOR")))?"checked":"" %> value="N"/><label class="ub-control label">미사용</label>
				</td>	
			</tr>
			
			<input type=hidden id="ID_BOARD" name="ID_BOARD" value="${paramMap.ID_BOARD}">	
		</tbody>
	</table>
</form>
</div>

<div class="ub-layout button bottom"><span class="ub-control button bottom icon" id="typeUpdateBtn" title="수정">
    <a href="#none" title="수정"><span class="ico-save"></span>유형저장</a>
</span>
</div>

<!-- layout-1 End -->


<script type="text/javascript">
uxl.onLoad(function(){

	//수정버튼 클릭 이벤트 바인딩
	$('#typeUpdateBtn').click(function(event){
		fnTypeUpdate();
	});
	
});

//유형 수정
function fnTypeUpdate() {	
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
			uxl.reload();
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