<%--
#*
 *  파 일 명 :  articleBottomButton.jsp
 *  설    명 :  게시물상세화면 하단 버튼영역
 *  작 성 자 :  
 *  작 성 일 :  
 *  버    전 :  1.0
 *  기타사항 :
 *  Copyrights 2013 by ㈜ 유비원. All right reserved.
*# 
--%>
<%@page import="com.ubone.standard.ubboard.common.domain.BoardType"%>
<%@page import="com.ubone.standard.ubboard.common.domain.Board"%>
<%@page import="com.ubone.framework.util.UserUtil"%>
<%@page import="com.ubone.framework.engine.domain.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.ubone.framework.util.ViewUtil"%>
<%@page import="com.ubone.framework.data.DataList"%>
<%
	Board board = (Board)ViewUtil.getResult().getExtendAttribute("board");
	BoardType boardType = (BoardType)ViewUtil.getResult().getExtendAttribute("boardType");
	Boolean hasAdmin = (Boolean)ViewUtil.getResult().getExtendAttribute("hasAdmin");
	DataList articleDetail = ViewUtil.getResult().getDataList("articleDetail");
	User user = UserUtil.getLoginUser();
	String userId = user.getId();
	String regUserId = articleDetail.get("REG_USER_ID");
	String noArticle = articleDetail.get("NO_ARTICLE");
%>
<div class="ub-layout button bottom">
	<div class="ub-layout floatBox">
		<div class="ub-layout leftBox" style="width:49%; text-align:left;" id="divBottomLeft">
<%	if(boardType.isPreNextYn() && "0".equals(articleDetail.getString(0, "DEPTH"))){	%>
			<span class="ub-control button bottom left icon" title="PreArticle" onclick="javascript:fnPreArticle();">
				<a href="#none" title="PreArticle">이전글</a>
			</span>
			<span class="ub-control button bottom left icon" title="NextArticle" onclick="javascript:fnNextArticle();">
				<a href="#none" title="NextArticle">다음글</a>
			</span>
<%	}	 %>		
		</div>
		<div class="ub-layout rightBox" style="width:49%" id="divBottomRight">
<%	if(boardType.isAnswerYn()){	%>
			<span class="ub-control button bottom icon" title="RegistAnswer" onclick="javascript:fnRegistAnswer();">
				<a href="#none" title="RegistAnswer">답글</a>
			</span>
<%	}	 %>	
<%	if(userId.equals(regUserId) || hasAdmin){	%>		
			<span class="ub-control button bottom icon" title="Update" onclick="javascript:fnUpdateArticle();">
				<a href="#none" title="Update">수정</a>
			</span>
			<span class="ub-control button bottom icon" title="Delete" onclick="javascript:fnDeleteArticle();">
				<a href="#none" title="Delete">삭제</a>
			</span>
<%	}	 %>	
		</div>
	</div>
</div>

<script type="text/javascript">
eventBus.addListener({
	  id : 'articleBottomButton'
	, onLoad : function(){
		
		
	}
});

function fnRegistAnswer(){
	var param = "?ID_BOARD=${paramMap.ID_BOARD}&ID_ARTICLE=${paramMap.ID_ARTICLE}&ID_SUB=${paramMap.ID_SUB}";
	boardCommon.moveAnswerRegister(param);
}

function fnPreArticle(){
	var url = uxl.getFunctionUrl(_SCREEN_ID,'USERDEFINED8');
	var option = {
			data:{ID_BOARD:'${paramMap.ID_BOARD}'
			    , ID_ARTICLE:'${paramMap.ID_ARTICLE}'
			    , ID_SUB:'${paramMap.ID_SUB}'
			    , NO_ARTICLE:'<%=noArticle %>'
			    }
		  , success:function(result) {
			  	var rowCnt = result.getDataList(0).rowCount;
			    if(rowCnt == 0){
					uxl.showMessage('이전글이 없습니다.');
				}else{
					var articleId = result.getDataList(0).rows[0].ID_ARTICLE;
				    fnMoveOtherDetail(articleId);	
				}
			}
		  , async:true
	};
	uxl.callFunction(url, option);
}

function fnNextArticle(){
	var url = uxl.getFunctionUrl(_SCREEN_ID,'USERDEFINED9');
	var option = {
            data:{ID_BOARD:'${paramMap.ID_BOARD}'
                , ID_ARTICLE:'${paramMap.ID_ARTICLE}'
                , ID_SUB:'${paramMap.ID_SUB}'
                , NO_ARTICLE:'<%=noArticle %>'
                }
		  , success:function(result) {
			  	var rowCnt = result.getDataList(0).rowCount;
			    if(rowCnt == 0){
			    	uxl.showMessage('다음글이 없습니다.');
				}else{
				  	var articleId = result.getDataList(0).rows[0].ID_ARTICLE;
				  	fnMoveOtherDetail(articleId);
				}
			}
		  , async:true
	};
	uxl.callFunction(url, option);
}

function fnMoveOtherDetail(articleId){
	var param = "?ID_BOARD=${paramMap.ID_BOARD}&ID_ARTICLE="+articleId+"&ID_SUB=${paramMap.ID_SUB}";
	boardCommon.moveArticle(param);
}

function fnUpdateArticle(){
	var articleDepth  = '<%=articleDetail.get("DEPTH")%>';
	var param = "?ID_BOARD=${paramMap.ID_BOARD}&ID_ARTICLE=${paramMap.ID_ARTICLE}&ID_SUB=${paramMap.ID_SUB}";
	if(articleDepth == 0){
		boardCommon.moveArticleUpdate(param);
	}else{
		boardCommon.moveAnswerUpdate(param);
	}
}

function fnDeleteArticle(){
	var url = uxl.getFunctionUrl(_SCREEN_ID,'DELETE');
	var option = {
			data:{ID_BOARD:'${paramMap.ID_BOARD}', ID_ARTICLE:'${paramMap.ID_ARTICLE}', ID_SUB:'${paramMap.ID_SUB}'}
		  , success:function(result) {
			  var param = "?ID_BOARD=${paramMap.ID_BOARD}&ID_SUB=${paramMap.ID_SUB}";
			  boardCommon.moveList(param);
			}
		  , async:true
		  , message : {
				confirm : uxl.getMessage('@message.common.delete.confirm'),
				fail : uxl.getMessage('@message.common.delete.fail')
			}
	};
	uxl.callFunction(url, option);	
}

</script>

