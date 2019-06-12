<%--
#*
 *  파 일 명 :  listSearch.jsp
 *  설    명 :  목록화면 검색영역
 *  작 성 자 :  
 *  작 성 일 :  
 *  버    전 :  1.0
 *  기타사항 :
 *  Copyrights 2013 by ㈜ 유비원. All right reserved.
*# 
--%>
<%@page import="com.ubone.framework.util.ViewUtil"%>
<%@page import="com.ubone.standard.ubboard.common.domain.Board"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	Board board = (Board)ViewUtil.getResult().getExtendAttribute("board");
%>

<div class="ub-layout board-sch">
<%	
	String[] categoryCode = board.getBoardCategory();
	if(categoryCode != null){
		if(categoryCode.length != 0){
%>	
			<select id="NM_CATEGORY" name="NM_CATEGORY" class="ub-control select " style="width:80px;" size="1" defaultvalue="${paramMap.NM_CATEGORY}">
				<option value="">카테고리</option>
<%				
				for(int i = 0 ; i < categoryCode.length ; i++){	
					String selected = categoryCode[i].equals(ViewUtil.getParameter().getValue("NM_CATEGORY"))?"selected":"";				
%>
					<option value="<%=categoryCode[i]%>" <%=selected%>><%=categoryCode[i]%></option>
<%				}	%>
			</select>
<%
		}
	}
%>

	<select id="SEARCH_KEY" name="SEARCH_KEY" class="ub-control select " style="width:80px;" size="1" defaultvalue="${paramMap.SEARCH_KEY}">
		<option value="DS_TITLE">제목</option>
<!-- 		<option value="DS_CONTENT">내용</option> -->
		<option value="REG_USER_NM">작성자</option>
	</select>
	<input type=text  class="ub-control input-text " id="SEARCH_VALUE" name="SEARCH_VALUE" style="text-align:left;width:170px;" value="${paramMap.SEARCH_VALUE}">
	<input type=text style="width:0px;visibility:hidden;">
	<span class="ub-control button search" id="btnSearch">
		<a href="#none" title="Search">검색</a>
	</span>
</div>

<script type="text/javascript">
eventBus.addListener({
	  id : 'listSearch'
	, onLoad : function(){
		$('#btnSearch').click(function(){
			boardCommon.initPageNum();
			eventBus.triggerEvent("onSearch");
		});
		
		$('#SEARCH_KEY > option[value="${paramMap.SEARCH_KEY}"]').selected();  
		
	}
});

</script>