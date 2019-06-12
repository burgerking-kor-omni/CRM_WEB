<%--
#*
 *  파 일 명 :  articleBody.jsp
 *  설    명 :  게시물상세화면 본문영역
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
	DataList articleDetail = ViewUtil.getResult().getDataList("articleDetail");
%>

<div class="ub-layout details">
	<div class="ub-control bbs-view">
		<div class="bbs-tit">
			<div class="num" style="width:10%;"><strong class="bar"><%=articleDetail.getString(0, "NO_ARTICLE") %></strong></div>
			<div class="tit" style="width:50%;">
				<p><strong>
				<%	if(articleDetail.getString(0, "NM_CATEGORY") != null && !"".equals(articleDetail.getString(0, "NM_CATEGORY"))){ %>
						[<%=articleDetail.getString(0, "NM_CATEGORY")%>]
				<%	}	%>
				<%=articleDetail.getString(0, "DS_TITLE")%>
				</strong></p>
			</div>
			<div class="date" style="width:30%;">
				<strong><%=articleDetail.getString(0, "REG_DATETIME")%></strong>
<!-- 				<span class="ub-control button icon bbs"><a href="#none"><span class="ico-pdf"></span>PDF</a></span> -->
<!-- 				<span class="ub-control button icon bbs"><a href="#none"><span class="ico-print"></span>Print</a></span> -->
			</div>
		</div>
		<div class="w-info">
			<span class="writer">글쓴이 : <a href="#none" id="manLayerOpenBtn"><%=articleDetail.getString(0, "REG_USER_NM")%></a></span>
			<span class="bar">조회수 : <span id="hitCount"><%=articleDetail.getString(0, "CNT_HIT")%></span></span>
			<%	if(boardType.isGoodBadYn()){ 	%>
				<span class="bar agree"><span class="icon"></span>추천 : <a href="#none" id="evaluationGood"><%=articleDetail.getString(0, "CNT_GOOD")%></a></span> 
				<span class="bar disagree"><span class="icon"></span>반대 : <a href="#none" id="evaluationBad"><%=articleDetail.getString(0, "CNT_BAD")%></a></span>
			 <%	} %>
		</div>
		<div class="bbs-cont">
			<div class="bbs-txt">
				<pre><%out.print(articleDetail.get("DS_CONTENT"));%></pre>
			</div>
		</div>
	</div>
</div>
	
<script type="text/javascript">
eventBus.addListener({
	  id : 'articleBody'
	, onLoad : function(){
		$('#evaluationGood').click(function(){
			fnEvaluationGood();
		});
		
		$('#evaluationBad').click(function(){
			fnEvaluationBad();
		});
		
		$('#manLayerOpenBtn').click(function(event){
			boardCommon.callManLayer('<%=articleDetail.getString(0, "REG_USER_ID")%>', event);
		});
		
<%		if(!boardType.isInquiryHistoryYn()){%>
			fnIncreasedHitCount();
<%		}	%>
	}
	, onSearch : function(){
		
		
	}
});

function fnEvaluationGood(){
	var url = uxl.getFunctionUrl(_SCREEN_ID,'USERDEFINED4');
	var option = {
			data:{CD_EVALUATION:"01", ID_ARTICLE:'${paramMap.ID_ARTICLE}', ID_BOARD:'${paramMap.ID_BOARD}', ID_SUB:'${paramMap.ID_SUB}'}
		  , success:function(result) {
                	$('#evaluationGood').text(result.getDetail().CNT_GOOD);
                	$('#evaluationBad').text(result.getDetail().CNT_BAD);
			}
		  , async:true
	};
	uxl.callFunction(url, option);	
}

function fnEvaluationBad(){
	var url = uxl.getFunctionUrl(_SCREEN_ID,'USERDEFINED4');
	var option = {
			data:{CD_EVALUATION:"02", ID_ARTICLE:'${paramMap.ID_ARTICLE}', ID_BOARD:'${paramMap.ID_BOARD}', ID_SUB:'${paramMap.ID_SUB}'}
		  , success:function(result) {
	                	$('#evaluationGood').text(result.getDetail().CNT_GOOD);
	                	$('#evaluationBad').text(result.getDetail().CNT_BAD);
			}
		  , async:true
	};
	uxl.callFunction(url, option);
}

function fnIncreasedHitCount(){
	var url = uxl.getFunctionUrl(_SCREEN_ID,'UPDATE');
	var option = {
			data:{ID_ARTICLE:'${paramMap.ID_ARTICLE}', ID_BOARD:'${paramMap.ID_BOARD}', ID_SUB:'${paramMap.ID_SUB}'}
		  , success:function(result) {
			  	var count = $('#hitCount').text();
			  	$('#hitCount').text(parseInt(count, 10) + 1);
			}
		  , async:true
	};
	uxl.callFunction(url, option);
}

</script>