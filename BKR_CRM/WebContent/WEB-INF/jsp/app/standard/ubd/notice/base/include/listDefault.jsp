<%--
#*
 *  파 일 명 :  listDefault.jsp
 *  설    명 :  목록화면 기본목록
 *  작 성 자 :  
 *  작 성 일 :  
 *  버    전 :  1.0
 *  기타사항 :
 *  Copyrights 2013 by ㈜ 유비원. All right reserved.
*# 
--%>
<%@page import="com.ubone.framework.ConstantHolder"%>
<%@page import="com.ubone.standard.ubboard.common.domain.BoardType"%>
<%@page import="com.ubone.standard.ubboard.common.domain.Board"%>
<%@page import="com.ubone.framework.util.ViewUtil"%>
<%@page import="com.ubone.framework.data.DataList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	Board board = (Board)ViewUtil.getResult().getExtendAttribute("board");
	BoardType boardType = (BoardType)ViewUtil.getResult().getExtendAttribute("boardType");
%>

<div id="list" class="list-wrap">
	<table class='ub-control table bbs-list'>
	<colgroup>
		<col style='width:5%'/>
		<col style='width:55%'/>
		<col style='width:15%'/>
		<col style='width:10%'/>
		<col style='width:5%'/>
<%	if(boardType.isGoodBadYn()){	%>
		<col style='width:5%'/>
		<col style='width:5%'/>
<%	}								%>
	</colgroup>
	<thead>
		<tr>
			<th><strong>번호</strong></th>
			<th><strong>제목</strong></th>
			<th><strong>작성자</strong></th>
			<th><strong>작성일</strong></th>
			<th><strong>조회수</strong></th>
<%	if(boardType.isGoodBadYn()){	%>
			<th><strong>추천수</strong></th>
			<th><strong>반대수</strong></th>	
<%	}								%>
		</tr>
	</thead>
	<tbody>
	</tbody>
	</table>
</div>

<div class="ub-layout pagging">
	<div class="ub-control temp" style="border:2px solid gray;width:100%;height:30px;text-align:center;">
		<h3 style="padding-top:3px;">Paging Navigation</h3>
	</div>
	<div id="page" name="page" class="ub-control pagging" for="list" formId="defaultForm" function="fnGetListData"></div>
</div>

<style>
.searchPoint{color:pink;}
</style>

<script type="text/javascript">
eventBus.addListener({
	  id : 'listDefault'
	, onLoad : function(){
		fnGetListData();
		
	}
	, onSearch : function(){
		fnGetListData();
		
	}
});

//게시판 목록 정보 불러오기
function fnGetListData(){
	if(_BOARD_RECOVERY_PAGENUM != 1){
		boardCommon.recoveryParameter(_BOARD_RECOVERY_PAGENUM);
	}
	var url = uxl.getFunctionUrl(_SCREEN_ID,'INQUIRY');
	var option = {
		data:{'<%=ConstantHolder.KEY_SEARCH_HISTORY%>':'${paramMap.ID_BOARD}'}
	  , success:function(result) {
			createGrid(result);
			eventBus.triggerEvent("onSearchComplete");
		}
	  , async:true
	};
	uxl.callSubmitFunction('defaultForm', url, option);	
}

function fnGetNoticeListData(){
	var returnResult = null;
	var url = uxl.getFunctionUrl(_SCREEN_ID,'USERDEFINED2');
	var option = {
		data:{}
	  , success:function(result) {
		  returnResult = result;
		}
	  , async:false
	};
	uxl.callSubmitFunction('defaultForm', url, option);	
	return returnResult;
}

