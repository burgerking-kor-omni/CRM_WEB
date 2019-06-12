<%--
#*
 *  파 일 명 :  ANA0015.jsp
 *  설    명 :  지역별-기간별 VOC 불만 현황
 *  작 성 자 :  강현준
 *  작 성 일 :  2019-03-15
 *  버    전 :  1.0
 *  기타사항 :  
 *  수정이력 :  
 *  Copyrights 2013 by ㈜ 유비원. All right reserved.
*# 
--%>
<%@ page import="com.ubone.framework.util.MessageUtils"%>
<%@ page import="com.ubone.framework.util.CodeUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.ubone.framework.util.ViewUtil"%>
<%@ include file="/WEB-INF/jsp/include/pageCommon.jsp"%>
<%@ page import="com.ubone.framework.data.DataList"%>
<%@ page import="com.ubone.framework.data.Parameter"%>
<%@ page import="com.ubone.framework.ConstantHolder"%>
<%@ page import="com.ubone.framework.ConfigHolder"%>
<%@ page import="java.util.Map"%>
<%@ page import="org.apache.commons.lang.StringUtils"%>
<%@ page import="com.ubone.ubmeta.page.util.JspUtils"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core"   prefix="c" %>


<!--  ========================================================================
  This page is generated with the UB-META™ ver4.0 
 
   - PAGE ID : ANA0015R00
   - PAGE TYPE : META
 
  Copyright ⓒ UBONE Co., Ltd. All rights reserved.
 ========================================================================
--> 

<style>
	#exportListViewer { border-bottom: 1px solid; }
</style>

<table class="ub-control table stats" id="vocList">
	<colgroup>
		<col width="100px">
		<col width="80px">
		<col width="">
		<col width="">
		<col width="">
		<col width="">
	</colgroup>
	<thead>
		<tr id="headtr_1">
			<th scope="col" rowspan="3"><strong>지역명</strong></th>
			<th scope="col" rowspan="3"><strong>AS</strong></th>
		</tr>
		<tr id="headtr_2">
		</tr>
		<tr id="headtr_3">
		</tr>
	</thead>
	<tbody id="tbody">
	</tbody>
</table>

<script type="text/javascript">
uxl.onLoad(function(){
	$('#excelBtn').click(function(){
		fnGetExcel();
	});
	// 입력폼 더블 클릭 시 값 초기화
	$('form').dblclick(function(e){
		e.target.value = "";
	});
	// 엔터키 입력 시 조회
	$('form').keydown(function() {
	    if (event.keyCode === 13) {
	        fnSearch();
	    }
	});
	
	var date = new Date();
	date.addDays(-1);
	var yyyy = date.getFullYear();
	var mm = date.getMonth()+1;
	var dd = date.getDate();
	
	mm = mm < 10? '0'+mm : mm;
	dd = dd < 10? '0'+dd : dd;
	
	$('#DT_END').val(yyyy+'-'+mm+'-'+dd);

	date.addMonths(-1);
	yyyy = date.getFullYear();
	mm = date.getMonth()+1;
	dd = date.getDate();
	
	mm = mm < 10? '0'+mm : mm;
	dd = dd < 10? '0'+dd : dd;
	
	$('#DT_START').val(yyyy+'-'+mm+'-'+dd);

	fnSearch();
});

//전체 XML 생성
function fnSearch(){
	
	var startDate = new Date($('#DT_START').val());
    var endDate = new Date($('#DT_END').val());
    var testDate = new Date($('#DT_END').val());
    testDate.addMonths(-1);

    if(startDate > endDate){
    	alert('검색기간이 유효하지 않습니다.');
    	return;
    }
    if(startDate < testDate){
    	alert('현황검색 최대 기간은 1개월입니다.');
    	return;
    }
    var chnn_size = $('input[name=CD_BIZ_CHNN]:checked').length;
    var div_size = $('input[name=CD_DIVISION]:checked').length;
    
    if(chnn_size < 1){
    	alert('채널을 1개 이상 선택해 주십시오.');
    	return;
    }
    if(div_size < 1){
    	alert('분류를 1개 이상 선택해 주십시오.');
    	return;
    }
    
	//필수정보 체크
	var url = uxl.getFunctionUrl(_SCREEN_ID,'INQUIRY');
	var option = {
			  data:{
				  BIZ_CHNN_SIZE : chnn_size,
				  DIV_SIZE : div_size
			  }
			, validator:function(data,targetForm){
					var returnVal = false;
					//필수항목체크
					if(uxl.checkRequiredFields(targetForm)){
						returnVal = true;
					}
					return returnVal;
			}
			, success:function(result){
				fnMakeTable(result);
			}
			, async:true
	};
	uxl.callSubmitFunction('searchForm' , url , option );	
}

