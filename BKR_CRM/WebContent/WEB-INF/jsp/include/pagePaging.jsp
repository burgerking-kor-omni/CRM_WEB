<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page errorPage="/jsp/error/errorPage.jsp" %>
<%@ page import="com.ubone.framework.ConfigHolder"%>


<%@ page import="com.ubone.framework.util.ViewUtil"%>
<%@ page import="com.ubone.framework.data.DataList"%>
<%@ page import="com.ubone.framework.data.Parameter"%>
<%@ page import="com.ubone.framework.ConstantHolder"%>
<%@ page import="com.ubone.framework.data.ServiceMessage"%>

<!--
	paging
 -->
   
<script language="javascript" type="text/javascript">
	var _KEY_PAGE_NUMBER = "<%= ConstantHolder.KEY_PAGE_NUMBER%>";
	var _KEY_PAGE_BLOCK  = "<%= ConstantHolder.KEY_PAGE_BLOCK%>";
	
</script>

<%
	int currBlock = ViewUtil.getResult().getServiceMessage().getPageBlock();
	int totalPages = ViewUtil.getResult().getServiceMessage().getPageCount();
	int totalCount = ViewUtil.getResult().getServiceMessage().getTotalCount();
	int pageSize    = ConfigHolder.BLOCK_SIZE;
	int totalBlocks = totalPages % pageSize;
	
	if(totalBlocks == 0){
		totalBlocks = totalPages / pageSize;
	}else{
		totalBlocks = totalPages / pageSize + 1;
	}
	
	if((currBlock+1 > totalBlocks) && currBlock != 0 ){
		currBlock = totalBlocks - 1;
	}
	
	// 시작페이지, 끝페이지
	int startPageNo = currBlock * pageSize + 1;
	int endPageNo = currBlock + pageSize + pageSize;
	
	if(endPageNo > totalPages){
		endPageNo = totalPages;
	}
	
	// 2. HTML 만들기..
	int nextBlock = currBlock + 1; //다음 페이지 블럭
	int prevBlock = currBlock - 1; //이전 페이지 블럭
	
	endPageNo = currBlock * pageSize + pageSize;
	
	if(endPageNo > totalPages){
		endPageNo = totalPages;
	}

%>

	<div id="main_list_paging" class="ub-layout pagging">
		<%-- <div><%=totalCount %></div> 
		<div class="paging_center">--%>
<%
		if(currBlock > 0){
			int temp = prevBlock * pageSize + 1;
			out.println("<a href=\"#\" title=\"이전\" class=\"ub-control button imgBtn img-pagging-prev\" param="+temp+":"+prevBlock+" ><span>이전</span></a>");
		}
		int pageNum = ViewUtil.getResult().getServiceMessage().getPageNum();
		
		for(int no= startPageNo ; no <= endPageNo; no++ ){
			if(no == totalCount){
				out.println("<span>"+no+"</span>");
			}else if(endPageNo > startPageNo){
				out.println("<a href=\"#\" param="+no+":"+currBlock+">"+no+"</a>");
			}
		}
		if(totalBlocks > nextBlock){
			int temp = nextBlock * pageSize +1;
			out.println("<a href=\"#\" title=\"다음\" class=\"ub-control button imgBtn img-pagging-next\" param="+temp+":"+nextBlock+" ><span>다음</span></a>");
		}
%>
		<%-- </div> --%>
	</div>
