<%--
#*
 *  파 일 명 :  boardFileControl.jsp
 *  설    명 :  게시판 파일컨트롤
 *  작 성 자 :  
 *  작 성 일 :  
 *  버    전 :  1.0
 *  기타사항 :
 *  Copyrights 2013 by ㈜ 유비원. All right reserved.
*# 
--%>
<%@page import="org.apache.commons.lang.StringUtils"%>
<%@page import="com.ubone.standard.ubboard.common.domain.BoardType"%>
<%@page import="com.ubone.framework.ConstantHolder"%>
<%@page import="com.ubone.framework.util.ViewUtil"%>
<%@page import="com.ubone.framework.data.DataList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	BoardType boardType = (BoardType)ViewUtil.getResult().getExtendAttribute("boardType");
	String readOnly = request.getParameter("readOnly");
	String articleId = StringUtils.defaultString(request.getParameter("articleId"), "");
	String boardId = StringUtils.defaultString(request.getParameter("boardId"), "");
	String subId = StringUtils.defaultString(request.getParameter("subId"), "-");
%>

<%	if(boardType.isFileYn()){	%>	
<div class="ub-layout details">
	<div class="ub-control stit">
		<strong class="title">파일첨부</strong>
	</div>
	<div class="floatBox file-attach">
		<div class="ub-layout file-box">
			<div class="sort-image" id="divFile">
				<ul>
<!-- 					<li> -->
<!-- 						<div class="thumb"> -->
<!-- 							<div class="layer"> -->
<!-- 								<ul> -->
<!-- 									<li><a href="#">다운로드</a></li> -->
<!-- 									<li><a href="#">미리보기</a></li> -->
<!-- 								</ul> -->
<!-- 							</div> -->
<!-- 							<div class="img"><img src="../page/images/board/@thumb.jpg" alt="" /></div> -->
<!-- 							<div class="file-name"><span><img src="../page/images/board/ico_file.png" alt="파일" />pic.jpg</span></div> -->
<!-- 							<span class="close"><a href="#" class="blind">삭제</a></span> -->
<!-- 						</div>						 -->
<!-- 					</li> -->
<!-- 					<li> -->
<!-- 						<div class="thumb"> -->
<!-- 							<div class="img"><img src="../page/images/board/@thumb.jpg" alt="" /></div> -->
<!-- 							<div class="file-name"><span><img src="../page/images/board/ico_file.png" alt="파일" />pic.jpg</span></div> -->
<!-- 						</div> -->
<!-- 					</li> -->
<!-- 					<li> -->
<!-- 						<div class="thumb"> -->
<!-- 							<div class="img"><img src="../page/images/board/thumb_excel.jpg" alt="" /></div> -->
<!-- 							<div class="file-name"><span><img src="../page/images/board/ico_file.png" alt="파일" />요거슨엑세루.jpg</span></div> -->
<!-- 						</div> -->
<!-- 					</li> -->
				</ul>
			</div>
		</div>
	<%	if("false".equals(readOnly)){ %>
		<div id="divFileUp" name="divFileUp" class="div-dropBox">
			<article id="dndFile" name="dndFile" class="ub-dnd-image">
				<div class="holder"></div>
			</article>
		</div>
		<div class="progress_box"></div>
	<%	} %>
		
	</div>
	

	<!-- 파일 미리보기 -->
<!-- 	<div style=""> -->
<!-- 		<div class="pre-layer" style="width:436px;"> -->
<!-- 			<div class="pre-layer-header"> -->				
<!-- 					<strong class="ellipsis">pic.jpg 미리보기</strong> -->				
<!-- 				<span class="close"><a href="#"><span>미리보기 닫기</span></a></span> -->
<!-- 			</div> -->
<!-- 			<div class="pre-layer-body"> -->
<!-- 				<div class="inner"> -->
<!-- 					<div class="img"><img src="../page/images/board/@preview.jpg" alt="" /></div> -->
<!-- 				</div> -->
<!-- 				<div class="bottom-btn"> -->
<!-- 					<a href="#"><span>다운받기</span></a> -->
<!-- 				</div> -->
<!-- 			</div> -->
<!-- 		</div> -->
<!-- 	</div> -->
	<!-- 파일 미리보기 -->
</div>


<script type="text/javascript">
eventBus.addListener({
	  id : 'boardFileControl'
	, onLoad : function(){
		fnRunFileControl();
		
	}
	, onSearch : function(){

		
	}
});

function fnRunFileControl(){
	var readOnly = <%=readOnly%>;
// 	if(!readOnly){		
		var acceptedType = new Array();
		
		<%
			String[] fileExt = boardType.getFileExtension();
			if(fileExt != null && fileExt.length != 0){
				for(int i = 0 ; i < fileExt.length ; i++){
		%>
				acceptedType.push('<%=fileExt[i]%>');
		<%		}
			}		%>
		
		var options = {
			  divId : 'dndFile'
			, attachType : 'dndFile'
			, readonly : readOnly
			, targetId : 'divFile'
			, formId : 'defaultForm'
			, acceptedType : acceptedType
			, maxFileVolume : '<%=boardType.getFileVolume()%>'
			, maxFileCount : '<%=boardType.getMaxFileCount()%>'
			, listner : null 
		};
		dndFile.dndAction(options);
// 	}
// 	fnLoadingFile(readOnly);
}

function fnLoadingFile(readOnly){
	var url = uxl.getFunctionUrl(_SCREEN_ID,'USERDEFINED7');
	var option = {
			data:{ID_BOARD:'<%=boardId%>', ID_ARTICLE:'<%=articleId%>', ID_SUB:'<%=subId%>'}
	  	  , success:function(result) {
	  			dndFile.loadingFile(result.getDataList('<%=ConstantHolder.KEY_FILEINFO%>'), "divFile", {readOnly:readOnly});
	  	  }
	  	  , async:true
	};
	uxl.callFunction(url, option);	
}
</script>

<%	} %>