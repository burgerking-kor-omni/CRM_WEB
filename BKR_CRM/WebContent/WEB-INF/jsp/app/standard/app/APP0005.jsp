<%--
#*
 *  파 일 명 :  APP0005.jsp
 *  설    명 :  나의 결재 리스트
 *  작 성 자 :  최소정
 *  작 성 일 :  2013.11.29
 *  버    전 :  1.0
 *  기타사항 :
 *  Copyrights 2011 by ㈜ 유비원. All right reserved.
*#
--%>


<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/include/pageCommon.jsp" %>
<%@ page import="com.ubone.framework.data.DataList"%>
<%@ page import="com.ubone.framework.util.ViewUtil"%>
<%@ page import="com.ubone.framework.ConfigHolder"%>
<%@ page import="com.ubone.framework.ConstantHolder"%>
<%@ page import="com.ubone.framework.util.UserUtil"%>
<%@ include file="/WEB-INF/jsp/include/pageTagLibs.jsp"%>
<%@ page import="com.ubone.framework.data.Parameter"%>
<%@ page import="java.util.Map"%>
<%@ page import="org.apache.commons.lang.StringUtils"%>
<%@ page import="com.ubone.ubmeta.page.util.JspUtils"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core"   prefix="c" %>
<%
	DataList _dataList = null;		/* List Table default dataTable */ 
	DataList _dl_TP_APPR_PROC = ViewUtil.getResult().getDataList("Code.TP_APPR_PROC");
%>


<!--  ========================================================================
  This page is generated with the UB-META™ ver4.0 
 
   - PAGE ID : APP0005R00
   - PAGE TYPE : JSP
 
  Copyright ⓒ UBONE Co., Ltd. All rights reserved.
 ========================================================================
--> 


<!-- layout-1 Start -->
<h1 class="ub-control title">나의 결재 목록</h1>
<form id="SEARCHFORM" name="SEARCHFORM"><div class="ub-layout search">
    <span class="search-ltbg"></span>
    <span class="search-rtbg"></span>
    <span class="search-lbbg"></span>
    <span class="search-rbbg"></span>
<span class="ub-control button search" id="SEARCH">
<a href="#none" title="Search">검색</a>
</span>
<table class="ub-control table normal ">
<colgroup>
<col />
<col />
<col />
<col />
</colgroup>
<tbody>
<tr id="layout-1_1">
<th id="layout-1_1_1"><label class="ub-control label">결재일자</label></th>
<td id="layout-1_1_2"><input type=text class="ub-control input-text calendar " id="DT_ACT_START" name="DT_ACT_START"        value="${paramMap.DT_ACT_START}"                style="text-align:left;width:100px;"><label class="ub-control label">~</label><input type=text class="ub-control input-text calendar " id="DT_ACT_END" name="DT_ACT_END"        value="${paramMap.DT_ACT_END}"                style="text-align:left;width:100px;"></td>
<th id="layout-1_1_3"><label class="ub-control label">결재처리구분</label></th>
<td id="layout-1_1_4"><select id="TP_APPR_PROC" name="TP_APPR_PROC" class="ub-control select "     style="width:112px;" size="1" datacid="TP_APPR_PROC" defaultvalue="${paramMap.TP_APPR_PROC}"><%    if(!"선택".equals("")){        out.println("<OPTION VALUE=\"\">선택</OPTION>\r\n");    }    if(_dl_TP_APPR_PROC != null){        for(int codeIdx=0; codeIdx < _dl_TP_APPR_PROC.getRowCount(); codeIdx++){            String code = _dl_TP_APPR_PROC.getString(codeIdx, ConstantHolder.CODE_COLUMN_CODE);            String name = _dl_TP_APPR_PROC.getString(codeIdx, ConstantHolder.CODE_COLUMN_NAME);            String selected = code.equals(ViewUtil.getParameter().getValue("TP_APPR_PROC"))?"selected":"";            out.println("<option VALUE=\""+code+"\" "+selected+">"+name+"</option>\r\n");        }    }%></select></td>
</tr>
<tr id="layout-1_2">
<th id="layout-1_2_5"><label class="ub-control label">상신일자</label></th>
<td id="layout-1_2_6"><input type=text class="ub-control input-text calendar " id="DT_SUBMIT_START" name="DT_SUBMIT_START"        value="${paramMap.DT_SUBMIT_START}"                style="text-align:left;width:100px;"><label class="ub-control label">~</label><input type=text class="ub-control input-text calendar " id="DT_SUBMIT_END" name="DT_SUBMIT_END"        value="${paramMap.DT_SUBMIT_END}"                style="text-align:left;width:100px;"></td>
<td id="layout-1_2_7"></td>
<td id="layout-1_2_8"></td>
</tr>
<tr id="layout-1_3">
<th id="layout-1_3_9"><label class="ub-control label">제목</label></th>
<td id="layout-1_3_10"><input type=text  class="ub-control input-text " id="DS_TITLE_APPR" name="DS_TITLE_APPR"       value="${paramMap.DS_TITLE_APPR}"                style="text-align:left;width:280px;"></td>
<td id="layout-1_3_11"></td>
<td id="layout-1_3_12"></td>
</tr>
</tbody>
</table>
 

