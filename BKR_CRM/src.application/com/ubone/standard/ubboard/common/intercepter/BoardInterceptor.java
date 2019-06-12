package com.ubone.standard.ubboard.common.intercepter;

import java.io.File;

import javax.annotation.Resource;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import com.ubone.framework.ConfigHolder;
import com.ubone.framework.ConstantHolder;
import com.ubone.framework.data.Parameter;
import com.ubone.framework.data.Result;
import com.ubone.framework.engine.domain.Screen;
import com.ubone.framework.type.ResultStatus;
import com.ubone.framework.util.UserUtil;
import com.ubone.standard.login.domain.VocUser;
import com.ubone.standard.ubboard.board.base.dao.BoardInfomationDAO;
import com.ubone.standard.ubboard.common.domain.Board;
import com.ubone.standard.ubboard.common.exception.BoardServiceException;

/** 
 * <pre>
 *  파 일 명 : BoardInterceptor.java
 *  설    명 : Board 접근 URL 패턴에 대한 인터셉터 처리
 *           - Board Id에 따른 멀티 View 제공 처리
 *  작 성 자 : 강영운
 *  작 성 일 : 2015.02.04
 *  버    전 : 1.0
 *  수정이력 :
 *  기타사항 :
 *     - ScreenInterceptor 보다 선행 처리되어야 한다.
 * </pre>
 * @author Copyrights 2009 by ㈜ 유비원. All right reserved.
 */
public class BoardInterceptor implements HandlerInterceptor
{
	@Resource
	private ServletContext servletContext;
	
	@Resource 
	private BoardInfomationDAO boardInfomationDAO;
	
	@Override
	public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object obj, Exception exception) throws Exception {
	}

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object obj) throws Exception {		
		return true;
	}
	
	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object obj, ModelAndView mv) throws Exception {
		String uri = request.getRequestURI().replaceAll(request.getContextPath(), "");
		
		if(uri.startsWith("/screen/") && uri.indexOf("/UBD") > -1){
			
			Result result = (Result) mv.getModelMap().get(ConstantHolder.KEY_SERVICE_RESULT);
			if(result != null){
				if(ResultStatus.Success != result.getServiceMessage().getResultStatus()){
					throw new BoardServiceException(result.getServiceMessage().getMessage());
				}
			}
			
			Parameter parameter = (Parameter) mv.getModelMap().get(ConstantHolder.KEY_PARAMETER);
			Screen screen = (Screen) mv.getModelMap().get(ConstantHolder.KEY_SCREEN);
			
			String boardId = parameter.get("ID_BOARD");
			if(boardId != null && !"".equals(boardId)){
				Board board = new Board();
				board.setBoard(boardInfomationDAO.getBoardInfo(boardId));
				String boardTypeId = board.getBoardTypeId();
				parameter.setParameter("boardType", boardTypeId);
				
				// 게시판 파티션 구분값에 대한 subId 설정
				String subId = parameter.get("ID_SUB");
				String partitionType = board.getPartitionType();
				String returnSubId = null;
				if(subId == null || "".equals(subId)){
					VocUser userInfo = (VocUser) UserUtil.getLoginUser();
					if(partitionType == null || "".equals(partitionType)){
						returnSubId = "-";
					}else if("DP".equals(partitionType)){
						returnSubId = userInfo.getPartCode();
					}
					parameter.setParameter("ID_SUB", returnSubId);
				}
				
				// 게시판유형ID가 존재하면
				if(boardTypeId != null && !"".equals(boardTypeId)){
					String viewName = screen.getFilePath() + boardTypeId + "/";
					if(boardId != null && !"".equals(boardId)){
						viewName += boardId + "/" + screen.getFileName();
						
						File file = new File(servletContext.getRealPath(ConfigHolder.VIEW_JSP_ROOT + ConfigHolder.VIEW_APP_PATH + viewName + ".jsp"));
						if(!file.exists()){
							viewName = screen.getFilePath() + boardTypeId + "/base/" + screen.getFileName();
						}
					}
					
					mv.setViewName(viewName);
				}
			}
		}
	}
}
