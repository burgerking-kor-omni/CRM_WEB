<%--
 *
 *  설    명 :  카운터형 메인
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
	<section class="index counter-type">
		<h2>카운터형 메인</h2>
		<!-- s : top-section -->
		<div class="ub-layout top-section">
			<div class="count-area">
				<ul>
					<li>
						<h2 class="stit">칭찬</h2>
						<div class="count">
							<strong>23</strong>
						</div>
					</li>
					<li>
						<h2 class="stit">칭찬</h2>
						<div class="count">
							<strong>23</strong>
						</div>
					</li>
					<li>
						<h2 class="stit">칭찬</h2>
						<div class="count">
							<strong>23</strong>
						</div>
					</li>
					<li>
						<h2 class="stit">칭찬</h2>
						<div class="count">
							<strong>23</strong>
						</div>
					</li>
				</ul>
			</div>			
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