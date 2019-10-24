<%--
#*
 *  파 일 명 :  ANA0007.jsp
 *  설    명 :  유형-기간별 VOC현황 목록
 *  작 성 자 :  강현준
 *  작 성 일 :  2018-12-20
 *  버    전 :  1.0
 *  기타사항 :  
 *  수정이력 :  
 *  Copyrights 2013 by ㈜ 유비원. All right reserved.
*# 
--%>
<%@page import="com.ubone.framework.util.MessageUtils"%>
<%@page import="com.ubone.framework.util.CodeUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.ubone.framework.util.ViewUtil"%>
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

<%
	DataList _dl_CASUE1 = ViewUtil.getResult().getDataList("Code.CD_VOC_CAUSE_1");
	int cntCause1 = _dl_CASUE1.getRowCount();
	DataList _dl_CASUE2 = ViewUtil.getResult().getDataList("Code.CD_VOC_CAUSE_2");
	int allcnt = _dl_CASUE2.getRowCount();
	
	int cnt01 = 0;
	int cnt02 = 0;
	int cnt03 = 0;
	int cnt04 = 0;
	int cnt05 = 0;
	
	for(int i = 0; i < allcnt; i++){
		if("01".equals(_dl_CASUE2.getString(i, "CODE").substring(0, 2))){
			cnt01++;
		}else if("02".equals(_dl_CASUE2.getString(i, "CODE").substring(0, 2))){
			cnt02++;
		}else if("03".equals(_dl_CASUE2.getString(i, "CODE").substring(0, 2))){
			cnt03++;
		}else if("04".equals(_dl_CASUE2.getString(i, "CODE").substring(0, 2))){
			cnt04++;
		}else{
			cnt05++;
		}
	}
%>

<!--  ========================================================================
  This page is generated with the UB-META™ ver4.0 
 
   - PAGE ID : ANA0007R00
   - PAGE TYPE : META
 
  Copyright ⓒ UBONE Co., Ltd. All rights reserved.
 ========================================================================
