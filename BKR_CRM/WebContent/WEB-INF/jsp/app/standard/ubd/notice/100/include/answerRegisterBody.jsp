<%--
#*
 *  파 일 명 :  answerRegisterBody.jsp
 *  설    명 :  답변등록화면 본문영역 (CK EDITOR)
 *  작 성 자 :  ByeongGiKim
 *  작 성 일 :  2017-02-28
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

<input type=hidden id="FG_NOTICE" name="FG_NOTICE" value="N">
<div class="ub-layout details">
	<div class="ub-control bbs-reg">
<%	
	String[] categoryCode = board.getBoardCategory();
	if(categoryCode != null){
		if(categoryCode.length != 0){
%>	
		<div class="bbs-tit">
			<div class="tit" style="width:10%;"><strong class="bar">분류</strong></div>
			<div class="insert" style="width:80%;">
				<select id="NM_CATEGORY" name="NM_CATEGORY" class="ub-control select " style="width:200px;" size="1">
					<option value="">선택안됨</option>
<%
					for(int i = 0 ; i < categoryCode.length ; i++){
%>
						<option value="<%=categoryCode[i]%>"><%=categoryCode[i]%></option>
<%			
					}
%>
				</select>
			</div>
		</div>
<%
		}
	}
%>
		<div class="bbs-tit">
			<div class="tit" style="width:10%;"><strong class="bar"><label for="DS_TITLE">제목</label></strong></div>
			<div class="insert" style="width:80%;">
				<input type="text" class="ub-control input-text" id="DS_TITLE" name="DS_TITLE" style="width:90%;" metaessential="1" />
			</div>
		</div>
		<div class="editor">
			<textarea class="ub-control textarea " id="DS_CONTENT" name="DS_CONTENT" style="width:99%;" rows="10"></textarea>
			<input type=hidden id="CONTENT_EDITOR" name="CONTENT_EDITOR" value="N">
		</div>
	</div>
</div>

<script type="text/javascript">
eventBus.addListener({
	  id : 'answerRegisterBody'
	, onLoad : function(){
		
	}
	, onRegist : function(){
		var content = uxl.Editor.getData("DS_CONTENT");
		if(content == null || content == ''){
			uxl.showMessage('내용을 입력해주세요.');
			content.focus();
			return false;
		}
		
	}
});

/**
 * CK EDITOR INIT FUNCTION
 * 화면 로딩 후 초기화 설정 	
 */
uxl.onLoad(function() {
	
	uxl.Editor('DS_CONTENT' , {height:'300px'});
});
</script>