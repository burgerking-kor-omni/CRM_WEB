<%--
 *
 *  설    명 :  박스형 메인
 *  작 성 자 :  
 *  작 성 일 :  2016-02-22
 *  버    전 :  1.0
 *  기타사항 :
 *  Copyrights 2011 by ㈜ 유비원. All right reserved.
 * 
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.ubone.framework.ConfigHolder"%>
<%@ include file="/WEB-INF/jsp/include/pageTagLibs.jsp"%>
<!DOCTYPE html>
<html>
<head>
	<jsp:include flush="true" page="/WEB-INF/jsp/include/pageMeta.jsp"/>
	<jsp:include flush="true" page="/WEB-INF/jsp/include/pageHeader.jsp"/>
	<jsp:include flush="true" page="/WEB-INF/jsp/include/pageCss.jsp"/>
	<jsp:include flush="true" page="/WEB-INF/jsp/include/pageJs.jsp"/>
	<!-- Main Css -->
	<link rel="stylesheet" type="text/css" href='<spring:url value="/page/css/main.css"/>'/>
	<title><%=ConfigHolder.APPLICATION_NAME%></title>
	<meta charset="UTF-8" />
	<!--[if IE]> <script src="<spring:url value='/page/js/html5.js'/>"></script> <![endif]-->	
</head>
<body class="ub-page main">
	<section class="index box-type">
		<h2>박스형 메인</h2>
		<!-- s : top-section -->
		<div class="ub-layout top-section">
			<!-- s : l-sub-section -->
			<div class="l-sub-section">
				<div class="ub-control tit-h2">
					<h2><strong>민원 현황</strong></h2>
					<div class="r-cont"></div>
				</div>
				<div class="inner">
					<div class="ub-control bbs-list01">
						<ul>
							<li>
								<div class="list-txt01"><a href="#" class="ellipsis">링크는 길게 길게 해도 절대 네버 떨어지지 않고 땡땡땡 처리</a></div>
							</li>
							<li class="even">
								<div class="list-txt01"><a href="#" class="ellipsis">링크는 길게 길게 해도 절대 네버 떨어지지 않고 땡땡땡 처리</a></div>
							</li>
						</ul>
					</div>
				</div>
			</div>
			<!-- e : l-sub-section -->
			
			<!-- s : m-sub-section -->
			<div class="m-sub-section">
				<div class="ub-control tit-h2">
					<h2><strong>민원 현황</strong></h2>
					<div class="r-cont"></div>
				</div>
				<div class="inner">
					내용
				</div>
			</div>
			<!-- e : m-sub-section -->
			
			<!-- s : r-sub-section -->
			<div class="r-sub-section">
				<div class="ub-control tit-h2">
					<h2><strong>민원 현황</strong></h2>
					<div class="r-cont"></div>
				</div>
				<div class="inner">
					내용
				</div>
			</div>
			<!-- e : r-sub-section -->
		</div>
		<!-- e : top-section -->
		<!-- s : btm-section -->
		<div class="ub-layout btm-section">
			<!-- s : l-sub-section -->
			<div class="l-sub-section">
				<div class="ub-control tit-h2">
					<h2><strong>민원 현황</strong></h2>
					<div class="r-cont"></div>
				</div>
				<div class="inner">
					내용
				</div>
			</div>
			<!-- e : l-sub-section -->
			
			<!-- s : m-sub-section -->
			<div class="m-sub-section">
				<div class="ub-control tit-h2">
					<h2><strong>민원 현황</strong></h2>
					<div class="r-cont"></div>
				</div>
				<div class="inner">
					내용
				</div>
			</div>
			<!-- e : m-sub-section -->
			
			<!-- s : r-sub-section -->
			<div class="r-sub-section">
				<div class="ub-control tit-h2">
					<h2><strong>민원 현황</strong></h2>
					<div class="r-cont"></div>
				</div>
				<div class="inner">
					내용
				</div>
			</div>
			<!-- e : r-sub-section -->
		</div>
		<!-- e : btm-section -->
	</section>	
</body>
</html>