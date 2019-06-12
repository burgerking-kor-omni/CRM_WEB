<%--
#*
 *  파 일 명 :  APM0025.jsp
 *  설    명 :  서비스 데이터 변환 목록
 *  작 성 자 :  유기태
 *  작 성 일 :  2015.02.23
 *  버    전 :  1.0
 *  기타사항 :
 *  Copyrights 2013 by ㈜ 유비원. All right reserved.
*# 
--%>
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
	DataList _dataList = null;		/* List Table default dataTable */ 
	DataList _dl_MASK_LIST = ViewUtil.getResult().getDataList("Code.APMD_MASK_LIST");
	DataList _dl_CD_CRYPTO_TYPE = ViewUtil.getResult().getDataList("Code.CD_CRYPTO_TYPE");	
	DataList _dl_CD_CRYPTO_MODE = ViewUtil.getResult().getDataList("Code.CD_CRYPTO_MODE");	
%>

<!-- layout-1 Start -->

<form id="searchForm" name="searchForm">
	<input type=hidden id="SERVICE_ID" name="SERVICE_ID"    value="${paramMap.SERVICE_ID}">
</form>
<h2 class="ub-control title">데이터 변환</h2>
<div class="ub-layout floatBox" style="height:220px">
	<div class="ub-layout leftBox"   style="width:49%; ">
		<h3 class="ub-control title">Before SO
			<div class="ub-layout button inner"  style="text-align:right;">
				<a href="#none" title="Add" class="ub-control button imgBtn img-plus" id="btnAddBeforeSo" name="btnAddBeforeSo">
					<span>@@</span>
				</a>
			</div>
		</h3>
		<div id="beforeSoDiv" name="beforeSoDiv" style="overflow-y:scroll; height:175px;">
			<table class="ub-control table list">
				<colgroup>
					<col style="width:30%">
					<col style="width:30%">
					<col style="width:30%">
					<col style="width:10%">
				</colgroup>
				<thead>
					<tr>
						<th>파라미터</th>
						<th>유형</th>
						<th>변환종류</th>
						<th></th>
					</tr>
				</thead>
				<tbody>
					<tr id="beforeSoInput" name="inputData" style="display:none;">
						<td><input type=text  class="ub-control input-text " style="text-align:left;width:90%;"></td>
						<td><select class="ub-control select " style="width:100%;" size="1"><%    if(!"선택안됨".equals("")){        out.println("<OPTION VALUE=\"\">선택안됨</OPTION>\r\n");    }    if(_dl_CD_CRYPTO_TYPE != null){        for(int codeIdx=0; codeIdx < _dl_CD_CRYPTO_TYPE.getRowCount(); codeIdx++){            String code = _dl_CD_CRYPTO_TYPE.getString(codeIdx, ConstantHolder.CODE_COLUMN_CODE);            String name = _dl_CD_CRYPTO_TYPE.getString(codeIdx, ConstantHolder.CODE_COLUMN_NAME);            out.println("<option VALUE=\""+code+"\">"+name+"</option>\r\n");        }    }%></select></td>
						<td><select class="ub-control select " style="width:100%;" size="1"><%    if(!"선택안됨".equals("")){        out.println("<OPTION VALUE=\"\">선택안됨</OPTION>\r\n");    }    if(_dl_CD_CRYPTO_MODE != null){        for(int codeIdx=0; codeIdx < _dl_CD_CRYPTO_MODE.getRowCount(); codeIdx++){            String code = _dl_CD_CRYPTO_MODE.getString(codeIdx, ConstantHolder.CODE_COLUMN_CODE);            String name = _dl_CD_CRYPTO_MODE.getString(codeIdx, ConstantHolder.CODE_COLUMN_NAME);            out.println("<option VALUE=\""+code+"\">"+name+"</option>\r\n");        }    }%></select></td>
						<td style="text-align:center;">
							<a href="#none" title="Add" class="ub-control button imgBtn img-plus" onclick="javascript:registBeforeSo();">
								<span>@@</span>
							</a>
						</td>
					</tr>
				</tbody>
			</table>
		</div>
	</div>
	<div class="ub-layout rightBox"   style="width:49%;">
		<h3 class="ub-control title">Before DAO
			<div class="ub-layout button inner"  style="text-align:right;">
				<a href="#none" title="Add" class="ub-control button imgBtn img-plus" id="btnAddBeforeDao" name="btnAddBeforeDao">
					<span>@@</span>
				</a>
			</div>
		</h3>
		<div id="beforeDaoDiv" name="beforeDaoDiv" style="overflow-y:scroll; height:175px;">
			<table class="ub-control table list">
				<colgroup>
					<col style="width:30%">
					<col style="width:30%">
					<col style="width:30%">
					<col style="width:10%">
				</colgroup>
				<thead>
					<tr>
						<th>파라미터</th>
						<th>유형</th>
						<th>변환종류</th>
						<th></th>
					</tr>
				</thead>
				<tbody>
					<tr id="beforeDaoInput" name="inputData" style="display:none;">
						<td><input type=text  class="ub-control input-text " style="text-align:left;width:90%;"></td>
						<td><select class="ub-control select " style="width:100%;" size="1"><%    if(!"선택안됨".equals("")){        out.println("<OPTION VALUE=\"\">선택안됨</OPTION>\r\n");    }    if(_dl_CD_CRYPTO_TYPE != null){        for(int codeIdx=0; codeIdx < _dl_CD_CRYPTO_TYPE.getRowCount(); codeIdx++){            String code = _dl_CD_CRYPTO_TYPE.getString(codeIdx, ConstantHolder.CODE_COLUMN_CODE);            String name = _dl_CD_CRYPTO_TYPE.getString(codeIdx, ConstantHolder.CODE_COLUMN_NAME);            out.println("<option VALUE=\""+code+"\">"+name+"</option>\r\n");        }    }%></select></td>
						<td><select class="ub-control select " style="width:100%;" size="1"><%    if(!"선택안됨".equals("")){        out.println("<OPTION VALUE=\"\">선택안됨</OPTION>\r\n");    }    if(_dl_CD_CRYPTO_MODE != null){        for(int codeIdx=0; codeIdx < _dl_CD_CRYPTO_MODE.getRowCount(); codeIdx++){            String code = _dl_CD_CRYPTO_MODE.getString(codeIdx, ConstantHolder.CODE_COLUMN_CODE);            String name = _dl_CD_CRYPTO_MODE.getString(codeIdx, ConstantHolder.CODE_COLUMN_NAME);            out.println("<option VALUE=\""+code+"\">"+name+"</option>\r\n");        }    }%></select></td>
						<td style="text-align:center;">
							<a href="#none" title="Add" class="ub-control button imgBtn img-plus" onclick="javascript:registBeforeDao();">
								<span>@@</span>
							</a>
						</td>
					</tr>
				</tbody>
			</table>
		</div>
	</div>
