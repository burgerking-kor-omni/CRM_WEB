<%--
#*
 *  파 일 명 :  SYS0304.jsp
 *  설    명 :  게시판관리 상세 Main Tab Control
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
	DataList _dl_BoardManage_getDetail = ViewUtil.getResult().getDataList("BoardManage.getDetail");
	DataList partitionCodes = ViewUtil.getResult().getDataList("Code.BOARD_PARTITION_TYPE");
	DataList statusCodes = ViewUtil.getResult().getDataList("Code.STATUS");
	String partitionType = _dl_BoardManage_getDetail.getString(0, "TP_PARTITION");
	String authActive = _dl_BoardManage_getDetail.getString(0, "FG_AUTH_ACTIVE");
%>

<!-- layout-1 Start -->
<h1 class="ub-control title">게시판 관리 상세</h1>
<div class="ub-layout button top"><span class="ub-control button top icon" id="listBtn">
    <a href="#none" title="목록"><span class="ico-list"></span>목록</a>
</span>
</div>

<h2 class="ub-control title">기본정보</h2>
<div class="ub-layout details"><form id="detailForm" name="detailForm"><table class="ub-control table normal ">
<colgroup>
	<col width="150px"/>
	<col />
</colgroup>
<tbody>
<tr id="layout-1_1">
	<th id="layout-1_1_1"><label class="ub-control label"             for="ID_BOARD">게시판 ID</label></th>
	<td id="layout-1_1_2">
		<input type=text  class="ub-control input-text " id="ID_BOARD" name="ID_BOARD" value="${paramMap.ID_BOARD}" readonly style="text-align:left;width:100px;">
		<input type="checkbox" value="Y" name="ckbPatition" id="ckbPatition" class="ub-control input-checkbox" ><label class="ub-control label">파티션 구분</label>
		<input type=hidden id="ID_BOARD_TYPE" name="ID_BOARD_TYPE" value="<%=JspUtils.getDefaultValue(_dl_BoardManage_getDetail, "ID_BOARD_TYPE") %>">
	</td>
</tr>
<tr id="layout-1_2">
	<th id="layout-1_2_3"><label class="ub-control label"             for="DS_TITLE">게시판 타이틀</label></th>
	<td id="layout-1_2_4"><input type=text  class="ub-control input-text " id="DS_TITLE" name="DS_TITLE" value="<%=JspUtils.getDefaultValue(_dl_BoardManage_getDetail, "DS_TITLE") %>" metaessential="1" style="text-align:left;width:400px;"></td>
</tr>
<tr id="layout-1_3">
	<th id="layout-1_3_5"><label class="ub-control label"             for="CD_CATEGORY">게시판 분류</label></th>
	<td id="layout-1_3_6">
		<input type=text  class="ub-control input-text " id="CD_CATEGORY" name="CD_CATEGORY" value="<%=JspUtils.getDefaultValue(_dl_BoardManage_getDetail, "CD_CATEGORY") %>" style="text-align:left;width:186px;">
		<label class="ub-control label">'|' 로 구분   EX) 질문|요청|문의</label>
	</td>
</tr>
<tr id="layout-1_4">
	<th id="layout-1_4_7"><label class="ub-control label"             for="">게시판 목록 URL</label></th>
	<td id="layout-1_4_8">
		<input type=text  class="ub-control input-text " id="BOARD_LIST_URL" name="BOARD_LIST_URL" value="" readonly style="text-align:left;width:400px;">
	</td>
</tr>
<tr id="layout-1_6">
	<th id="layout-1_6_7"><label class="ub-control label"             for="">사용여부</label></th>
	<td id="layout-1_6_8">
		<select id="FG_USE" name="FG_USE" class="ub-control select " style="width:120px;" size="1" >
			<%	if(statusCodes != null){
					for(int codeIdx=0; codeIdx < statusCodes.getRowCount(); codeIdx++){
						String code = statusCodes.getString(codeIdx, ConstantHolder.CODE_COLUMN_CODE);
						String name = statusCodes.getString(codeIdx, ConstantHolder.CODE_COLUMN_NAME);
						String selected = code.equals(JspUtils.getDefaultValue(_dl_BoardManage_getDetail, "FG_USE"))?"selected":"";
						out.println("<option VALUE=\""+code+"\" "+selected+">"+name+"</option>\r\n");
					}
				}	%>
		</select>
	</td>
</tr>
<tr id="layout-1_5">
	<th id="layout-1_5_9"><label class="ub-control label"             for="">게시판 파티션 유형</label></th>
	<td id="layout-1_5_10">
		<select id="partitionItems" name="partitionItems" class="ub-control select " style="width:0px; display:none;" >
			<%	if(partitionCodes != null){
					for(int codeIdx=0; codeIdx < partitionCodes.getRowCount(); codeIdx++){
						String code = partitionCodes.getString(codeIdx, ConstantHolder.CODE_COLUMN_CODE);
						String name = partitionCodes.getString(codeIdx, ConstantHolder.CODE_COLUMN_NAME);
						out.println("<option VALUE=\""+code+"\">"+name+"</option>\r\n");
					}
				}	%>
		</select>
	</td>
