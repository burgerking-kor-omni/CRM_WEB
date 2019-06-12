<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/include/pageCommon.jsp"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core"   prefix="c" %>

<h1 class="ub-control title">SQL 관리</h1>
<div class="ub-layout detail">
<form id="searchForm" name="searchForm">
	<table class="ub-control table normal ">
		<colgroup>
			<col width="80px"/>
			<col />
			<col width="80px"/>
			<col width="300px"/>
		</colgroup>
		<tbody>
			<tr>
				<th>
					<label class="ub-control label">Query</label>
				</th>
				<td>
					* 최대 1000건까지만 조회 됩니다.
					<textarea class="ub-control textarea" id="queryString" name="queryString" rows="10" style="width:95%;"></textarea>
				</td>
				<th style="text-align: center;">
					<span class="ub-control button search" id="search">
						<a href="#none" title="Search">Execute</a>
					</span>
				</th>
				<td>
					<select id="recentList" size="12" style="width:100%;">
						<option value="">Click to reload the query.</option>
					</select>
				</td>
			</tr>
		</tbody>
	</table>
</form>
</div>
<!-- layout-1 End -->
<div id="divList" class="ub-layout list"></div>
<script type="text/javascript">
//uxl.onLoad(function(){
$(document).ready(function(){	
	$('#search').click(function(){
		fnSearch();
	});
	
	$.Shortcuts.add({
	    type: 'down',
	    mask: 'Ctrl+Enter',
	    handler: function() {
	    	fnSearch();
	    }
	});
});

function fnSearch(){
	if(uxl.isEmpty($('#queryString').val())){
		alert('실행쿼리를 입력하세요.');
		return;
	}

//	var $table = $('.ub-control.table.list');
//	$table.empty();
	$('.resultCount').text('');
	
	//필수정보 체크
	var url = uxl.getFunctionUrl(_SCREEN_ID,'EXECUTE');
	var option = {
			  data:{}
			, success:function(result){
				if(result.isSuccess()){
					if(result.getResultCount() == -1){
						processSelectResult(result);
					}else{
						processExecuteResult(result);
					}
					addHistory();
				}
			}
			, fail:function(result){
				var $table = $('.ub-control.table.list');
				$table.empty();

				var html = '';
				html += '<thead><tr><th>실행결과</th></tr></thead>';
				html += '<tbody><tr><td><pre style="color:red">'+result.getServiceMessage().message+'</pre></td></tr></tbody>';
				$table.append(html);

			}
			, async:true
	};
	uxl.callSubmitFunction('searchForm', url , option );		
}

/**
 * Select 쿼리 실행결과 처리
 */
function processSelectResult(result){

	var options = {
			 colNames:[]
			,colModel:[]
			,height:270
			,autowidth:false
			,autoheight:true
			,bottomHeight:0
		};

	var dataList = result.getDataList(0);

	// 이미 생성된 그리드를 삭제한다.
	$('#divList').empty();
	$('#divList').append('<span>실행건수 : <label class="resultCount">'+dataList.rowCount+'</label></span><br>');
	$('#divList').append('<table class="ub-control grid" id="list"></table>');
	
	if(dataList.rowCount > 0){
		// 헤드 추가
		var columnNames = dataList.columnNames[0]['string'];
		if(!uxl.isArray(columnNames)){
			columnNames = new Array();
			columnNames[0] = dataList.columnNames[0]['string'];
		}

		options.colNames = columnNames;
		for(var i=0; i<columnNames.length; i++){
			options.colModel.push({name:columnNames[i],width:150});
		}
		uxl.grid('list', options);
		uxl.grid.loadData('list', result, true);
	}	
}

/**
 * Select 쿼리 실행결과 처리
 */
function processSelectResult2(result){
	var $table = $('.ub-control.table.list');
	$table.empty();

	var dataList = result.getDataList(0);
	if(dataList.rowCount > 0){
		$('.resultCount').text(dataList.rowCount);
		
		// 헤드 추가
		var columnNames = dataList.columnNames[0]['string'];
		if(!uxl.isArray(columnNames)){
			columnNames = new Array();
			columnNames[0] = dataList.columnNames[0]['string'];
		}

		var $thead = $('<thead>'); 
		var $thead_tr = $('<tr>');
		$thead.append($thead_tr);

		for(var i=0; i<columnNames.length; i++){
			$thead_tr.append('<th>'+columnNames[i]+'</th>');
		}
		$table.append($thead);

		var $tbody = $('<tbody>'); 
		for(var i=0; i<dataList.rows.length; i++){
			var $tbody_tr = $('<tr>');
			
			for(var j=0; j<columnNames.length; j++){
				var colName = columnNames[j];
				$tbody_tr.append('<td>'+dataList.rows[i][colName]+'</td>');
			}
			$tbody.append($tbody_tr);
			
			if(i>100){
				var $tbody_tr = $('<tr>');
				$tbody_tr.append('<td colspan="'+columnNames.length+'">100개 이상은 표시하지 않습니다.</td>');
				$tbody.append($tbody_tr);
				break;
			}
		}
		$table.append($tbody);
	}else{
		var html = '';
		html += '<thead><tr><th>실행결과</th></tr></thead>';
		html += '<tbody><tr><td>검색된 결과가 없습니다.</td></tr></tbody>';
		$table.append(html);
	}
}

/**
 * Insert / Update / Delete 쿼리 실행 결과 처리
 */
function processExecuteResult(result){
	var $table = $('.ub-control.table.list');
	$table.empty();

	var html = '';
	html += '<thead><tr><th>실행결과</th></tr></thead>';
	html += '<tbody><tr><td>'+result.getResultCount()+' 건이 처리되었습니다.</td></tr></tbody>';
	$table.append(html);
}

function addHistory(){
	var queryText = $('#queryString').val();
	var $option = $('<option>', {value:queryText, text:queryText});
	$option.click(function(){
		$('#queryString').val(this.value);
	});
	
	$('#recentList').prepend($option);
}
</script>