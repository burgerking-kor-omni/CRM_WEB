/**
 * APMD HSQL DATA 조회 함수
 * 2016-09-22 : 카테고리 값 선택시 오류 수정
 */

var hsqlData = {};

// 카테고리 코드 불러오기
hsqlData.getCategoryCode = function(comboId, options){
	options = jQuery.extend({
		  blankOption : null
		, selectValue : null
	}, options);
	var selectValue = options.selectValue;
	var blankOption = options.blankOption;
	
	var url = uxl.getContextURL("/hsql/categoryCode.ub");
	var option = {
			data:{}
		  , success:function(result) {
			  var dt = result.getDataList();
			  var $select = $("select#"+comboId);
			  $select.empty();
			  if(blankOption != null || blankOption != ''){
				  $select.append("<option value=''>"+blankOption+"</option>");
			  }
			  for(var i = 0; i<dt.rows.length;i++){
				  var comboOption = "<option value='"+dt.rows[i].TYPE+"'>["+dt.rows[i].TYPE+"] "+dt.rows[i].NAME+"</option>"; 
				  $select.append(comboOption);
				  if(selectValue == dt.rows[i].TYPE){
					  $("option[value='"+dt.rows[i].TYPE+"']", $select).selected();
				  }
			  }
		  }
		  , async:false
		};
	uxl.callFunction(url, option);
};

// 메타화면 리스트 불러오기
hsqlData.getPidList = function(comboId, options){
	options = jQuery.extend({
		  blankOption : null
		, categoryCode : null
	}, options);
	var blankOption = options.blankOption;
	var categoryCode = options.categoryCode;
	
	if(blankOption != null || blankOption != ''){
		  $("select#"+comboId).append("<option value=''>"+blankOption+"</option>");
	}
	if(categoryCode == null || categoryCode == ''){
		return;
	}
	
	var url = uxl.getContextURL("/hsql/pidList.ub");
	var option = {
		  data:{"CATEGORY_CODE":categoryCode}
		, success:function(result){
			if(result.getDataList().rowCount==0){
				return;
			}
			var dt = result.getDataList();
			for(var i = 0; i<dt.rows.length;i++){
				  var comboOption = "<option value='"+dt.rows[i].PID+"' title='"+dt.rows[i].DESCRIPTION+"'>"+dt.rows[i].PID+"   "+dt.rows[i].DESCRIPTION+"</option>"; 
				  $("select#"+comboId).append(comboOption);
			}
		}
	};
	uxl.callFunction(url, option);
};

// 메타화면 리스트 불러오기 (상세)
hsqlData.getPidListDetail = function(comboId, options){
	options = jQuery.extend({
		  blankOption : null
		, selectValue : null 
		, categoryCode : null
		, screenId : null
	}, options);
	var blankOption = options.blankOption;
	var selectValue = options.selectValue;
	var categoryCode = options.categoryCode;
	var screenId = options.screenId;
	
	if(blankOption != null || blankOption != ''){
		  $("select#"+comboId).append("<option value=''>"+blankOption+"</option>");
	}
	
	if(categoryCode == null || categoryCode == '' || screenId == null || screenId == ''){
		return;
	}
	
	var url = uxl.getContextURL("/hsql/pidListDetail.ub");
	var option = {
		  data:{"CATEGORY_CODE":categoryCode, "CURRENT_SCREEN_ID":screenId}
		, success:function(result){
			if(result.getDataList().rowCount==0){
				return;
			}
			var dt = result.getDataList();
			for(var i = 0; i<dt.rows.length;i++){
				  var comboOption = "<option value='"+dt.rows[i].PID+"' title='"+dt.rows[i].DESCRIPTION+"'>"+dt.rows[i].PID+"   "+dt.rows[i].DESCRIPTION+"</option>"; 
				  $("select#"+comboId).append(comboOption);
			}
			$("option[value='"+selectValue+"']", $('select#'+comboId)).selected();
		}
	};
	uxl.callFunction(url, option);
};

// 메타화면이름 불러오기
hsqlData.getScreenName = function(pid){
	if(pid == null || pid == ''){
		return;
	}
	
	var returnValue = "";
	var url=uxl.getContextURL("/hsql/screenName.ub");
	var option = {
		  data:{"PID":pid}
		, success:function(result){
			if(result.getDataList().rowCount==0){
				returnValue = '['+pid+'] 메타화면이 존재하지 않습니다.';
			}else{
				returnValue = result.getDataList().rows[0].PID_NAME;
			}
		}
	};
	uxl.callFunction(url, option);
	return returnValue;	
};