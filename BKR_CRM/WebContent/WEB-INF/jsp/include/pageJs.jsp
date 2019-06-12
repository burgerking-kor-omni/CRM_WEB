<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page errorPage="/jsp/error/errorPage.jsp" %>
<%@ page import="com.ubone.framework.ConfigHolder"%>
<%@ include file="/WEB-INF/jsp/include/pageTagLibs.jsp"%>
	<!--[if IE]> <script src="<spring:url value='/page/js/html5.js'/>"></script> <![endif]-->
	<!--[If lt IE 9]><script src="<spring:url value='/page/js/placeholder.js'/>"></script><![endif]--> <!-- ie 하위버전 대응 -->
	<!-- Common Js file -->
	<script type="text/javascript" charset="UTF-8" src="<spring:url value='/uxl/ext/jquery/jquery-1.8.3.min.js'/>"></script>
	<script type="text/javascript" charset="UTF-8" src="<spring:url value='/uxl/ext/jquery/ui/jquery-ui-1.9.2.min.js'/>"></script>
	
	<script type="text/javascript" charset="UTF-8" src="<spring:url value='/uxl/ext/jquery/plugin/jquery.cookie.js'/>"></script>
	<script type="text/javascript" charset="UTF-8" src="<spring:url value='/uxl/ext/jquery/plugin/fancybox/jquery.fancybox-1.3.4.pack.js'/>"></script>
	<script type="text/javascript" charset="UTF-8" src="<spring:url value='/uxl/ext/jquery/plugin/jquery.form.js'/>"></script>
	<script type="text/javascript" charset="UTF-8" src="<spring:url value='/uxl/ext/jquery/plugin/jquery.layout.min.js'/>"></script>

	<!-- jquery-mask -->
	<script type="text/javascript" charset="UTF-8" src="<spring:url value='/uxl/ext/mask/jquery.mask.js'/>"></script>

	<!-- jqGrid 4.4.5 -->
	<script type="text/javascript" charset="UTF-8" src="<spring:url value='/uxl/ext/jqGrid/js/i18n/grid.locale-kr.js'/>"></script>
	<script type="text/javascript" charset="UTF-8" src="<spring:url value='/uxl/ext/jqGrid/js/jquery.jqGrid.min.js'/>"></script>

	<!-- MutiSelect 1.3 -->
	<script type="text/javascript" charset="UTF-8" src="<spring:url value='/uxl/ext/multiselect/jquery.multiselect.filter.js'/>"></script>
	<script type="text/javascript" charset="UTF-8" src="<spring:url value='/uxl/ext/multiselect/jquery.multiselect.js'/>"></script>

	<ub:script type="text/javascript" charset="UTF-8" src="/uxl/ext/multiselect/i18n/jquery.multiselect.kr.js" 
				ko="/uxl/ext/multiselect/i18n/jquery.multiselect.kr.js" 
				en="/uxl/ext/multiselect/i18n/jquery.multiselect.en.js"
				></ub:script>
	
<%-- <c:choose> --%>
<%-- 	<c:when test="${CURR_LANG_CD == 'ko'}"> --%>
<%-- 	<script type="text/javascript" charset="UTF-8" src="<spring:url value='/uxl/ext/multiselect/i18n/jquery.multiselect.kr.js'/>"></script> --%>
<%-- 	</c:when> --%>
<%-- 	<c:when test="${CURR_LANG_CD == 'en'}"> --%>
<%-- 	<script type="text/javascript" charset="UTF-8" src="<spring:url value='/uxl/ext/multiselect/i18n/jquery.multiselect.en.js'/>"></script> --%>
<%-- 	</c:when> --%>
<%-- </c:choose> --%>
	
	<!-- dynatree-1.2.4 -->
	<script type="text/javascript" charset="UTF-8" src="<spring:url value='/uxl/ext/dynatree/jquery.dynatree.js'/>"></script>
		
	<!-- jquery shortcuts -->
	<script type="text/javascript" charset="UTF-8" src="<spring:url value='/uxl/ext/sortcusts/jquery.shortcuts.min.js'/>"></script>

	<!-- jcryption -->
	<script type="text/javascript" charset="UTF-8" src="<spring:url value='/uxl/ext/jcryption/jquery.jcryption-1.1.js'/>"></script>
	
	<!-- UXL js -->
	<script type="text/javascript" charset="UTF-8" src="<spring:url value='/uxl/uxl-core-1.2.5.js'/>"></script>
	<script type="text/javascript" charset="UTF-8" src="<spring:url value='/uxl/uxl-form-1.2.6.js'/>"></script>
	<script type="text/javascript" charset="UTF-8" src="<spring:url value='/uxl/uxl-message-1.2.0.js'/>"></script>
	<script type="text/javascript" charset="UTF-8" src="<spring:url value='/uxl/uxl-ui-1.4.1.js'/>"></script>
	<script type="text/javascript" charset="UTF-8" src="<spring:url value='/uxl/uxl-util-1.3.1.js'/>"></script>
	
	<script type="text/javascript" charset="UTF-8" src="<spring:url value='/uxl/grid/uxl-jqgrid-3.2.0.js'/>"></script>
	<script type="text/javascript" charset="UTF-8" src="<spring:url value='/uxl/grid/uxl-jqgrid-pivot-1.0.0.js'/>"></script>
	
	<script type="text/javascript" charset="UTF-8" src="<spring:url value='/uxl/tree/uxl-dynatree-1.1.0.js'/>"></script>
	<script type="text/javascript" charset="UTF-8" src="<spring:url value='/uxl/chart/uxl-chart-1.0.0.js'/>"></script>
	<script type="text/javascript" charset="UTF-8" src="<spring:url value='/uxl/editor/uxl-fckeditor-1.1.0.js'/>"></script>
	
	<script type="text/javascript" charset="UTF-8" src="<spring:url value='/uxl/ext/uxl-ext-1.3.0.js'/>"></script>
	
	<!-- UXL Extern js -->
	<script type="text/javascript" charset="UTF-8" src="<spring:url value='/uxl/ext/date-ko-KR.js'/>"></script>
	
	<script type="text/javascript" charset="UTF-8" src="<spring:url value='/uxl/ext/swfupload/swfupload-non-flash.js'/>"></script>
	<script type="text/javascript" charset="UTF-8" src="<spring:url value='/uxl/ext/swfupload/swfupload.queue.js'/>"></script>
	<script type="text/javascript" charset="UTF-8" src="<spring:url value='/uxl/ext/swfupload/handlers-1.2.0.js'/>"></script>
	
	<script type="text/javascript" charset="UTF-8" src="<spring:url value='/page/js/common.js'/>"></script>
	<script type="text/javascript" charset="UTF-8" src="<spring:url value='/page/js/hsqlData.js'/>"></script>

	<!-- Templates -->
	<script type="text/javascript" charset="UTF-8" src="<c:url value='/uxl/ext/jquery/plugin/jquery.tmpl.min.js'/>"></script>