// 표 그리기
function fnMakeTable(result){
	
	$('#vocList th[name="mktr"]').remove();
	$('#tbody tr').remove();
	
	var list = result.getDataList(0);
	var rows = list.rows;
	var rowCnt = list.rowCount;

	var htmlStr1 = '';
	var htmlStr2 = '';
	var htmlStr3 = '<th name="mktr"><strong>직영</strong></th><th name="mktr"><strong>가맹</strong></th>';
	
	// 체크된 분류 헤더 그리기
	$('input:checkbox[name=CD_DIVISION]:checked').each(function(e){
		htmlStr1 = '';
		htmlStr2 = '';
		// S분류
		if(this.value == '01'){
			htmlStr1 = '<th name="mktr" colSpan="2"><strong>S분류</strong></th>';
			htmlStr2 = '<th name="mktr" colSpan="2"><strong>이물질</strong></th>';
			$('#vocList #headtr_1').append(htmlStr1);
			$('#vocList #headtr_2').append(htmlStr2);
			$('#vocList #headtr_3').append(htmlStr3);
		}
		// 1분류
		if(this.value == '02'){
			htmlStr1 = '<th name="mktr" colSpan="8"><strong>1분류</strong></th>';
			htmlStr2 = '<th name="mktr" colSpan="2"><strong>Critical</strong></th>';
			htmlStr2 += '<th name="mktr" colSpan="2"><strong>제품</strong></th>';
			htmlStr2 += '<th name="mktr" colSpan="2"><strong>미스패킹</strong></th>';
			htmlStr2 += '<th name="mktr" colSpan="2"><strong>서비스/불친절</strong></th>';
			$('#vocList #headtr_1').append(htmlStr1);
			$('#vocList #headtr_2').append(htmlStr2);
			for(var i = 0; i < 4; i++){
				$('#vocList #headtr_3').append(htmlStr3);
			}
		}
		// 2분류
		if(this.value == '03'){
			htmlStr1 = '<th name="mktr" colSpan="4"><strong>2분류</strong></th>';
			htmlStr2 = '<th name="mktr" colSpan="2"><strong>SOS</strong></th>';
			htmlStr2 += '<th name="mktr" colSpan="2"><strong>청결</strong></th>';
			$('#vocList #headtr_1').append(htmlStr1);
			$('#vocList #headtr_2').append(htmlStr2);
			for(var i = 0; i < 2; i++){
				$('#vocList #headtr_3').append(htmlStr3);
			}
		}
		// 3분류
		if(this.value == '04'){
			htmlStr1 = '<th name="mktr" colSpan="2"><strong>3분류</strong></th>';
			htmlStr2 = '<th name="mktr" colSpan="2"><strong>매장이용불편</strong></th>';
			$('#vocList #headtr_1').append(htmlStr1);
			$('#vocList #headtr_2').append(htmlStr2);
			$('#vocList #headtr_3').append(htmlStr3);
		}
		// 기타
		if(this.value == '05'){
			htmlStr1 = '<th name="mktr" rowSpan="2" colSpan="2"><strong>기타</strong></th>';
			$('#vocList #headtr_1').append(htmlStr1);
			$('#vocList #headtr_3').append(htmlStr3);
		}
	});
	
	// 소계 & 합계 헤더 추가
	htmlStr1 = '<th name="mktr" rowSpan="2" colSpan="2"><strong>소계</strong></th>';
	$('#vocList #headtr_1').append(htmlStr1);
	$('#vocList #headtr_3').append(htmlStr3);
	htmlStr1 = '<th name="mktr" rowSpan="3"><strong>합계</strong></th>';
	$('#vocList #headtr_1').append(htmlStr1);
	
	// 데이터 표 그리기
	for(var i = 0; i < rowCnt; i++){
		if(rows[i].DISTRCT_CD_1 == ''){
			// 소계
			htmlStr1 = '<tr class="bg02" name="colSum"><th colSpan="2" style="text-align : center;">소계</th>';
			
		}else if(rows[i].DISTRCT_CD_2 == ''){
			// 광역별 소계
			htmlStr1 = '<tr class="bg02"><th colSpan="2" style="text-align : center;">'+rows[i].DISTRCT_NM_1+'계</th>';
			
		}else{
			// 지역별 데이터
			htmlStr1 = '<tr><td style="text-align : center;">'+rows[i].DISTRCT_NM_2+'</td><td></td>';
		}
<%
	for(int j = 1; j < 22; j++){
%>	
		if('<%=j%>' == 21 && i == rowCnt-1){
			// 합계의 소계부분
			htmlStr1 += '<td rowSpan="5" name="DATA<%=j%>">'+uxl.setComma(rows[i].DATA<%=j%>)+'</td>';
		}else{
			htmlStr1 += '<td name="DATA<%=j%>">'+uxl.setComma(rows[i].DATA<%=j%>)+'</td>';
		}
<%
	}
%>
		htmlStr1 += '</tr>';
		$('#vocList #tbody').append(htmlStr1);
	}
	
	// 선택안된 분류 td 삭제
	$('input:checkbox[name=CD_DIVISION]:not(:checked)').each(function(e){
		if($(this).val() == '01'){
			$('#tbody td[name="DATA1"]').remove();
			$('#tbody td[name="DATA2"]').remove();
		}
		if($(this).val() == '02'){
		<%	for(int i = 3; i < 11; i++){	%>
			$('#tbody td[name="DATA<%=i%>"]').remove();
		<%	}	%>
		}
		if($(this).val() == '03'){
		<%	for(int i = 11; i < 15; i++){	%>
			$('#tbody td[name="DATA<%=i%>"]').remove();
		<%	}	%>
		}
		if($(this).val() == '04'){
			$('#tbody td[name="DATA15"]').remove();
			$('#tbody td[name="DATA16"]').remove();
		}
		if($(this).val() == '05'){
			$('#tbody td[name="DATA17"]').remove();
			$('#tbody td[name="DATA18"]').remove();
		}
	});
	
	// 2019.06.03 강현준 추가
	//기타 열 추가
	var etcList = result.getDataList(1);
	var etcRow = etcList.rows;
	htmlStr1 = '<tr class="bg02" name="ETC"><th colSpan="2">기타</th>';
	$('input:checkbox[name=CD_DIVISION]:checked').each(function(e){
		if($(this).val() == '01'){
			htmlStr1 += '<td colSpan="2">'+etcRow[0].DATA1+'</td>';
		}else if($(this).val() == '02'){
			htmlStr1 += '<td colSpan="2">'+etcRow[0].DATA2+'</td>';
			htmlStr1 += '<td colSpan="2">'+etcRow[0].DATA3+'</td>';
			htmlStr1 += '<td colSpan="2">'+etcRow[0].DATA4+'</td>';
			htmlStr1 += '<td colSpan="2">'+etcRow[0].DATA5+'</td>';
		}else if($(this).val() == '03'){
			htmlStr1 += '<td colSpan="2">'+etcRow[0].DATA6+'</td>';
			htmlStr1 += '<td colSpan="2">'+etcRow[0].DATA7+'</td>';
		}else if($(this).val() == '04'){
			htmlStr1 += '<td colSpan="2">'+etcRow[0].DATA8+'</td>';
		}else{
			htmlStr1 += '<td colSpan="2">'+etcRow[0].DATA9+'</td>';
		}
	});
	htmlStr1 += '<td colSpan="2">'+etcRow[0].DATA10+'</td>';
	htmlStr1 += '</tr>';
	$('#vocList #tbody').append(htmlStr1);
	
	// 구분계 합계
	htmlStr1 = '<tr class="bg02"><th colSpan="2">구분계</th>';
	var divSum = 0;
	var nameId = 1;
	var etcId = 0;
	$('#tbody tr[name=colSum] td:not(:last)').each(function(index, value){
		if(index % 2 == 1){
			divSum += $(this).text()*1
			if(index == $('#tbody tr.bg02:not(:last) td:not(:last)').last().index()-1){
				htmlStr1 += '<td colSpan="2" rowSpan="3" name="divSumLast">'+uxl.setComma(divSum)+'</td>';
			}else{
				htmlStr1 += '<td colSpan="2" name="divSum'+nameId+'">'+uxl.setComma(divSum)+'</td>';
			}
			nameId++;
			etcId++;
	    }else{
			divSum = $(this).text().split(',').join('')*1
			divSum += $('tr[name="ETC"] td:eq('+etcId+')').text().split(',').join('')*1
	    };
	    
	});
	htmlStr1 += '</tr>';
	$('#vocList #tbody').append(htmlStr1);
	
	// 체크된 분류계 합계 구하기
	var allColSp = 0;
	var sumIdx = 1;
	htmlStr1 = '<tr class="bg02"><th colSpan="2">분류계</th>'
	$('input:checkbox[name=CD_DIVISION]:checked').each(function(e){
		if($(this).val() == '01'){
			var sumVal = $('td[name="divSum'+sumIdx+'"]').text();
			htmlStr1 += '<td colSpan="2">'+uxl.setComma(sumVal)+'</td>';
			allColSp += 2;
			sumIdx++;
		}else if($(this).val() == '02'){
			var sumVal = 0;
			for(var i = 0; i < 4; i++,sumIdx++){
				sumVal += $('td[name="divSum'+sumIdx+'"]').text().split(',').join('')*1;
			}
			htmlStr1 += '<td colSpan="8">'+uxl.setComma(sumVal)+'</td>';
			allColSp += 8;
		}else if($(this).val() == '03'){
			var sumVal = 0;
			for(var i = 0; i < 2; i++,sumIdx++){		
				sumVal += $('td[name="divSum'+sumIdx+'"]').text().split(',').join('')*1;
			}
			htmlStr1 += '<td colSpan="4">'+uxl.setComma(sumVal)+'</td>';
			allColSp += 4;
		}else if($(this).val() == '04'){
			var sumVal = Number($('td[name="divSum'+sumIdx+'"]').text().split(',').join(''));
			htmlStr1 += '<td colSpan="2">'+uxl.setComma(sumVal)+'</td>';
			allColSp += 2;
			sumIdx++;
		}else{
			var sumVal = Number($('td[name="divSum'+sumIdx+'"]').text().split(',').join(''));
			htmlStr1 += '<td colSpan="2">'+uxl.setComma(sumVal)+'</td>';
			allColSp += 2;
		}
	});
	htmlStr1 += '</tr>';
	$('#vocList #tbody').append(htmlStr1);

	// 2019.06.03 강현준 추가
	// 기타 열 합 추가
	var etcSum = $('td[name="divSumLast"]').text();
	$('#tbody td[name="DATA21"]:last').html(etcSum);
	
	
	// 총 합계
	htmlStr1 = '<tr class="bg02"><th colSpan="2">합계</th><td colSpan="'+allColSp+'">'+uxl.setComma($('#tbody td[name="DATA21"]:last').text())+'</td><tr>'
	$('#vocList #tbody').append(htmlStr1);
	
	// 밑 공백 추가
	$('#brDiv').remove();
	$('body').append('<div id="brDiv"><br/><br/><br/></div>');
	
	// 모든 셀 가운데 정렬
	$('#vocList td').attr('style','text-align:center;');
}

