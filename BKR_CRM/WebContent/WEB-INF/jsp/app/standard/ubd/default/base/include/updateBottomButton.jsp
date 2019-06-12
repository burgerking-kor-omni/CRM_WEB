<%--
#*
 *  파 일 명 :  updateBottomButton.jsp
 *  설    명 :  게시물수정화면 하단 버튼영역
 *  작 성 자 :  
 *  작 성 일 :  
 *  버    전 :  1.0
 *  기타사항 :
 *  Copyrights 2013 by ㈜ 유비원. All right reserved.
*# 
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.ubone.framework.util.ViewUtil"%>
<%@page import="com.ubone.framework.data.DataList"%>

<div class="ub-layout button bottom">
	<span class="ub-control button bottom icon" title="수정" id="btnUpdateArticle">
    	<a href="#none" title="수정"><span class="ico-save"></span>수정</a>
	</span>
	<span class="ub-control button bottom icon" title="Cancel" id="btnUpdateCancel">
    	<a href="#none" title="Cancel">취소</a>
	</span>
</div>

<script type="text/javascript">
eventBus.addListener({
	  id : 'updateBottomButton'
	, onLoad : function(){
		$('#btnUpdateArticle').click(function(){
			eventBus.triggerEvent("onUpdate");
		});
		
		$('#btnUpdateCancel').click(function(){
			fnReturnArticle();
		});
		
		
	}
	, onUpdate : function(){
		fnUpdateArticle();
	}
});

function fnUpdateArticle(){
	var url = uxl.getFunctionUrl(_SCREEN_ID,'UPDATE');
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
			  	fnReturnArticle();
			}
		  , async:true
		  , message : {
				confirm : uxl.getMessage('@message.common.update.confirm'),
				fail : uxl.getMessage('@message.common.update.fail')
			}
	};
	uxl.callSubmitFunction('defaultForm', url, option);
}

function fnReturnArticle(){
	var param = "?ID_BOARD=${paramMap.ID_BOARD}&ID_ARTICLE=${paramMap.ID_ARTICLE}&ID_SUB=${paramMap.ID_SUB}";
// 	uxl.moveLocation(uxl.getScreenURL('UBD1003') + param);
	boardCommon.moveArticle(param);
}
</script>