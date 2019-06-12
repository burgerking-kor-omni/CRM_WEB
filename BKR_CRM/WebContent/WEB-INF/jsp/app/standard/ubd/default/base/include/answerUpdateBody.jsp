<%--
#*
 *  파 일 명 :  answerUpdateBody.jsp
 *  설    명 :  답변수정화면 본문영역
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
					for(int i=0; i < categoryCode.length; i++){
						String code = categoryCode[i];
						String selected = (code == articleDetail.getString(0, "NM_CATEGORY"))?"selected":"";
						out.println("<option VALUE=\""+code+"\" "+selected+">"+code+"</option>\r\n");
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
				<input type="text" class="ub-control input-text" id="DS_TITLE" name="DS_TITLE" style="width:90%;" value="<%=articleDetail.get("DS_TITLE")%>" metaessential="1" />
			</div>
		</div>
		<div class="editor">
			<textarea class="ub-control textarea " id="DS_CONTENT" name="DS_CONTENT" style="width:99%;" rows="10" ><%=articleDetail.get("DS_CONTENT")%></textarea>
			<input type=hidden id="CONTENT_EDITOR" name="CONTENT_EDITOR" value="N">
		</div>
	</div>
</div>

<script type="text/javascript">
eventBus.addListener({
	  id : 'updateBody'
	, onLoad : function(){
		var nmCategory = '<%=articleDetail.get("NM_CATEGORY")%>';
		if(nmCategory != null && nmCategory != ''){
			$('#NM_CATEGORY').val(nmCategory);
		}
		
		
	}
	, onUpdate : function(){
		var content = $('#DS_CONTENT');
		if(content.val() == null || content.val() == ''){
			uxl.showMessage('내용을 입력해주세요.');
			content.focus();
			return false;
		}
		
	}
});

</script>