//그리드 생성
function createGrid(result){
	var strHtml = "";
	var colCnt = 5;
	<%	if(boardType.isGoodBadYn()){	%>
		colCnt = colCnt + 2;
	<%	}	%>	
	<%	if(boardType.isNoticeYn()){	%>
			var noticeResult = fnGetNoticeListData();
			var noticeData = noticeResult.getDataList(0);
			if(noticeData.rowCount != 0){
				for(var i=0 ; i < noticeData.rowCount ; i++){
					var rowData = noticeData.rows[i];
					strHtml += "<tr class='notice pointer' name='noticeRow' onclick='javascript:moveDetail(\""+rowData.ID_ARTICLE+"\");'>";
					strHtml += "	<td>공지</td>";
					strHtml += "	<td class='t-left'><a href='#none' >"+rowData.DS_TITLE+"</a></td>";
					strHtml += "	<td>"+rowData.REG_USER_NM+"</td>";
					strHtml += "	<td>"+rowData.REG_DATETIME+"</td>";
					strHtml += "	<td>"+rowData.CNT_HIT+"</td>";
					<%	if(boardType.isGoodBadYn()){	%>
						strHtml += "	<td>"+rowData.CNT_GOOD+"</td>";
						strHtml += "	<td>"+rowData.CNT_BAD+"</td>";
					<%	}	%>
					strHtml += "</tr>";
				}
			}				
	<%	}	%>
	var listData   = result.getDataList("boardList");
// 	var searchData = result.getDataList("searchList").rows[0];
	
	if(listData.rowCount == 0){
		strHtml += "<tr>";
		strHtml += "	<td colspan='"+colCnt+"'>등록된 게시물이 없습니다</td>";
		strHtml += "</tr>";
	}else{
		for(var i = 0; i < listData.rowCount ; i++){
			var rowData = listData.rows[i];
			
			if(rowData.FG_DEL == 'N'){
				//삭제된 게시물이 아닐 경우
				strHtml += "<tr class='pointer' onclick='javascript:moveDetail(\""+rowData.ID_ARTICLE+"\");'>";
				strHtml += "	<td>"+rowData.NO_ARTICLE+"</td>";
				strHtml += "	<td class='t-left'><a href='#none'>";


				<%	if(boardType.isAnswerYn()){	%>
					
					if(rowData.DEPTH != 0){
						for(var t = 0 ; t < rowData.DEPTH ; t++){
							strHtml += "&nbsp;&nbsp;";	
						}
						strHtml += "<span class='icon re'><img src='../page/images/board/ico_re.png' alt='댓글' /></span>";
					}
				<%	}	%>
				
				if(rowData.NM_CATEGORY != null && rowData.NM_CATEGORY != ''){
					strHtml += "[" + rowData.NM_CATEGORY +"] ";	
				}
				
				//제목 검색값이 있을경우 포인트컬러 부여
				var title = rowData.DS_TITLE;
// 				if(searchData.searchKey == 'DS_TITLE' && searchData.searchValue != ''){
// 					title = rowData.DS_TITLE.split(searchData.searchValue).join('<span class="searchPoint">'+searchData.searchValue+'</span>');
// 				}
				strHtml += title;			
				
				// 목록 데이터 항목 사용여부에 따른 표시 설정
				<%	if(boardType.isDataItemYn()){	%>
					// 댓글에 대한 항목 사용여부에 따른 표시 설정
					<%	if(boardType.isDataItemReply()){	%>
							if(parseInt(rowData.REPLY_COUNT, 10) != 0){
								strHtml += "<span class='re-count'><strong> [" + rowData.REPLY_COUNT + "] </strong></span>";	
							}
					<%	}									%>
					// 파일에 대한 항목 사용여부에 따른 표시 설정
					<%	if(boardType.isDataItemFile()){	%>
							if(rowData.CNT_FILE != 0){
								strHtml += "<span class='icon file'><img src='../page/images/board/ico_file.png' alt='파일' /></span>";
							}
					<%	}									%>
					// 새글에 대한 항목 사용여부에 따른 표시 설정
					<%	if(boardType.isDataItemNew()){	%>
							if(rowData.IS_NEW == 'Y'){
								strHtml += "<span class='icon new'><img src='../page/images/board/ico_new.png' alt='새 글' /></span>";
							}
					<%	}									%>
				<%	}									%>
				
				strHtml += "	</a></td>";
				
				var registUserName = rowData.REG_USER_NM;
// 				if(searchData.searchKey == 'REG_USER_NM' && searchData.searchValue != ''){
// 					registUserName = registUserName.split(searchData.searchValue).join('<span class="searchPoint">'+searchData.searchValue+'</span>');
// 				}
				strHtml += "	<td>"+registUserName+"</td>";
				strHtml += "	<td>"+rowData.REG_DATETIME+"</td>";
				strHtml += "	<td>"+rowData.CNT_HIT+"</td>";
				<%	if(boardType.isGoodBadYn()){	%>
					strHtml += "	<td>"+rowData.CNT_GOOD+"</td>";
					strHtml += "	<td>"+rowData.CNT_BAD+"</td>";
				<%	}								%>
				strHtml += "</tr>";
			}else{
				//삭제된 게시물일 경우
				strHtml += "<tr>";
				strHtml += "	<td>"+rowData.NO_ARTICLE+"</td>";
				strHtml += "	<td class='t-left'>";
				<%	if(boardType.isAnswerYn()){	%>				
					if(rowData.DEPTH != 0){
						for(var t = 0 ; t < rowData.DEPTH ; t++){
							strHtml += "&nbsp;&nbsp;";	
						}
						strHtml += "<span class='icon re'><img src='../page/images/board/ico_re.png' alt='댓글' /></span>";
					}
				<%	}	%>
				strHtml += "삭제된 게시물입니다.</td>";
				strHtml += "	<td>-</td>";
				strHtml += "	<td>-</td>";
				strHtml += "	<td>-</td>";
				<%	if(boardType.isGoodBadYn()){	%>
					strHtml += "	<td>-</td>";
					strHtml += "	<td>-</td>";
				<%	}								%>
				strHtml += "</tr>";
			}
		}
	}

	$('#list > table > tbody').html(strHtml);
	boardCommon.setPaging('list', result);
}

//상세화면으로 이동
function moveDetail(articleId){
	var param = "?ID_BOARD=${paramMap.ID_BOARD}&ID_ARTICLE="+articleId+"&ID_SUB=${paramMap.ID_SUB}";
	boardCommon.moveArticle(param);
}

</script>