--> 
<table class="ub-control table stats">
	<colgroup>
		<col width="50px">
		<col width="130px">
		<col width="">
		<col width="">
		<col width="">
		<col width="">
	</colgroup>
	<thead>
		<tr>
			<th rowspan="2" scope="col"><strong>구분</strong></th>
			<th rowspan="2" scope="col"><strong>유형</strong></th>
			<th rowspan="2" scope="col"><strong>전체</strong></th>
			<th colspan="3" scope="col"><strong>멤버십</strong></th>
			<th colspan="2" scope="col"><strong>성별</strong></th>
			<th colspan="6" scope="col"><strong>연령대</strong></th>
		</tr>
		<tr>
			<th scope="col"><strong>주니어</strong></th>
			<th scope="col"><strong>와퍼</strong></th>
			<th scope="col"><strong>킹</strong></th>
			<th scope="col"><strong>남자</strong></th>
			<th scope="col"><strong>여자</strong></th>
			<th scope="col"><strong>10대</strong></th>
			<th scope="col"><strong>20대</strong></th>
			<th scope="col"><strong>30대</strong></th>
			<th scope="col"><strong>40대</strong></th>
			<th scope="col"><strong>50대</strong></th>
			<th scope="col"><strong>60대 이상</strong></th>
		</tr>
	</thead>
	<tbody id="tbody">
	<tr class="bg02" id="ALLSUM">
		<th colspan="2">전체</th>
		<th id="ALLSUM0"></th>
	</tr>
	<tr>
		<th rowspan="<%=cnt01+2%>" scope="rowgroup">문의</th>
	</tr>
	<%
		for(int i = 0; i < cnt01; i++){
	%>
	<tr id="<%=_dl_CASUE2.getString(i, "CODE")%>">
		<th><%=_dl_CASUE2.getString(i, "CODE_NAME")%></th>
		
	</tr>
	<%		
		}
	%>
	<tr id="TR01" class="bg02">
		<th>소계</th>
		<th></th>
	</tr>
	<tr>
		<th rowspan="<%=cnt02+2 %>" scope="rowgroup">불만</th>
	</tr>
	<%
		for(int i = cnt01; i < cnt01+cnt02; i++){
	%>
	<tr id="<%=_dl_CASUE2.getString(i, "CODE")%>">
		<th><%=_dl_CASUE2.getString(i, "CODE_NAME")%></th>
		
	</tr>
	<%		
		}
	%>
	<tr id="TR02" class="bg02">
		<th>소계</th>
		<th></th>
	</tr>
	<tr>
		<th rowspan="<%=cnt03+2 %>" scope="rowgroup">제안</th>
	</tr>
	<%
		for(int i = cnt01+cnt02; i < cnt01+cnt02+cnt03; i++){
	%>
	<tr id="<%=_dl_CASUE2.getString(i, "CODE")%>">
		<th><%=_dl_CASUE2.getString(i, "CODE_NAME")%></th>
			
	</tr>
	<%		
		}
	%>
	<tr id="TR03" class="bg02">
		<th>소계</th>
		<th></th>
	</tr>
	<tr>
		<th rowspan="<%=cnt04+2 %>" scope="rowgroup">칭찬</th>
	</tr>
	<%
		for(int i = cnt01+cnt02+cnt03; i < cnt01+cnt02+cnt03+cnt04; i++){
	%>
	<tr id="<%=_dl_CASUE2.getString(i, "CODE")%>">
		<th><%=_dl_CASUE2.getString(i, "CODE_NAME")%></th>
			
	</tr>
	<%		
		}
	%>
	<tr id="TR04" class="bg02">
		<th>소계</th>
		<th></th>
	</tr>
	
	<tr>
		<th rowspan="<%=cnt05+2 %>" scope="rowgroup">요청</th>
	</tr>
	<%
		for(int i = cnt01+cnt02+cnt03+cnt04; i < cnt01+cnt02+cnt03+cnt04+cnt05; i++){
	%>
	<tr id="<%=_dl_CASUE2.getString(i, "CODE")%>">
		<th><%=_dl_CASUE2.getString(i, "CODE_NAME")%></th>
			
	</tr>
	<%		
		}
	%>
	<tr id="TR05" class="bg02">
		<th>소계</th>
		<th></th>
	</tr>
	</tbody>
</table>

<br /><br /><br /><br />
<script type="text/javascript">
uxl.onLoad(function(){
	
	// code bind
	uxl.bindComboCode('DT_START_Y', 'CD_YEAR', {emptyOption:false});
	uxl.bindComboCode('DT_START_M', 'CD_MONTH', {emptyOption:false});
	uxl.bindComboCode('DT_END_Y', 'CD_YEAR', {emptyOption:false});
	uxl.bindComboCode('DT_END_M', 'CD_MONTH', {emptyOption:false});
	$('#CD_STORE option[value="99"]').remove();
	$('#FG_MEMBER').append('<option value="">전체</option><option value="Y">회원</option><option value="N">비회원</option>');
	$('#YN_FLAG').append('<option value="">전체</option><option value="1">Y</option><option value="0">N</option>');

	//Enter Key 이벤트
	$('form').keydown(function(event) {
		if(event.keyCode == '13') {
			fnSearch();
		}
	});
	
	var dt = new Date();
    var recentYear = dt.getFullYear();
    var recentMonth = dt.getMonth() + 1;
	
	$('#DT_START_Y').val(recentYear);
	$('#DT_START_M').val('01');
	
	$('#DT_END_Y').val(recentYear);
	$('#DT_END_M').val(recentMonth < 10 ? '0'+recentMonth : recentMonth);
	
	// 2019.06.07  엑셀 다운로드 
	$('#excelBtn').click(function(){
		fnGetExcel();
	});
	
});

uxl.onLoadComplete(function(){
	fnSearch();
});