//엑셀파일 추출하기 
function fnGetExcel() {
	
	var startDate = new Date($('#DT_START').val());
    var endDate = new Date($('#DT_END').val());
    var testDate = new Date($('#DT_END').val());
    testDate.addMonths(-1);

    if(startDate > endDate){
    	alert('검색기간이 유효하지 않습니다.');
    	return;
    }
    if(startDate < testDate){
    	alert('다운로드  최대 기간은 1개월입니다.');
    	return;
    }
    var chnn_size = $('input[name=CD_BIZ_CHNN]:checked').length;
    var div_size = $('input[name=CD_DIVISION]:checked').length;
    
    if(chnn_size < 1){
    	alert('채널을 1개 이상 선택해 주십시오.');
    	return;
    }
    if(div_size < 1){
    	alert('분류를 1개 이상 선택해 주십시오.');
    	return;
    }
	
	var data = {};
	//필수정보 체크
	var url = uxl.getFunctionUrl(_SCREEN_ID, 'EXPORT');
	var option = {
		data : data
		,success : function(result) {
			fnSearchExcel(result);
		},
		async : true
	};
	uxl.callSubmitFunction('searchForm', url, option);
}

function fnSearchExcel(result) {
	var filelink = result.getResultKey();
	if ($('#exportListViewer').size() == 0) {
		$('<div id="exportListViewer"></div>').appendTo('body');
	}
	$('#exportListViewer')
			.dialog(
					{
						width : 460,
						title : 'Download Result',
						open : function(event, ui) {
							var tag = '';
							if (filelink == null) {
								tag = tag
										+ '<span>다운로드할 데이터가 존재하지 않습니다.</span>';
							} else {
								tag = tag
										+ '<span>아래의 다운로드 link를 클릭하시면 파일을 다운로드 받을 수 있습니다.</span>';
								tag = tag + '<br/><br/><ul>';
								for (var i = 0; i < filelink.length; i++) {
// 									var url = uxl.getContextURL('/file/view.do');
// 									url = uxl.addQueryToUrl(url,'filePath', filelink[i]);
									var url = uxl.getContextURL('/file/bkrDown.' + uxl.CONSTANT.URL_EXTENTION + '?fileId=' + filelink);
									tag = tag + '<li ><a href="' + url + '" target="_self" style="color:#B54444" onclick=fnClose()> 다운로드 파일 '+ (i + 1) + ' </a></li>';
								}
								tag = tag + '</ul>';
							}
							$(this).html(tag);
						},
						close : function(event, ui) {
							$(this).remove();
						}
					})
			.style('css','border-bottom: 1px solid;');
}

function fnClose(){
	$('#exportListViewer').remove();
}

</script>