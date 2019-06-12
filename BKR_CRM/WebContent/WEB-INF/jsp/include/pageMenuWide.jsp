<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page errorPage="/jsp/error/errorPage.jsp" %>
<%@ page import="com.ubone.framework.engine.domain.User"%>
<%@ page import="com.ubone.framework.util.UserUtil"%>
<%@ page import="com.ubone.framework.util.ViewUtil"%>
<%@ page import="com.ubone.framework.web.util.HttpUtils"%>
<%@ page import="com.ubone.framework.data.DataList"%>
<%@ page import="com.ubone.framework.ConstantHolder"%>
<%@ page import="com.ubone.framework.ConfigHolder"%>
<%@page import="com.ubone.framework.util.MessageUtils"%>
<%@include file="/WEB-INF/jsp/include/pageTagLibs.jsp" %>
<%
	DataList menu1 = ViewUtil.getMenu(1);
	DataList menu2 = ViewUtil.getMenu(2);
	DataList menu3 = ViewUtil.getMenu(3);
	
	User user = UserUtil.getLoginUser();
	
	boolean isMultiLang = ConfigHolder.LOCALE_USE_MULTI_LANGUAGE; 
%>
<div id="menu" class="ub-layout menu wide-menu" style="z-index:9999">
	<nav>
		<ul class="ub-control menu depth01">
<%
	if(menu1 != null){
		for(int i=0; i<menu1.getRowCount(); i++){
			String menuId     = menu1.getString(i, "MENU_ID");
			String menuName   = menu1.getString(i, "MENU_NAME");
			String menuNameResId = "";
			if(isMultiLang){
				menuNameResId = menu1.getString(i, "MENU_NAME_RES_ID");
			}
			request.setAttribute("menuName", menuName);
			request.setAttribute("menuNameResId", menuNameResId);

			String menuUrl    = menu1.getString(i, "CONNECT_URL");
			String menuType   = menu1.getString(i, "MENU_TYPE");
			String menuHeight = menu1.getString(i, "HEIGHT");
			String menuWidth  = menu1.getString(i, "WIDTH");
			String menuTarget = menu1.getString(i, "TARGET");
			
			String menuPath = menuName;

			//메뉴 개수가 1개일때 last 클래스 미적용
			if((menu1.getRowCount()-1)!=i || menu1.getRowCount() == 1){
%>
			<li>
<%
			}else{
%>
			<li class="last-menu">
<%
			}
%>		
				<a  menuId='<%=menuId %>'
					menuUrl='<%=menuUrl %>' 
					menuName='<%=MessageUtils.getMessage(menuNameResId, menuName) %>' 
					menuType='<%=menuType %>'
					menuHeight='<%=menuHeight %>'
					menuWidth='<%=menuWidth %>'
					menuTarget='<%=menuTarget %>'
					menuPath='<%=menuPath %>'
					class="t" title="<%=MessageUtils.getMessage(menuNameResId, menuName) %>"><strong><ub:message code="${menuNameResId}" text="${menuName}" /></strong></a>
<%
			if(menu2 != null){
				DataList submenu2 = menu2.filter("PARENT_MENU_ID", menuId);
				if(submenu2.getRowCount() > 0){
%>
				<div class="sub-depth-box">
					<div class="sub-depth">
						<div class="column depth02">
							<ul>
<%				
					for(int j=0; j<submenu2.getRowCount(); j++){
						String menuId2     = submenu2.getString(j, "MENU_ID");
						String menuName2   = submenu2.getString(j, "MENU_NAME");
						String menuNameResId2 = "";
						if(isMultiLang){
							menuNameResId2 = submenu2.getString(j, "MENU_NAME_RES_ID");
						}
						request.setAttribute("menuName2", menuName2);
						request.setAttribute("menuNameResId2", menuNameResId2);

						String menuUrl2    = submenu2.getString(j, "CONNECT_URL");
						String menuType2   = submenu2.getString(j, "MENU_TYPE");
						String menuHeight2 = submenu2.getString(j, "HEIGHT");
						String menuWidth2  = submenu2.getString(j, "WIDTH");
						String menuTarget2 = submenu2.getString(j, "TARGET");
						
						String menuPath2 = menuPath + ">" + menuName2;

						if("S".equals(menuType2)){
%>
							</ul>
						</div>
						<div class="column depth02">
							<ul>
<%							
						}else{
%>
								<li>
									<a href="#none"
									   menuId='<%=menuId2 %>' 
									   menuUrl='<%=menuUrl2 %>' 
									   menuName='<%=MessageUtils.getMessage(menuNameResId2, menuName2) %>' 
									   menuType='<%=menuType2 %>' 
									   menuHeight='<%=menuHeight2 %>' 
									   menuWidth='<%=menuWidth2 %>'
									   menuTarget='<%=menuTarget2 %>'
									   menuPath='<%=menuPath2 %>'
									   title="<%=MessageUtils.getMessage(menuNameResId2, menuName2) %>"><strong><ub:message code="${menuNameResId2}" text="${menuName2}" /></strong></a>
<%
							if(menu3 != null){
								DataList submenu3 = menu3.filter("PARENT_MENU_ID", menuId2);
								if(submenu3.getRowCount() > 0){
%>
									<div class="depth03">
										<ul>
<%				
									for(int k=0; k<submenu3.getRowCount(); k++){
										String menuId3     = submenu3.getString(k, "MENU_ID");
										String menuName3   = submenu3.getString(k, "MENU_NAME");
										String menuNameResId3 = "";
										if(isMultiLang){
											menuNameResId3 = submenu3.getString(k, "MENU_NAME_RES_ID");
										}
										request.setAttribute("menuName3", menuName3);
										request.setAttribute("menuNameResId3", menuNameResId3);

										String menuUrl3    = submenu3.getString(k, "CONNECT_URL");
										String menuType3   = submenu3.getString(k, "MENU_TYPE");
										String menuHeight3 = submenu3.getString(k, "HEIGHT");
										String menuWidth3  = submenu3.getString(k, "WIDTH");
										String menuTarget3 = submenu3.getString(k, "TARGET");
	
										String menuPath3 = menuPath2 + ">" + menuName3;
%>	
											<li>
												<a href="#none"
									   			   menuId='<%=menuId3 %>' 
												   menuUrl='<%=menuUrl3 %>' 
												   menuName='<%=MessageUtils.getMessage(menuNameResId3, menuName3) %>' 
												   menuType='<%=menuType3 %>' 
												   menuHeight='<%=menuHeight3 %>' 
												   menuWidth='<%=menuWidth3 %>' 
												   menuTarget='<%=menuTarget3 %>' 
												   menuPath='<%=menuPath3 %>'
												   title="<%=MessageUtils.getMessage(menuNameResId3, menuName3) %>"><strong><ub:message code="${menuNameResId3}" text="${menuName3}" /></strong></a>
											</li>
<%
									}
%>
										</ul>
									</div>
<%
								}
							}
%>
								</li>
<%
						} /* end if */
					} /* end for */
%>
							</ul>
						</div>
					</div>
				</div>
<%
				} /* end if */
			} /* end if */
%>
			</li>
<%
		}
	}
%>
		</ul>
	</nav>	
</div>