<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page errorPage="/jsp/error/errorPage.jsp" %>
<%@ page import="com.ubone.framework.ConfigHolder"%>
<%@ page import="com.ubone.framework.ConstantHolder"%>
<%@ page import="com.ubone.framework.data.Parameter"%>
<%@ page import="com.ubone.framework.data.Result"%>
<%@ page import="com.ubone.framework.data.ServiceMessage"%>
<%@ page import="com.ubone.framework.engine.domain.Screen"%>
<%@ page import="com.ubone.framework.engine.domain.Function"%>
<%@ page import="com.ubone.framework.engine.domain.ScreenLayoutType"%>
<%@ page import="com.ubone.framework.engine.domain.ScreenType"%>
<%@ page import="com.ubone.framework.engine.domain.UserContainer"%>
<%@ page import="com.ubone.framework.engine.domain.User"%>
<%@ page import="com.ubone.framework.security.token.TokenContainer"%>

<%@ include file="/WEB-INF/jsp/include/pageTagLibs.jsp"%>
<!DOCTYPE html>
<html>
<head>
	<jsp:include flush="true" page="/WEB-INF/jsp/include/pageMeta.jsp"/>
	<jsp:include flush="true" page="/WEB-INF/jsp/include/pageHeader.jsp"/>
	<jsp:include flush="true" page="/WEB-INF/jsp/include/pageCss.jsp"/>
	<jsp:include flush="true" page="/WEB-INF/jsp/include/pageJs.jsp"/>
	
	<title><%=ConfigHolder.APPLICATION_NAME%></title>

	<script language="javascript" type="text/javascript">
		var layout_name = "tabLayout";
		
		uxl.onLoad(function() {
			uxl.time('layout onLoad');
		});
		
    	// complete initilize function
    	uxl.onLoadComplete(function() {
    		uxl.time('layout onLoadComplete');
    	});
	</script>

	<script type="text/javascript">
	
		var layout_name = "Inner";
		var includeMeIframe = null;
		var heightFix = 24;
		
		function resize() {
			$('div.inner-contents-wrap').resize();
		}
		
		// before initilize function
		$(document).ready(function(){
			$('div.inner-contents-wrap').resize(function() {
				if(parent) {
					if(uxl.isNull(includeMeIframe)) {
						var iframes = $('iframe[src*="${screen.id}"]', $(parent.document));
						if(iframes.size() > 0) {
							iframes.each(function() {
								if(this.contentWindow.document.body == document.body) {
									includeMeIframe = this;
									return false;
								}
							});
						}
					}
					if(uxl.isNotNull(includeMeIframe)) {
						var iheight = $('div.inner-contents-wrap').outerHeight();
						$(includeMeIframe).height(iheight + heightFix);
						if(parent.resize && uxl.isFunction(parent.resize)) {
							parent.resize();
						}
					}
				}
			});
			
			resize();
		});
		
	</script>	
</head>
<body class="ub-page tab ${screen.screenType}">
	<script type="text/javascript">
		// 상위 Parent의 Theme를 찾는 스크립트
		var $body = $('body', $(parent.document));
		$('body').addClass($body.attr('theme'));
	</script>
	<section class="ub-frame body">
		<div class="inner-contents-wrap"> 
			<!-- begin tab contents area : ${screen.id} -->
			<tiles:insertAttribute name="body"/>
			<!-- end tab contents area : ${screen.id} -->
		</div>
	</section>
</body>
</html>