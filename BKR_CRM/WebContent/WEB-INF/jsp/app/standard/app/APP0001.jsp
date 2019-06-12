<%--
#*
 *  파 일 명 :  APP0001.jsp
 *  설    명 :  나의상신목록
 *  작 성 자 :  유기태
 *  작 성 일 :  2013.11.29
 *  버    전 :  1.0
 *  기타사항 :
 *  Copyrights 2011 by ㈜ 유비원. All right reserved.
*#
--%>
<%@page import="com.ubone.framework.util.ViewUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/include/pageCommon.jsp" %>
<%@ page import="com.ubone.framework.data.DataList"%>
<%@ page import="com.ubone.framework.data.Parameter"%>
<%@ page import="com.ubone.framework.ConstantHolder"%>
<%@ page import="com.ubone.framework.ConfigHolder"%>
<%@ page import="java.util.Map"%>
<%@ page import="org.apache.commons.lang.StringUtils"%>
<%@ page import="com.ubone.ubmeta.page.util.JspUtils"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core"   prefix="c" %>
<%
	DataList _dataList = null;		/* List Table default dataTable */ 
	DataList _dl_TP_STATUS_APPR = ViewUtil.getResult().getDataList("Code.TP_STATUS_APPR");
%>


<!--  ========================================================================
  This page is generated with the UB-META™ ver4.0 
 
   - PAGE ID : APP0001R00
   - PAGE TYPE : JSP
 
  Copyright ⓒ UBONE Co., Ltd. All rights reserved.
 ========================================================================
--> 


<!-- layout-1 Start -->
<h1 class="ub-control title">나의 상신 목록</h1>
<div class="ub-layout search">
    <span class="search-ltbg"></span>
    <span class="search-rtbg"></span>
    <span class="search-lbbg"></span>
    <span class="search-rbbg"></span>
<form id="SEARCH_FORM" name="SEARCH_FORM"><table class="ub-control table normal ">
<colgroup>
<col width="100px"/>
<col />
</colgroup>
<tbody>
<tr id="layout-1_1">
<th id="layout-1_1_1"><label class="ub-control label">상신일자</label></th>
<td id="layout-1_1_2"><input type=text class="ub-control input-text calendar " id="DT_SUBMIT_START" name="DT_SUBMIT_START"        value="${paramMap.DT_SUBMIT_S}"                style="text-align:left;width:100px;"><label class="ub-control label">~</label><input type=text class="ub-control input-text calendar " id="DT_SUBMIT_END" name="DT_SUBMIT_END"        value="${paramMap.DT_SUBMIT_E}"                style="text-align:left;width:100px;"></td>
</tr>
<tr id="layout-1_2">
<th id="layout-1_2_3"><label class="ub-control label">결재상태</label></th>
<td id="layout-1_2_4"><select id="TP_STATUS_APPR" name="TP_STATUS_APPR" class="ub-control select "     style="width:112px;" size="1" datacid="TP_STATUS_APPR"><%    if(!"선택".equals("")){        out.println("<OPTION VALUE=\"\">선택</OPTION>\r\n");    }    if(_dl_TP_STATUS_APPR != null){        for(int codeIdx=0; codeIdx < _dl_TP_STATUS_APPR.getRowCount(); codeIdx++){            String code = _dl_TP_STATUS_APPR.getString(codeIdx, ConstantHolder.CODE_COLUMN_CODE);            String name = _dl_TP_STATUS_APPR.getString(codeIdx, ConstantHolder.CODE_COLUMN_NAME);            out.println("<option VALUE=\""+code+"\">"+name+"</option>\r\n");        }    }%></select></td>
</tr>
</tbody>
</table>
 
<span class="ub-control button search" id="SEARCH">
<a href="#none" title="Search">검색</a>
</span>
</form>

</div>
<div class="ub-layout list"><div class="ub-control temp" style="border:2px solid gray;width:100%;height:300px;text-align:center;"><h3 style="padding-top:120px;">Grid Control</h3></div>
<table class="ub-control grid" id="LIST" name="LIST"></table> 
	
</div>
<div class="ub-layout pagging"><div class="ub-control temp" style="border:2px solid gray;width:100%;height:30px;text-align:center;"><h3 style="padding-top:3px;">Paging Navigation</h3></div>
<div id="PAGELIST" name="PAGELIST" class="ub-control pagging" for="LIST" formId="SEARCH_FORM" function="fnSearch"></div>
</div>
<div class="ub-layout " id="BTN" name="BTN"></div>

<!-- layout-1 End -->


<script type="text/javascript">

uxl.onLoad(function(){
	
	var options = {
			//header name
			colNames:['번호','결재ID','업무키','유형','제목','작성자','상신일시','결재일시','결재상태']

			//mapping column
			,colModel:[
			          {name:'LISTNUM',width:5,align:'center',sorttype:'integer'}
			         ,{name:'ID_APPR', width:0,align:'center',sorttype:'integer',hidden:true}
			         ,{name:'ID_BIZ_KEY', width:0,hidden:true}
					 ,{name:'TP_BIZ_NAME' ,width:10,align:'center'}
					 ,{name:'DS_TITLE_APPR' ,width:50}
					 ,{name:'NM_EMP_SUBMIT',width:8,align:'center'}
					 ,{name:'DT_SUBMIT',width:15,align:'center'}
					 ,{name:'DT_APPR',width:15,align:'center'}
					 ,{name:'TP_STATUS_APPR_NAME',width:8,align:'center'}
			]
			, height:270
			,autowidth:true
			,onSelectRow: function(rowid){
				var selectedRow = $(this).getRowData(rowid);
				uxl.moveLocation(uxl.getScreenURL('APP0002') + '?ID_APPR='+selectedRow.ID_APPR + '&ID_ISSUE='+selectedRow.ID_BIZ_KEY);
			}
		};
		uxl.grid('LIST', options);

		fnSearch();	
		
		// 검색버튼 클릭시
		$("#SEARCH").click(function(event){
			uxl.grid.init('LIST');
			fnSearch();
		});
		
		$('#DT_SUBMIT_START').dblclick(function(){
			$('#DT_SUBMIT_START').val('');	
		});
		$('#DT_SUBMIT_END').dblclick(function(){
			$('#DT_SUBMIT_END').val('');	
		});
		
});

function fnSearch(){
	
	// 종료일이 시작일보다 작을 수 없음.
	if($('#DT_SUBMIT_START').val()!='' && $('#DT_SUBMIT_END').val()!=''){
		if(DateUtil.getDayInterval($('#DT_SUBMIT_START').val(),$('#DT_SUBMIT_END').val()) <0){
			uxl.showMessage(uxl.getMessage('@message.voc.search.date.target','상신일자'));
			return;
		}	
	}
	
	//필수정보 체크
	var url = uxl.getFunctionUrl(_SCREEN_ID,'INQUIRY');
	var option = {
			  data:{}		
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
	uxl.callSubmitFunction('SEARCH_FORM' , url , option );		
}

</script>