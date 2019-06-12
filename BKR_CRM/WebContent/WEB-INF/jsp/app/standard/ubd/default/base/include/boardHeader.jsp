<%--
#*
 *  파 일 명 :  boardHeader.jsp
 *  설    명 :  게시판 상단 타이틀 및 버튼영역
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
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.ubone.framework.util.ViewUtil"%>
<%@page import="com.ubone.framework.data.DataList"%>
<%
	Board board = (Board)ViewUtil.getResult().getExtendAttribute("board");
	BoardType boardType = (BoardType)ViewUtil.getResult().getExtendAttribute("boardType");
	Boolean hasAdmin = (Boolean)ViewUtil.getResult().getExtendAttribute("hasAdmin");
	String viewType = request.getParameter("viewType");
%>

	<h1 class="ub-control title" id="boardTitle"></h1>
	<div class="ub-layout button top">
<%	if("list".equals(viewType)){	%>
		<span class="ub-control button top icon" id="registBtn">
		    <a href="#none" title="Register"><span class="ico-register"></span>신규등록</a>
		</span>
<%	}else if("register".equals(viewType)){	%>
		<span class="ub-control button top icon" id="listBtn">
		    <a href="#none" title="List"><span class="ico-list"></span>목록</a>
		</span>
<%	}else if("article".equals(viewType)){	%>
<%		if(hasAdmin && boardType.isInquiryHistoryYn()){ %>
			<span class="ub-control button top icon" id="inquiryHistoryBtn">
			    <a href="#none" title="InquiryHistory">조회이력</a>
			</span>
<%		} %>
		<span class="ub-control button top icon" id="listBtn">
		    <a href="#none" title="List"><span class="ico-list"></span>목록</a>
		</span>
<%	}else if("update".equals(viewType)){	%>
		<span class="ub-control button top icon" id="listBtn">
		    <a href="#none" title="List"><span class="ico-list"></span>목록</a>
		</span>
<%	}	%>
	</div>

<script type="text/javascript">
eventBus.addListener({
	  id : 'boardHeader'
	, onLoad : function(){
		$('#registBtn').click(function(){
			moveRegister('${paramMap.ID_BOARD}');
		});
		$('#listBtn').click(function(){
			moveList('${paramMap.ID_BOARD}');
		});
		
		$('#inquiryHistoryBtn').click(function(){
			openHistoryPop();
		});
		
		fnSetBoardTitle('<%=board.getBoardTitle()%>');
		
		
	}
	, onDelete : function(){
		moveList('${paramMap.ID_BOARD}');
	}
});

function fnSetBoardTitle(title){
	$('#boardTitle').text(title);
}

//등록화면으로 이동
function moveRegister(boardId){
	var param = '?ID_BOARD='+boardId;
	param += '&ID_SUB=${paramMap.ID_SUB}';
	boardCommon.moveArticleRegister(param);
}

//목록화면으로 이동
function moveList(boardId){
	var param = '?ID_BOARD='+boardId;
	param += '&ID_SUB=${paramMap.ID_SUB}';
	param += '&<%=ConstantHolder.KEY_SEARCH_HISTORY%>=${paramMap.ID_BOARD}';
	boardCommon.moveList(param);
}

function openHistoryPop(){
	uxl.openWindow('historyPop', uxl.getScreenURL('UBD0001') , {width:600, height:500}, null);
}
</script>