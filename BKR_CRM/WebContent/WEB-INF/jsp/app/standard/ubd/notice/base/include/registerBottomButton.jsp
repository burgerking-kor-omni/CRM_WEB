<%--
#*
 *  파 일 명 :  registerBottomButton.jsp
 *  설    명 :  게시물등록화면 하단 버튼영역
 *  작 성 자 :  
 *  작 성 일 :  
 *  버    전 :  1.0
 *  기타사항 :
 *  Copyrights 2013 by ㈜ 유비원. All right reserved.
*# 
--%>
<%@page import="org.apache.commons.lang.StringUtils"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.ubone.framework.util.ViewUtil"%>
<%@page import="com.ubone.framework.data.DataList"%>
<%
	String registFormId = StringUtils.defaultString(request.getParameter("registFormId"), "");
%>

<div class="ub-layout button bottom">
	<span class="ub-control button bottom icon" id="btnRegistArticle" title="Regist">
    	<a href="#none" title="Regist"><span class="ico-save"></span>등록</a>
	</span>
</div>

<script type="text/javascript">
eventBus.addListener({
	  id : 'registerBottomButton'
	, onLoad : function(){
		$('#btnRegistArticle').click(function(){
			eventBus.triggerEvent("onRegist");
		});
		
		
	}
	, onRegist : function(){
		fnRegist();
		
		
	}
});

function fnRegist(){	
	var url = uxl.getFunctionUrl(_SCREEN_ID,'REGIST');
	var option = {
			data:{}
		  , validator:function(data,targetForm) {
				var returnVal = false;
				//필수항목체크
				if(uxl.checkRequiredFields(targetForm)) {
					returnVal = true;
				}
				return returnVal;
		    }
		  , success:function(result) {
			 	var articleId = result.getResultKey()[1];
			 	var param = "?ID_BOARD=${paramMap.ID_BOARD}&ID_ARTICLE="+articleId+"&ID_SUB=${paramMap.ID_SUB}";
				boardCommon.moveArticle(param);
			}
		  , async:true
		  , message : {
				confirm : uxl.getMessage('@message.common.insert.confirm'),
				fail : uxl.getMessage('@message.common.insert.fail')
			}
	};
	uxl.callSubmitFunction('<%=registFormId%>', url, option);
}

</script>