</div>

<h2 class="ub-control title">데이터 마스킹</h2>
<div class="ub-layout floatBox" style="height:220px">
	<div class="ub-layout leftBox"   style="width:49%; ">
		<h3 class="ub-control title">After SO
			<div class="ub-layout button inner"  style="text-align:right;">
				<a href="#none" title="Add" class="ub-control button imgBtn img-plus" id="btnAddAfterSo" name="btnAddAfterSo">
					<span>@@</span>
				</a>
			</div>
		</h3>
		<div id="afterSoDiv" name="afterSoDiv" style="overflow-y:scroll; height:175px;">
			<table class="ub-control table list">
				<colgroup>
					<col style="width:30%">
					<col style="width:30%">
					<col style="width:30%">
					<col style="width:10%">
				</colgroup>
				<thead>
					<tr>
						<th>DataList</th>
						<th>컬럼</th>
						<th>Mask</th>
						<th></th>
					</tr>
				</thead>
				<tbody>
					<tr id="afterSoInput" name="inputData" style="display:none;">
						<td><input type=text  class="ub-control input-text " style="text-align:left;width:90%;"></td>
						<td><input type=text  class="ub-control input-text " style="text-align:left;width:90%;"></td>
						<td><select class="ub-control select " style="width:100%;" size="1"><%    if(!"선택안됨".equals("")){        out.println("<OPTION VALUE=\"\">선택안됨</OPTION>\r\n");    }    if(_dl_MASK_LIST != null){        for(int codeIdx=0; codeIdx < _dl_MASK_LIST.getRowCount(); codeIdx++){            String code = _dl_MASK_LIST.getString(codeIdx, ConstantHolder.CODE_COLUMN_CODE);            String name = _dl_MASK_LIST.getString(codeIdx, ConstantHolder.CODE_COLUMN_NAME);            out.println("<option VALUE=\""+code+"\">"+name+"</option>\r\n");        }    }%></select></td>
						<td style="text-align:center;">
							<a href="#none" title="Add" class="ub-control button imgBtn img-plus" onclick="javascript:registAfterSo();">
								<span>@@</span>
							</a>
						</td>
					</tr>
				</tbody>
			</table>
		</div>
	</div>
	<div class="ub-layout rightBox"   style="width:49%;">
		<h3 class="ub-control title">After DAO
			<div class="ub-layout button inner"  style="text-align:right;">
				<a href="#none" title="Add" class="ub-control button imgBtn img-plus" id="btnAddAfterDao" name="btnAddAfterDao">
					<span>@@</span>
				</a>
			</div>
		</h3>
		<div id="afterDaoDiv" name="afterDaoDiv" style="overflow-y:scroll; height:175px;">
			<table class="ub-control table list">
				<colgroup>
					<col style="width:30%">
					<col style="width:30%">
					<col style="width:30%">
					<col style="width:10%">
				</colgroup>
				<thead>
					<tr>
						<th>DataList</th>
						<th>컬럼</th>
						<th>Mask</th>
						<th></th>
					</tr>
				</thead>
				<tbody>
					<tr id="afterDaoInput" name="inputData" style="display:none;">
						<td><input type=text  class="ub-control input-text " style="text-align:left;width:90%;"></td>
						<td><input type=text  class="ub-control input-text " style="text-align:left;width:90%;"></td>
						<td><select class="ub-control select " style="width:100%;" size="1"><%    if(!"선택안됨".equals("")){        out.println("<OPTION VALUE=\"\">선택안됨</OPTION>\r\n");    }    if(_dl_MASK_LIST != null){        for(int codeIdx=0; codeIdx < _dl_MASK_LIST.getRowCount(); codeIdx++){            String code = _dl_MASK_LIST.getString(codeIdx, ConstantHolder.CODE_COLUMN_CODE);            String name = _dl_MASK_LIST.getString(codeIdx, ConstantHolder.CODE_COLUMN_NAME);            out.println("<option VALUE=\""+code+"\">"+name+"</option>\r\n");        }    }%></select></td>
						<td style="text-align:center;">
							<a href="#none" title="Add" class="ub-control button imgBtn img-plus" onclick="javascript:registAfterDao();">
								<span>@@</span>
							</a>
						</td>
					</tr>
				</tbody>
			</table>
		</div>
	</div>
