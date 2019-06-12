<%@page import="com.ubone.framework.ConfigHolder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page errorPage="/jsp/error/errorPage.jsp" %>
<%@ page import="java.util.Map"%>
<%@ page import="java.util.List"%>
<%@ page import="com.ubone.framework.util.ViewUtil"%>
<%
	if(ConfigHolder.VIEW_MDI_MODE == false){
%>
		<div class="ub-layout location"><span class="ico-home">Home</span>
<%		
		List<Map<String, Object>> location = ViewUtil.getMenuLocation();
		StringBuffer sb = new StringBuffer();
		if(location.size() > 0){
			for(int i=0; i<location.size()-1; i++){
				sb.append(" &gt; ").append(location.get(i).get("MENU_NAME"));
			}
			sb.append(" &gt; ").append("<em>").append(location.get(location.size()-1).get("MENU_NAME")).append("</em>");
		}
		out.println(sb.toString());
%>
		</div>
<%		
	}else{
%>
		<div class="ub-layout location"><span class="ico-home">Home</span></div>
<script>
	$(document).ready(function(){
		if(uxl.isNotNull(window.name)){
			var menuId = window.name.replace('tabFrame_tab_item_', '');
			var menuObj = parent.$('a[menuId='+menuId+']');
			if(menuObj.size() > 0){
				var pathInfo = menuObj.attr('menuPath');
				
				if(uxl.isNotEmpty(pathInfo)){
					var menuPath = ""; 
					var location = pathInfo.split('>');
					for(var i=0; i<location.length-1; i++){
						menuPath += " &gt; " + location[i];
					}
					menuPath += " &gt; <em>"+location[location.length-1]+"</em>";
					
					$('.ub-layout.location').append(menuPath);
				}
			}
		}
	});
</script>		
<%		
	}
%>		
