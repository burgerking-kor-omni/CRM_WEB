<%--
#*
 *  파 일 명 :  EXP8010.jsp
 *  설    명 :  엑셀변환
 *  작 성 자 :  김태완
 *  작 성 일 :  2017-11-16
 *  버    전 :  1.0
 *  기타사항 :
 *  Copyrights 2011 by ㈜ 유비원. All right reserved.
*# 
--%>
<%@page import="com.ubone.framework.engine.domain.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/include/pageCommon.jsp" %>
<%@ page import="com.ubone.framework.ConstantHolder"%>
<%@ page import="com.ubone.framework.util.UserUtil"%>
<%@ include file="/WEB-INF/jsp/include/pageTagLibs.jsp"%>

<div id="gridPager" ></div>

<script type="text/javascript">
uxl.onLoad(function(){

	$('#excel').click(function(){
		fnGetExcel();
	});
	//스타일변경
	$('#excel1').click(function(){
		fnGetExcel1();
	});
	//대용량-몽땅
	$('#excel2').click(function(){
		fnGetExcel2();
	});
	//대용량-petch
	$('#excel3').click(function(){
		fnGetExcel3();
	});
});

//엑셀 다운로드
function fnGetExcel(){
	var url = uxl.getFunctionUrl(_SCREEN_ID,'EXPORT');
	var option = {
			  data:{}
			, validator:function(data,targetForm){
					var returnVal = false;
					//필수항목체크
					if(uxl.checkRequiredFields(targetForm)){
						returnVal = true;
					}
					
					return returnVal;
			}
			, success:function(result){
				uxl.excelDaolog(result);
			}
			, async:true
	};
	uxl.callFunction(url , option );
}

//엑셀 다운로드 스타일변경
function fnGetExcel1(){
	var url = uxl.getFunctionUrl(_SCREEN_ID,'USERDEFINED1');
	var option = {
			  data:{}
			, validator:function(data,targetForm){
					var returnVal = false;
					//필수항목체크
					if(uxl.checkRequiredFields(targetForm)){
						returnVal = true;
					}
					
					return returnVal;
			}
			, success:function(result){
				uxl.excelDaolog(result);
			}
			, async:true
	};
	uxl.callFunction(url , option );
}

//엑셀 다운로드 대용량 - 몽땅
function fnGetExcel2(){
	var url = uxl.getFunctionUrl(_SCREEN_ID,'USERDEFINED2');
	var option = {
			  data:{}
			, validator:function(data,targetForm){
					var returnVal = false;
					//필수항목체크
					if(uxl.checkRequiredFields(targetForm)){
						returnVal = true;
					}
					
					return returnVal;
			}
			, success:function(result){
				uxl.excelDaolog(result);
			}
			, async:true
	};
	uxl.callFunction(url , option );
}

//엑셀 다운로드 대용량 - petch
function fnGetExcel3(){
	var url = uxl.getFunctionUrl(_SCREEN_ID,'USERDEFINED3');
	var option = {
			  data:{}
			, validator:function(data,targetForm){
					var returnVal = false;
					//필수항목체크
					if(uxl.checkRequiredFields(targetForm)){
						returnVal = true;
					}
					
					return returnVal;
			}
			, success:function(result){
				uxl.excelDaolog(result);
			}
			, async:true
	};
	uxl.callFunction(url , option );
}
</script>