</div>

<!-- layout-1 End -->



<script type="text/javascript">
	uxl.onLoad(function(){
		
		fnSearch();
		
		$('#btnAddBeforeSo').click(function(){
			var inputLayout = $('#beforeSoInput');
			
			if(inputLayout.css('display') == 'none'){
				$('#beforeSoDiv').scrollTop(0);
				inputLayout.css('display','');
			}else{
				inputLayout.css('display','none');
			}
		});
		
		$('#btnAddBeforeDao').click(function(){
			var inputLayout = $('#beforeDaoInput');
			
			if(inputLayout.css('display') == 'none'){
				$('#beforeDaoDiv').scrollTop(0);
				inputLayout.css('display','');
			}else{
				inputLayout.css('display','none');
			}
		});
		
		$('#btnAddAfterSo').click(function(){
			var inputLayout = $('#afterSoInput');
			
			if(inputLayout.css('display') == 'none'){
				$('#afterSoDiv').scrollTop(0);
				inputLayout.css('display','');
			}else{
				inputLayout.css('display','none');
			}
		});

		$('#btnAddAfterDao').click(function(){
			var inputLayout = $('#afterDaoInput');
			
			if(inputLayout.css('display') == 'none'){
				$('#afterDaoDiv').scrollTop(0);
				inputLayout.css('display','');
			}else{
				inputLayout.css('display','none');
			}
		});
		
	});

	function fnSearch(){
		var url = uxl.getFunctionUrl(_SCREEN_ID, 'INQUIRY');
		var option = {
			data:{}
			
		    /*
			 * 조회한 데이터를 그리드에 추가함.
			 * @param {String} 그리드로 변환할 테이블ID
			 * @param {Result} 조회된 데이터 객체 result
			 * @param {boolean} 데이터 추가시 기존데이터의 clear 여부
			 */
		  , success:function(result) {
				// 불러온 DataList별 그리드 그리기
				createBeforeGrid(result.getDataList('BeforeSO'), 'beforeSoDiv');
				createBeforeGrid(result.getDataList('BeforeDAO'), 'beforeDaoDiv');
			  	createAfterGrid(result.getDataList('AfterSO'), 'afterSoDiv');
				createAfterGrid(result.getDataList('AfterDAO'), 'afterDaoDiv');
			}
		  , async:true
		};
		uxl.callSubmitFunction("searchForm", url, option);		
	}
	
	function createBeforeGrid(listData, divId){
		var strHtml = "";

		if(listData.rowCount == 0){
			strHtml += "<tr name='convertData'>";
			strHtml += "	<td colspan='4' style='text-align:center;'>등록된 데이터가 없습니다.</td>";
			strHtml += "</tr>";
		}else{
			for(var i = 0; i < listData.rowCount ; i++){
				var rowData = listData.rows[i];
				strHtml += "<tr name='convertData'>";
				strHtml += "	<td>"+rowData.PARAMETER_NAME+"</td>";
				strHtml += "	<td>"+rowData.CRYPTO_TYPE+"</td>";
				strHtml += "	<td>"+rowData.CRYPTO_MODE+"</td>";
				strHtml += "	<td style='text-align:center;'><a href='#none' title='Remove' class='ub-control button imgBtn img-minus' onclick='javascript:deleteBeforeData(\""+rowData.SERVICE_CRYPTO_ID+"\");'><span>@@</span></a></td>";
				strHtml += "</tr>";
			}
		}
		
		strHtml += "</tbody>";
		strHtml += "</table>";

		$('#'+divId+' > table > tbody').append(strHtml);
	};
	
	function createAfterGrid(listData, divId){
		var strHtml = "";

		if(listData.rowCount == 0){
			strHtml += "<tr name='convertData'>";
			strHtml += "	<td colspan='4' style='text-align:center;'>등록된 데이터가 없습니다.</td>";
			strHtml += "</tr>";
		}else{
			for(var i = 0; i < listData.rowCount ; i++){
				var rowData = listData.rows[i];
				strHtml += "<tr name='convertData'>";
				strHtml += "	<td>"+rowData.DATALIST_ID+"</td>";
				strHtml += "	<td>"+rowData.COLUMN_NAME+"</td>";
				strHtml += "	<td>"+rowData.NM_MASK+"</td>";
				strHtml += "	<td style='text-align:center;'><a href='#none' title='Remove' class='ub-control button imgBtn img-minus' onclick='javascript:deleteAfterData(\""+rowData.SERVICE_MASK_ID+"\");'><span>@@</span></a></td>";
				strHtml += "</tr>";
			}
		}
		
		strHtml += "</tbody>";
		strHtml += "</table>";

		$('#'+divId+' > table > tbody').append(strHtml);
	};

	function registAfterSo(){
		var dataInput = $('#afterSoInput > td');
		var dataListId = dataInput.eq(0).children();
		var columnName = dataInput.eq(1).children();
		var maskId     = dataInput.eq(2).children();
		var checkFields = [dataListId.val(), columnName.val(), maskId.val()];
		
		if(fnCheckFields(checkFields)){
			uxl.showMessage('모든 항목을 입력해 주세요.');
			return false;
		};
		
		var url = uxl.getFunctionUrl(_SCREEN_ID, 'USERDEFINED1');
		var option = {
			data:{SERVICE_ID :$('#SERVICE_ID').val()
				, POINTCUT_CD:'AS'
				, DATALIST_ID:dataListId.val()
				, COLUMN_NAME:columnName.val()
				, MASK_ID	 :maskId.val()}
		  , success:function(result) {
			  
			  dataListId.val('');
			  columnName.val('');
			  maskId.val('');
			  
			  reloadConvertData();
			}
		  , async:true
		  , message : {
				confirm : uxl.getMessage('@message.common.insert.confirm'),
				success : uxl.getMessage('@message.common.insert.success'),
				fail : uxl.getMessage('@message.common.insert.fail')
			}
		  
		};
		uxl.callFunction(url, option);
	}
	
	function registAfterDao(){
		var dataInput = $('#afterDaoInput > td');
		var dataListId = dataInput.eq(0).children();
		var columnName = dataInput.eq(1).children();
		var maskId     = dataInput.eq(2).children();	
		var checkFields = [dataListId.val(), columnName.val(), maskId.val()];
		
		if(fnCheckFields(checkFields)){
			uxl.showMessage('모든 항목을 입력해 주세요.');
			return false;
		};
		
		var url = uxl.getFunctionUrl(_SCREEN_ID, 'USERDEFINED1');
		var option = {
			data:{SERVICE_ID :$('#SERVICE_ID').val()
				, POINTCUT_CD:'AD'
				, DATALIST_ID:dataListId.val()
				, COLUMN_NAME:columnName.val()
				, MASK_ID	 :maskId.val()}
		  , success:function(result) {
			  
			  dataListId.val('');
			  columnName.val('');
			  maskId.val('');
			  
			  reloadConvertData();
			}
		  , async:true
		  , message : {
				confirm : uxl.getMessage('@message.common.insert.confirm'),
				success : uxl.getMessage('@message.common.insert.success'),
				fail : uxl.getMessage('@message.common.insert.fail')
			}
		  
		};
		uxl.callFunction(url, option);
	}
	
	function registBeforeSo(){
		var dataInput = $('#beforeSoInput > td');
		var parameterName = dataInput.eq(0).children();
		var cryptoType    = dataInput.eq(1).children();
		var cryptoMode    = dataInput.eq(2).children();		
		var checkFields = [parameterName.val(), cryptoType.val(), cryptoMode.val()];
		
		if(fnCheckFields(checkFields)){
			uxl.showMessage('모든 항목을 입력해 주세요.');
			return false;
		};
		
		var url = uxl.getFunctionUrl(_SCREEN_ID, 'USERDEFINED3');
		var option = {
			data:{SERVICE_ID :$('#SERVICE_ID').val()
				, POINTCUT_CD:'BS'
				, PARAMETER_NAME:parameterName.val()
				, CRYPTO_TYPE:cryptoType.val()
				, CRYPTO_MODE:cryptoMode.val()}
		  , success:function(result) {
			  parameterName.val('');
			  cryptoType.val('');
			  cryptoMode.val('');
			  
			  reloadConvertData();
			}
		  , async:true
		  , message : {
				confirm : uxl.getMessage('@message.common.insert.confirm'),
				success : uxl.getMessage('@message.common.insert.success'),
				fail : uxl.getMessage('@message.common.insert.fail')
			}
		  
		};
		uxl.callFunction(url, option);
	}
	
	function registBeforeDao(){
		var dataInput = $('#beforeDaoInput > td');
		var parameterName = dataInput.eq(0).children();
		var cryptoType    = dataInput.eq(1).children();
		var cryptoMode    = dataInput.eq(2).children();		
		var checkFields = [parameterName.val(), cryptoType.val(), cryptoMode.val()];
		
		if(fnCheckFields(checkFields)){
			uxl.showMessage('모든 항목을 입력해 주세요.');
			return false;
		};

		
		var url = uxl.getFunctionUrl(_SCREEN_ID, 'USERDEFINED3');
		var option = {
			data:{SERVICE_ID :$('#SERVICE_ID').val()
				, POINTCUT_CD:'BD'
				, PARAMETER_NAME:parameterName.val()
				, CRYPTO_TYPE:cryptoType.val()
				, CRYPTO_MODE:cryptoMode.val()}
		  , success:function(result) {
			  parameterName.val('');
			  cryptoType.val('');
			  cryptoMode.val('');
			  
			  reloadConvertData();
			}
		  , async:true
		  , message : {
				confirm : uxl.getMessage('@message.common.insert.confirm'),
				success : uxl.getMessage('@message.common.insert.success'),
				fail : uxl.getMessage('@message.common.insert.fail')
			}
		  
		};
		uxl.callFunction(url, option);
	}
	
	function deleteBeforeData(id){
		var url = uxl.getFunctionUrl(_SCREEN_ID, 'USERDEFINED4');
		var option = {
			data:{"SERVICE_ID" : $('#SERVICE_ID').val(), "SERVICE_CRYPTO_ID" : id}
		  , success:function(result) {
			  reloadConvertData();
			  
			}
		  , async:true
		  , message : {
				confirm : uxl.getMessage('@message.common.delete.confirm'),
				success : uxl.getMessage('@message.common.delete.success'),
				fail : uxl.getMessage('@message.common.delete.fail')
			}
		};
		uxl.callFunction(url, option);
	}
	
	function deleteAfterData(id){
		var url = uxl.getFunctionUrl(_SCREEN_ID, 'USERDEFINED2');
		var option = {
			data:{"SERVICE_ID" : $('#SERVICE_ID').val(), "SERVICE_MASK_ID" : id}
		  , success:function(result) {
			  reloadConvertData();
			  
			}
		  , async:true
		  , message : {
				confirm : uxl.getMessage('@message.common.delete.confirm'),
				success : uxl.getMessage('@message.common.delete.success'),
				fail : uxl.getMessage('@message.common.delete.fail')
			}
		};
		uxl.callFunction(url, option);
	}
	
	function fnCheckFields(fields){
		var flag = false;
		for(var i = 0; i < fields.length; i++){
			if(fields[i] == null || fields[i] == ''){
				flag = true;
				return flag;
			}
		}
		return flag;
	}
	
	function reloadConvertData(){
		var allData = $('tr[name="convertData"]');
		var inputData = $('tr[name="inputData"]');
		inputData.hide();
		allData.remove();
		fnSearch();
	}
	
	
	
</script>