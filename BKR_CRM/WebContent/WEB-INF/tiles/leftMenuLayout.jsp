<%@page import="com.ubone.framework.util.ViewUtil"%>
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
	
	<!-- Menu Css/Js -->
	<link rel="stylesheet" type="text/css" href='<spring:url value="/uxl/menu/css/leftMenu.css"/>'/>
	
	<!-- Scroll Plugin -->
	<link rel="stylesheet" type="text/css" href="../../uxl/ext/scroll/css/jquery.mCustomScrollbar.css"/>
	<script type="text/javascript" charset="UTF-8" src="../../uxl/ext/scroll/jquery.mCustomScrollbar.min.js" /></script>
	<script type="text/javascript">
		$(document).ready(function(){
	
		  $('.left-nav > ul > li:has(ul)').addClass("has-sub");
	
		  $('.left-nav > ul > li > a').click(function() {
		    var checkElement = $(this).next();
		    
		    $('.left-nav li').removeClass('active');
		    $(this).closest('li').addClass('active');	
		    
		    
		    if((checkElement.is('ul')) && (checkElement.is(':visible'))) {
		      $(this).closest('li').removeClass('active');
		      checkElement.slideUp('normal');
		    }
		    
		    if((checkElement.is('ul')) && (!checkElement.is(':visible'))) {
		      $('.left-nav ul ul:visible').slideUp('normal');
		      checkElement.slideDown('normal');
		    }
		    
		    if (checkElement.is('div > ul')) {
		      return false;
		    } else {
		      return true;	
		    }		
		  });
	
		});
	</script>
	
	
	<title><%=ConfigHolder.APPLICATION_NAME%></title>
	<meta charset="UTF-8" />
</head>

<body class="ub-page left-menu ${screen.screenType}">
	<section class="ub-frame left">
		<div class="ub-layout lnb-wrap"> <!-- 왼쪽메뉴 전반적인 디자인 -->
			<div class="ub-layout menu lnb"> <!-- 왼쪽메뉴 꾸미기 -->
				<div class="tit-wrap">
					<h2 class="ub-control title">VOC처리</h2>				
				</div>
				<nav class="left-nav">
					<ul>
					   <li class="active"><a href="#"><strong>왼쪽메뉴 1</strong></a>
						  <ul>
							 <li><a href="#"><strong>왼쪽메뉴 1-1</strong></a></li>
							 <li class="current"><a href="#"><strong>왼쪽메뉴 1-2</strong></a></li>
							 <li><a href="#"><strong>왼쪽메뉴 1-3</strong></a></li>
						  </ul>								 
					   </li>
					   <li><a href="#"><strong>왼쪽메뉴 2</strong></a>
						  <ul>
							 <li><a href="#"><strong>왼쪽메뉴 2-1</strong></a></li>
							 <li><a href="#"><strong>왼쪽메뉴 2-2</strong></a></li>
						  </ul>
					   </li>
					   <li><a href="#"><strong>왼쪽메뉴 3</strong></a></li>
					   <li><a href="#"><strong>왼쪽메뉴 4</strong></a></li>
					   <li><a href="#"><strong>왼쪽메뉴 4</strong></a></li>
					   <li><a href="#"><strong>왼쪽메뉴 4</strong></a></li>
					   <li><a href="#"><strong>왼쪽메뉴 4</strong></a></li>
					   <li><a href="#"><strong>왼쪽메뉴 4</strong></a></li>
					   <li><a href="#"><strong>왼쪽메뉴 4</strong></a></li>
					   <li><a href="#"><strong>왼쪽메뉴 4</strong></a></li>
					   <li><a href="#"><strong>왼쪽메뉴 4</strong></a></li>
					   <li><a href="#"><strong>왼쪽메뉴 4</strong></a></li>
					   <li><a href="#"><strong>왼쪽메뉴 4</strong></a></li>
					   <li><a href="#"><strong>왼쪽메뉴 4</strong></a></li>
					   <li><a href="#"><strong>왼쪽메뉴 4</strong></a></li>
					   <li><a href="#"><strong>왼쪽메뉴 4</strong></a></li>
					   <li><a href="#"><strong>왼쪽메뉴 4</strong></a></li>
					   <li><a href="#"><strong>왼쪽메뉴 4</strong></a></li>
					   <li><a href="#"><strong>왼쪽메뉴 4</strong></a></li>
					   <li><a href="#"><strong>왼쪽메뉴 4</strong></a></li>
					   <li><a href="#"><strong>왼쪽메뉴 4</strong></a></li>
					   <li><a href="#"><strong>왼쪽메뉴 4</strong></a></li>
					   <li><a href="#"><strong>왼쪽메뉴 4</strong></a></li>
					   <li><a href="#"><strong>왼쪽메뉴 4</strong></a></li>
					   <li><a href="#"><strong>왼쪽메뉴end 끝</strong></a></li>						
					</ul>
				</nav>
									
				<script type="text/javascript">
					$('.ub-layout.menu.lnb').mCustomScrollbar({
						theme:"minimal-dark"
					});
				</script>
			</div>
		</div>		
	</section>
	<section class="ub-frame body">
		<jsp:include flush="true" page="/WEB-INF/jsp/include/pageLocation.jsp"/>
<!-- 		<div class="ub-layout location"></div> -->
		<div class="toggle-btn">
			<a href="#" id="toggle"><span>접힘펼침</span></a>
		</div>
		<script>
		$('#toggle').on('click', function() {
			$('.ub-page.left-menu').toggleClass('show-left');
		});
		</script>
		<div class="inner-contents-wrap"> 
			<!-- begin contents area -->
			<tiles:insertAttribute name="body"/>
			<!-- end contents area -->
		</div>
	</section>
</body>
</html>