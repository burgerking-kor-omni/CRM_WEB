<%--
#*
 *  파 일 명 :  registerShareTarget.jsp
 *  설    명 :  등록화면 공개대상
 *  작 성 자 :  
 *  작 성 일 :  
 *  버    전 :  1.0
 *  기타사항 :
 *  Copyrights 2013 by ㈜ 유비원. All right reserved.
*# 
--%>
<%@page import="com.ubone.standard.ubboard.common.domain.BoardType"%>
<%@page import="com.ubone.standard.ubboard.common.domain.Board"%>
<%@page import="com.ubone.framework.util.ViewUtil"%>
<%@page import="com.ubone.framework.data.DataList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	Board board = (Board)ViewUtil.getResult().getExtendAttribute("board");
	BoardType boardType = (BoardType)ViewUtil.getResult().getExtendAttribute("boardType");
%>
<div class="ub-layout button inner"  style="text-align:right;">
	<span class="ub-control button inner icon" id="btnAdd">
	    <a href="#none" title="추가">추가</a>
	</span>
</div>
<div id="list">
	<table class='ub-control table bbs-list'>
	<colgroup>
		<col style='width:10%'/>
		<col style='width:30%'/>
		<col style='width:30%'/>
		<col style='width:30%'/>
	</colgroup>
	<thead>
		<tr>
			<th><strong>선택</strong></th>
			<th><strong>대상유형</strong></th>
			<th><strong>대상코드</strong></th>
			<th><strong>대상명</strong></th>
		</tr>
	</thead>
	<tbody>
	</tbody>
	</table>
</div>

<script type="text/javascript">
eventBus.addListener({
	  id : 'registerShareTarget'
	, onLoad : function(){
		$('#btnAdd').click(function(){
			alert('openWindow');
		});
		
		
	}
	, onSearch : function(){
		
	}
});

//그리드 생성
function callBackAdd(returnData){
	var strHtml = "";
	
	if(true){
		for(var i=0 ; i < noticeData.rowCount ; i++){
			var rowData = noticeData.rows[i];
			strHtml += "<tr class='notice' name='noticeRow'>";
			strHtml += "	<td>공지</td>";
			strHtml += "	<td class='t-left'><a href='#none' onclick='javascript:moveDetail(\""+rowData.ID_ARTICLE+"\");'>"+rowData.DS_TITLE+"</a></td>";
			strHtml += "	<td>"+rowData.REG_DATETIME+"</td>";
			strHtml += "	<td>"+rowData.REG_USER_NM+"</td>";
			strHtml += "	<td>"+rowData.CNT_HIT+"</td>";
			<%	if(boardType.isGoodBadYn()){	%>
				strHtml += "	<td>"+rowData.CNT_GOOD+"</td>";
				strHtml += "	<td>"+rowData.CNT_BAD+"</td>";
			<%	}	%>
			strHtml += "</tr>";
		}
	}				


	$('#list > table > tbody').html(strHtml);
}

</script>