</div>
</form>
<div class="ub-layout list"><div class="ub-control temp" style="border:2px solid gray;width:100%;height:300px;text-align:center;"><h3 style="padding-top:120px;">Grid Control</h3></div>
<table class="ub-control grid" id="LIST" name="LIST"></table> 
	
</div>
<div class="ub-layout pagging"><div class="ub-control temp" style="border:2px solid gray;width:100%;height:30px;text-align:center;"><h3 style="padding-top:3px;">Paging Navigation</h3></div>
<div id="paging" name="paging" class="ub-control pagging" for="LIST" formId="SEARCHFORM" function="fnSearch"></div>
</div>

<!-- layout-1 End -->


<script type="text/javascript">
uxl.onLoad(function(){
	
	//Init
	$('#DT_ACT_START').dblclick(function(){   $(this).val(''); });  //ARRIVAL_START ~
	$('#DT_ACT_END').dblclick(function(){   $(this).val(''); });    //ARRIVAL_END
	
	$('#DT_SUBMIT_START').dblclick(function(){   $(this).val(''); });  //SUBMIT_START ~
	$('#DT_SUBMIT_END').dblclick(function(){   $(this).val(''); });    //SUBMIT_END

	
	var options = {
		//header name
		colNames:['번호','SEQ_APPR (히든)','결재ID(히든)','업무ID(히든)','상세번호 (ID_APPR_DTL)','제목','결재처리구분','FG_USE','상신자','결재일시','상신일시']

		//mapping column
		,colModel:[
				  {name:'ROW_NUM', width:20, align:'center', sorttype:'int'}         
				 ,{name:'SEQ_APPR', width:20, align:'center', hidden:true}    //SEQ_APPR
				 ,{name:'ID_APPR', width:52, align:'center', hidden:true}     //결재번호
				 ,{name:'ID_BIZ_KEY', width:52, align:'center', hidden:true}     //업무ID
				 ,{name:'ID_APPR_DTL', width:20, align:'center', hidden:true} //결재상세번호
				 ,{name:'DS_TITLE_APPR', width:152, align:'left'}             //제목
				 ,{name:'TP_APPR_PROC', width:40, align:'center'}             //결재처리구분
				 ,{name:'FG_USE', width:40, align:'center', hidden:true}      //결재진행여부
				 ,{name:'NM_EMP_SUBMIT', width:40, align:'center'}        		  //상신자
				 ,{name:'DT_ACT', width:52, align:'center'}    		 	  //도착일자
				 ,{name:'DT_SUBMIT', width:52, align:'center'}     			  //상신일자
		]
		
		, autowidth:true
		, height:270
		, onSelectRow: function(rowid){
			var selectedRow = $(this).getRowData(rowid);
			uxl.moveLocation(uxl.getScreenURL('APP0006') + '?ID_APPR='+selectedRow.ID_APPR+'&ID_APPR_DTL='+selectedRow.ID_APPR_DTL+'&ID_ISSUE='+selectedRow.ID_BIZ_KEY);
			
		}
	};
	uxl.grid('LIST', options);
	
	
	$("#SEARCH").click(function(event){		
		uxl.grid.init('LIST');
		fnSearch();
	});
	

	//SEARCHFORM 전체에 엔터키 적용
	$('#SEARCHFORM').keydown(function(event) {
		if(event.keyCode == '13') {
			fnSearch();
			return false;
		}
	});
	fnSearch();
	
});



//조회
function fnSearch(){
	
	//등록일자 예외처리(시작일이 종료일 보다 작아야한다.)
	if($('#DT_ACT_START').val()!='' && $('#DT_ACT_END').val()!=''){
		if(DateUtil.getDayInterval($('#DT_ACT_START').val(),$('#DT_ACT_END').val()) <0){
			uxl.showMessage(uxl.getMessage('@message.voc.search.date.target','결재일'));
			return;
		}
	}	
	
	//등록일자 예외처리2(시작일이 종료일 보다 작아야한다.)
	if($('#DT_SUBMIT_START').val()!='' && $('#DT_SUBMIT_END').val()!=''){
		if(DateUtil.getDayInterval($('#DT_SUBMIT_START').val(),$('#DT_SUBMIT_END').val()) <0){
			uxl.showMessage(uxl.getMessage('@message.voc.search.date.target','상신일'));
			return;
		}
	}
	
	
	//필수정보 체크
	var url = uxl.getFunctionUrl(_SCREEN_ID,'INQUIRY');
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
			/*
			 * 조회한 데이터를 그리드에 추가함.
			 * @param {String} 그리드로 변환할 테이블ID
			 * @param {Result} 조회된 데이터 객체 result
			 * @param {boolean} 데이터 추가시 기존데이터의 clear 여부
			 */
			, success:function(result){
				uxl.grid.appendData('LIST' ,result , true );
			}
			, async:true
	};
	uxl.callSubmitFunction('SEARCHFORM' , url , option );
	
}

</script>