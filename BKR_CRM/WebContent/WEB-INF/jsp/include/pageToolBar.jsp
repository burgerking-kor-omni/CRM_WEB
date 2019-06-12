<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/jsp/include/pageTagLibs.jsp" %>

<div id="toolbar" class="ub-layout toolbar left" style="position: absolute;left: 0;height: 80%;width: 200px;border: 3px dotted magenta;z-index: 999;background: white;">
	<div style="float:right;"><a href="#" id="close">Close</a></div>
	<br>
	<div style="float:right;"><a href="#" class="expand">Expand All</a></div>
<!-- 	<div style="float:right;"><a href="javascript:void(0)" class="expand">Expand All</a> | <a href="javascript:void(0)" class="collapse">Collapse All</a></div> -->
	<br>
	<form id="formCall" name="formCall" method="post">
		<input type="hidden" id="TEMP_SCREEN_ID" name="TEMP_SCREEN_ID" value="" />
		<input type="hidden" id="CODE_CATEGORY_ID" name="CODE_CATEGORY_ID" value="" />
		<input type="hidden" id="LAZY_KEY" name="LAZY_KEY" value="" />
	</form>
</div>

