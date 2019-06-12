<%--
#*
 *  파 일 명 :  listHeader.jsp
 *  설    명 :  목록화면 목록상단영역
 *  작 성 자 :  
 *  작 성 일 :  
 *  버    전 :  1.0
 *  기타사항 :
 *  Copyrights 2013 by ㈜ 유비원. All right reserved.
*# 
--%>
<%@page import="com.ubone.standard.ubboard.common.domain.BoardType"%>
<%@page import="com.ubone.framework.data.Parameter"%>
<%@page import="com.ubone.framework.util.ViewUtil"%>
<%@page import="com.ubone.framework.data.DataList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	BoardType boardType = (BoardType)ViewUtil.getResult().getExtendAttribute("boardType");
%>

<div class="ub-layout floatBox count-view">
	<div class="ub-layout leftBox"   style="width:30%; ">
<!-- 		<span class="ub-control total-count" id="totalCount"> 전체 <em></em>건</span> -->
	</div>
	<div class="ub-layout rightBox"   style="width:69%; text-align:right;">
<%	if(boardType.isNoticeYn()){	%>
		<input id="ckNoticeHide" class="ub-control input-checkbox" type="checkbox"><label>공지글 숨기기</label>
<%	}	%>
		<select id="pageSize" name="pageSize" class="ub-control select " style="width:100px;" size="1" defaultvalue="${paramMap.pageSize}">
			<option value="10">10개씩 보기</option>
			<option value="20">20개씩 보기</option>
			<option value="50">50개씩 보기</option>
		</select>
	</div>
</div>

<script type="text/javascript">
eventBus.addListener({
	  id : 'listHeader'
	, onLoad : function(){
	<%	if(boardType.isNoticeYn()){	%>	
		$('#ckNoticeHide').click(function(){
			//공지글숨기기 체크시 쿠키등록, 체크해제시 쿠키제거
			var checked = $('#ckNoticeHide')[0].checked;
			if(checked){
				$('tr[name="noticeRow"]').hide();
				$.cookie("${paramMap.ID_BOARD}Notice","${user.id}", {expires: 7});
			}else{
				$('tr[name="noticeRow"]').show();
				$.cookie("${paramMap.ID_BOARD}Notice", null);
			}
		});
	<%	}	%>
	
		$('#pageSize').change(function(){
		    boardCommon.initPageNum();
			eventBus.triggerEvent("onSearch");
		});
		
		$('#pageSize > option[value="${paramMap.pageSize}"]').selected();
		
		
	}
	,onSearchComplete : function(){
	<%	if(boardType.isNoticeYn()){	%>
			if($.cookie("${paramMap.ID_BOARD}Notice") == '${user.id}'){
				//쿠키에 공지글숨기기 값이 있는 경우 공지글을 숨긴다.
				$('#ckNoticeHide')[0].checked = true;
				$('tr[name="noticeRow"]').hide();
			}
	<%	}	%>
	}
});

function fnNoticeHide(){
	
}

</script>