</tr>

</tbody>
</table>

</form>
</div>
<div class="ub-layout button bottom">
<span class="ub-control button bottom icon" id="basicUpdateBtn"        title="저장">
    <a href="#none" title="저장"><span class="ico-save"></span>저장</a>
</span>
<span class="ub-control button bottom icon" id="deleteBoardBtn"        title="삭제">
    <a href="#none" title="삭제">삭제</a>
</span>
</div>

<div class="ub-control temp" style="border:2px solid gray;width:100%;height:50px;text-align:center;"><h3 style="padding:10px;">Tab Control</h3></div>
<div id="tab" name="tab" class="ub-control tab"></div>

<!-- layout-1 End -->


<script type="text/javascript" charset="UTF-8" src="<spring:url value='/uxl/tab/uxl-tab-1.3.0.js'/>"></script>
<script type="text/javascript">
var tab;
uxl.onLoad(function(){
	
	fnSetPartitionList();
	
	if('<%=partitionType%>' == null || '<%=partitionType%>' == ''){
		$('#layout-1_5').hide();	
	}else{
		$('#ckbPatition')[0].checked = true;
		$('#TP_PARTITION[value="<%=partitionType%>"]')[0].checked = true;
	}
	
	//게시판 URL 정보 세팅
	fnGetBoardLinkURL();
	
	//등록버튼 클릭 이벤트 바인딩
	$('#basicUpdateBtn').click(function(event){
		fnBasicUpdate();
	});
	
	//게시판 삭제버튼 이벤트 바인등
	$('#deleteBoardBtn').click(function(event){
		fnDeleteBoard();
	});
	
	$('#ckbPatition').click(function(event){
		if(this.checked){
			$('#layout-1_5').show();
		}else{
			$('#layout-1_5').hide();
			for(var i = 0 ; i < $('input[name="TP_PARTITION"]').length; i++){
				$('input[name="TP_PARTITION"]')[i].checked = false;
			}
		}
	});
	
	var boardId = $("#ID_BOARD").val();
	var authActiveYn = '<%=authActive%>';
	//tab 컨트롤
	tab= new uxl.Tabs('tab');
	tab.add('UBS0005', uxl.getScreenURL('UBS0005') + '?ID_BOARD=' + boardId, '유형정보', false);
	tab.add('UBS0006', uxl.getScreenURL('UBS0006') + '?ID_BOARD=' + boardId, '관리자설정', false);
// 	tab.add('UBS0007', uxl.getScreenURL('UBS0007') + '?ID_BOARD=' + boardId + '&FG_AUTH_ACTIVE='+authActiveYn, '권한설정', false);
	
	if(<%=ConfigHolder.getBoolean("push.message.enabled")%>){
		tab.add('UBS0008', uxl.getScreenURL('UBS0008') + '?ID_BOARD=' + boardId, '알림메세지설정', false);	
	}
	
	$("#listBtn").click(function() {
		uxl.returnToList('UBS0001');
	});
});	
	
function fnSetPartitionList(){
	var partitionDatas = $('#partitionItems > option');
	var strHtml = '';
	if(partitionDatas.length != 0){
		for(var i = 0 ; i < partitionDatas.length ; i++){
			strHtml += '<input type="radio" class="ub-control radio" id="TP_PARTITION" name="TP_PARTITION" value="'+partitionDatas[i].value+'"/><label class="ub-control label">'+partitionDatas[i].text+'</label>';
		}
	}
	$('#layout-1_5_10').append(strHtml);
}
	
// 게시판 수정
function fnBasicUpdate() {	
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

// 게시판 삭제
function fnDeleteBoard(){
	var boardId = $('#ID_BOARD').val();
	var url = uxl.getFunctionUrl(_SCREEN_ID, 'REMOVE');
	var option = {
		data:{ID_BOARD:boardId}
	  , success:function(result) {
		  uxl.returnToList('UBS0001');
		}
	  , async:true
	  , message : {
			confirm : uxl.getMessage('@message.common.delete.confirm'),
			success : uxl.getMessage('@message.common.delete.success'),
			fail : uxl.getMessage('@message.common.delete.fail')
		}
	  
	};
	uxl.callFunction(url, option);
}

//게시판 목록 URL
function fnGetBoardLinkURL(){
	var url = uxl.getFunctionUrl(_SCREEN_ID, 'USERDEFINED1');
	var option = {
		data:{}
	  , success:function(result) {
		  var dataSet = result.getDataList("urlInfo").rows[0];
		  var param = "?ID_BOARD=" + $('#ID_BOARD').val();
		  
		  $('#BOARD_LIST_URL').val("/screen/" + dataSet.LIST_SCREEN_ID + ".ub" + param);
		}
	  , async:true
	};
	uxl.callSubmitFunction('detailForm', url, option);
}
	
</script>