//전체 XML 생성
function fnSearch(){
	
	var chnn_size = $('input[name=CD_BIZ_CHNN]:checked').length;
    
    if(chnn_size < 1){
    	alert('채널을 1개 이상 선택해 주십시오.');
    	return;
    }
	
    var startDate = new Date($('#DT_START_Y').val()+"-"+$('#DT_START_M').val()+'-01');
    var endDate = new Date($('#DT_END_Y').val()+"-"+$('#DT_END_M').val()+'-01');
    var testDate = new Date($('#DT_END_Y').val()+"-"+$('#DT_END_M').val()+'-01');
    testDate.addMonths(-11);

    if(startDate > endDate){
    	alert('검색기간이 유효하지 않습니다.');
    	return;
    }
    if(startDate < testDate){
    	alert('최대 검색기간은 12개월 이내입니다.');
    	return;
    }
	
    // 각 열 합계 td 삭제
    $('#ALLSUM td').each(function(){
    	$(this).remove();
    });
    for(var j = 1; j < 6; j++){
    	$('#TR0'+j+' td').remove();
    }
    
	
<%
	// 기존에 있던 td 삭제
	for(int i = 0; i < allcnt; i++){
%>
		$('#<%=_dl_CASUE2.getString(i, "CODE")%> td').remove();
		$('#<%=_dl_CASUE2.getString(i, "CODE")%> th:eq(1)').remove();
<%
	}
%>
	
	//필수정보 체크
	var url = uxl.getFunctionUrl(_SCREEN_ID,'INQUIRY');
	var option = {
			  data:{BIZ_CHNN_SIZE : chnn_size}
			, success:function(result){
				var dl = result.getDataList(0);
				var rowSum = 0;
				var colSum = [11];
				var colSumSub = [];
				for(var i = 0; i < 11; i++){
					colSum[i] = 0;
				}

				for(var i = 0; i < dl.rowCount; i++){
					colSum[0] += dl.rows[i].DATA1*1;
					colSum[1] += dl.rows[i].DATA2*1;
					colSum[2] += dl.rows[i].DATA3*1;
					colSum[3] += dl.rows[i].DATA4*1;
					colSum[4] += dl.rows[i].DATA5*1;
					colSum[5] += dl.rows[i].DATA6*1;
					colSum[6] += dl.rows[i].DATA7*1;
					colSum[7] += dl.rows[i].DATA8*1;
					colSum[8] += dl.rows[i].DATA9*1;
					colSum[9] += dl.rows[i].DATA10*1;
					colSum[10] += dl.rows[i].DATA11*1;
					
					// 각 행의 합계
					rowSum = 0;
					rowSum += dl.rows[i].DATA1*1;
					rowSum += dl.rows[i].DATA2*1;
					rowSum += dl.rows[i].DATA3*1;
					rowSum += dl.rows[i].DATA4*1;
					rowSum += dl.rows[i].DATA5*1;
					rowSum += dl.rows[i].DATA6*1;
					rowSum += dl.rows[i].DATA7*1;
					rowSum += dl.rows[i].DATA8*1;
					rowSum += dl.rows[i].DATA9*1;
					rowSum += dl.rows[i].DATA10*1;
					rowSum += dl.rows[i].DATA11*1;
					
					$('#'+dl.rows[i].CODE).append(
							 '<th class="bg02">'+uxl.setComma(rowSum)+'</th>'
							+'<td>'+uxl.setComma(dl.rows[i].DATA1)+'</td>'
							+'<td>'+uxl.setComma(dl.rows[i].DATA2)+'</td>'
							+'<td>'+uxl.setComma(dl.rows[i].DATA3)+'</td>'
							+'<td>'+uxl.setComma(dl.rows[i].DATA4)+'</td>'
							+'<td>'+uxl.setComma(dl.rows[i].DATA5)+'</td>'
							+'<td>'+uxl.setComma(dl.rows[i].DATA6)+'</td>'
							+'<td>'+uxl.setComma(dl.rows[i].DATA7)+'</td>'
							+'<td>'+uxl.setComma(dl.rows[i].DATA8)+'</td>'
							+'<td>'+uxl.setComma(dl.rows[i].DATA9)+'</td>'
							+'<td>'+uxl.setComma(dl.rows[i].DATA10)+'</td>'
							+'<td>'+uxl.setComma(dl.rows[i].DATA11)+'</td>'
					);
				}
				for(var eq = 0; eq < 11; eq++){
					var tdSum = 0;
					var thSum = 0;
					// cause 01* 개수
					var txtIndex;
					for(var i = 1; i < <%=cnt01+1%>; i++){
						if(i < 10){
							txtIndex = '0'+i;
						}else{
							txtIndex = i;							
						}
						tdSum += $('#010'+ txtIndex +' td:eq('+eq+')').text().split(',').join('')*1;
						thSum += $('#010'+ txtIndex +' th:eq(1)').text().split(',').join('')*1;
					}
					$('#TR01 th:eq(1)').html(uxl.setComma(thSum));
					$('#TR01').append('<td>'+uxl.setComma(tdSum)+'</td>');
					
					tdSum = 0;
					thSum = 0;
					// cause 02* 개수
					var str_idx = "";
					for(var i = 1; i < <%=cnt02+1%>;i++){
						str_idx = i < 10? '0'+i:i;
						tdSum += $('#020'+str_idx+' td:eq('+eq+')').text().split(',').join('')*1;
						thSum += $('#020'+str_idx+' th:eq(1)').text().split(',').join('')*1;
					}
					$('#TR02 th:eq(1)').html(uxl.setComma(thSum));
					$('#TR02').append('<td>'+uxl.setComma(tdSum)+'</td>');
					
					tdSum = 0;
					thSum = 0;
					// cause 03* 개수
					for(var i = 1; i < <%=cnt03+1%>;i++){
						tdSum += $('#0300'+i+' td:eq('+eq+')').text().split(',').join('')*1;
						thSum += $('#0300'+i+' th:eq(1)').text().split(',').join('')*1;
					}
					$('#TR03 th:eq(1)').html(uxl.setComma(thSum));
					$('#TR03').append('<td>'+uxl.setComma(tdSum)+'</td>');
					
					tdSum = 0;
					thSum = 0;
					// cause 04* 개수
					for(var i = 1; i < <%=cnt04+1%>;i++){
						tdSum += $('#0400'+i+' td:eq('+eq+')').text().split(',').join('')*1;
						thSum += $('#0400'+i+' th:eq(1)').text().split(',').join('')*1;
					}
					$('#TR04 th:eq(1)').html(uxl.setComma(thSum));
					$('#TR04').append('<td>'+uxl.setComma(tdSum)+'</td>');
					
					tdSum = 0;
					thSum = 0;
					// cause 05* 개수
					for(var i = 1; i < <%=cnt05+1%>;i++){
						tdSum += $('#0500'+i+' td:eq('+eq+')').text().split(',').join('')*1;
						thSum += Number($('#0500'+i+' th:eq(1)').text().split(',').join(''));
					}
					$('#TR05 th:eq(1)').html(uxl.setComma(thSum));
					$('#TR05').append('<td>'+uxl.setComma(tdSum)+'</td>');
				}
				
				var allsum0 = 0;
				// 각 열 합계 td 생성
				for(var i = 0; i < 11; i++){
					$('#ALLSUM').append('<td>'+uxl.setComma(colSum[i])+'</td>');
					allsum0 += colSum[i];
				}
				$('#ALLSUM0').html(uxl.setComma(allsum0));
			}
			, async:true
	};
	uxl.callSubmitFunction('searchForm' , url , option );	
}

//엑셀파일 추출하기 
function fnGetExcel() {
	
	var chnn_size = $('input[name=CD_BIZ_CHNN]:checked').length;
    
    if(chnn_size < 1){
    	alert('채널을 1개 이상 선택해 주십시오.');
    	return;
    }
	
	var data = {BIZ_CHNN_SIZE : chnn_size};
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