(function($, uxl) {
	
	/**
	 * @class jqgrid module<br/>
	 * @author AHN
	 * @see uxl-jqgrid-1.0.0.js
	 */
	
	var optionsList = {};
	
	/**
	 * @param {element} jquery's selector or table's id 
	 * @param {options} custom options
	 * @param {pagerFlag} check whether making navigation is true or not
	 */
	uxl.grid= function(element, options) {
		// making jqgrid object
		$('.ub-control.temp').remove();
		
		$jqGrid = uxl.isString(element)? $('#'+element) : element;

		// default options
		options = $.extend({
			datatype:"local",
			viewrecords:true,
			sortable:true,
			rowNum:"10",
			scroll:true,
			height:"261px",
			onSelectRow:function(id){
				
			}
		}, options || {});
		
		// excuting jqgrid!
		$jqGrid.jqGrid(options);
		optionsList[$jqGrid.attr('id')] = options;
		
		$(window).resize(function(){
			var $jqGridPanel = $jqGrid.parents().find('.ui-jqgrid.ui-widget');
			$jqGridPanel.width('auto');
			
			$('.ui-jqgrid-view', $jqGridPanel).width('auto');
			$('.ui-jqgrid-hdiv', $jqGridPanel).width('auto');
			$('.ui-jqgrid-bdiv', $jqGridPanel).width('auto');
			$jqGrid.setGridWidth('auto', true);

	    }).trigger('resize');
	};
	
	uxl.grid.init = function(grid){
		// making jqgrid object
		$jqGrid = uxl.isString(grid)? $('#'+grid) : grid;
		var $form = $('#'+$(".ub-control.pagging[for='"+$jqGrid.attr('id')+"']").attr('formId'));
		$('#'+_KEY_PAGE_NUMBER , $form).remove(); 
		$('#'+_KEY_PAGE_BLOCK , $form).remove();
		$('#'+_KEY_PAGE_ORDER_COLUMN , $form).remove();
		$('#'+_KEY_PAGE_ORDER_ASC , $form).remove();
	};
	
	uxl.grid.getParam = function(grid){
		// making jqgrid object
		$jqGrid = uxl.isString(grid)? $('#'+grid) : grid;
		var colModel = optionsList[$jqGrid.attr('id')].colModel;
		var param = new Object();
		
		var columnNames = new Array();
		var codeCategories = new Array();
		
		for(var i=0; i<colModel.length; i++){
			var model = colModel[i];
			if(uxl.isNotEmpty(model.codeCategory)){
				columnNames[i] = model.name;
				codeCategories[i] = uxl.isNotEmpty(model.codeCategory)?model.codeCategory:"";
				//param['_GRID_COLUMN_NAME']   = model.name;
				//param['_GRID_CODE_CATEGORY'] = uxl.isNotEmpty(model.codeCategory)?model.codeCategory:"";
			}
		}
		
		param['_GRID_COLUMN_NAME']   = columnNames;
		param['_GRID_CODE_CATEGORY'] = codeCategories;
		
		
		return param;
	};
	
	uxl.grid.clearGridData = function(grid) {
		$jqGrid = uxl.isString(grid)? $('#'+grid) : grid;
		$jqGrid.jqGrid('clearGridData');
	};

	uxl.grid.appendData = function(grid , result , clearFlag) {
		
		// making jqgrid object
		$jqGrid = uxl.isString(grid)? $('#'+grid) : grid;
		
		if(true == clearFlag) {
			$jqGrid.jqGrid('clearGridData');
		}
		
		if(uxl.isNotNull(result.getDataList(0))){
			var dataSet = result.getDataList(0).rows;
			var rowCount = result.getDataList(0).rowCount;
			
			var gridRowCount = $jqGrid.getGridParam("records");
			
			var i=0;
			for( i ; i < rowCount ;  dataSet){
				$jqGrid.jqGrid('addRowData',i+gridRowCount,dataSet[i]);
				
				if(dataSet[i]['CHECKED'] == 'Y'){
					$jqGrid.jqGrid('setSelection',i+gridRowCount,false);
				}
				i++;
			}
			uxl.grid.initPaging($jqGrid, result);
		}
	};
	

	uxl.grid.rowCount = function(element) {
		// making jqgrid object
		$jqGrid = uxl.isString(element)? $('#'+element) : element;
		
		return $jqGrid.getGridParam("records");
	};
	
    /**
	 *  jqGrid Paging Rendering
	 */
	uxl.grid.initPaging = function($jqGrid, result){
		
		var totalCount = result.getServiceMessage().totalCount;  //총 건수
		var pageNum    = result.getServiceMessage().pageNum;     //현재 페이지
		var pageSize   = result.getServiceMessage().pageSize;    //한페이지 Row수
		
		// 한 블럭의 페이지 수
	    var pageCntPerBlock = 10;
	    // 그리드 데이터 전체의 페이지 수
	    var totalPage = Math.ceil(totalCount/pageSize);//113/10 11.3 totalPage 12
	    // 전체 페이지 수를 한화면에 보여줄 페이지로 나눈다.
	    var totalPageList = Math.ceil(totalPage/pageCntPerBlock); // 12/10 = 1.2  2
	    // 페이지 리스트가 몇번째 리스트인지
	    var pageList=Math.ceil(pageNum/pageCntPerBlock);  // 1 1 2 1 3 1 100 10 101 

	    // 페이지 리스트가 1보다 작으면 1로 초기화
	    if(pageList<1) pageList=1;
	    // 페이지 리스트가 총 페이지 리스트보다 커지면 총 페이지 리스트로 설정
	    if(pageList>totalPageList) pageList = totalPageList;
	    // 시작 페이지
	    var startPageList=((pageList-1)*pageCntPerBlock)+1;
	    // 끝 페이지
	    var endPageList=startPageList+pageCntPerBlock-1;
	   
	    // 시작 페이지와 끝페이지가 1보다 작으면 1로 설정
	    // 끝 페이지가 마지막 페이지보다 클 경우 마지막 페이지값으로 설정
	    if(startPageList<1) startPageList=1;
	    if(endPageList>totalPage) endPageList=totalPage;
	    if(endPageList<1) endPageList=1;
	   
	    // 페이징 DIV에 넣어줄 태그 생성변수
	    var pageInner="";
	   
	    // 페이지 리스트가 1이나 데이터가 없을 경우 (링크 빼고 흐린 이미지로 변경)
	    if(pageList<2){
	    }
	    // 이전 페이지 리스트가 있을 경우 (링크넣고 뚜렷한 이미지로 변경)
	    if(pageList>1){
	       
	        pageInner+="<a title=\"first\" href=\"#none\" class=\"ub-control button imgBtn img-pagging-first\"  param=\"\"></a>";
	        pageInner+="<a title=\"prev\" href=\"#none\" class=\"ub-control button imgBtn img-pagging-prev\"  param="+(startPageList-1)+"></a>";
	       
	    }
	    // 페이지 숫자를 찍으며 태그생성 (현재페이지는 강조태그)
	    for(var i=startPageList; i<=endPageList; i++){
	        if(i==pageNum){
	            pageInner = pageInner +"<em param="+(i)+" class='num' >"+(i)+"</em> ";
	        }else{
	            pageInner = pageInner +"<a param="+(i)+" class='num' >"+(i)+"</a> ";
	            
	        }
	       
	    }

	    // 다음 페이지 리스트가 있을 경우
	    if(totalPageList>pageList){
	       
	        pageInner+="<a title=\"next\" href=\"#none\" class=\"ub-control button imgBtn img-pagging-next\"  param="+(i)+"></a>"; 
	        pageInner+="<a title=\"last\" href=\"#none\" class=\"ub-control button imgBtn img-pagging-last\" param="+(totalPage)+"></a>";
	    }
	    // 현재 페이지리스트가 마지막 페이지 리스트일 경우
	    if(totalPageList==pageList){
	    }  
	    // 페이징할 DIV태그에 우선 내용을 비우고 페이징 태그삽입
	    $(".ub-control.pagging[for='"+$jqGrid.attr('id')+"']").empty().append("<span class='total-count'>전체:"+uxl.setComma(totalCount)+"</span>").append(pageInner);
	};
	
    /**
	 * recovery Search Parameter
	 */
	uxl.grid.recoveryParameter = function(pageNumber){
		if($('div.ui-jqgrid').size() > 0){
			var $paging = $('.ub-control.pagging');
			var searchFunction = $paging.attr('function');
			var searchFormId   = $paging.attr('formId');
			var searchForm     = $('#'+ searchFormId);
			
			if(uxl.isNotEmpty(searchFunction)){
				if($('#'+_KEY_PAGE_NUMBER, $(searchForm)).size() == 0){
					uxl.addHidden(searchForm, _KEY_PAGE_NUMBER, pageNumber);
				}else{
					$('#'+_KEY_PAGE_NUMBER, $(searchForm)).val(pageNumber);
				}
				if($('#'+_KEY_PAGE_BLOCK, $(searchForm)).size() == 0){
					uxl.addHidden(searchForm, _KEY_PAGE_BLOCK, parseInt(pageNumber/10, 10));
				}else{
					$('#'+_KEY_PAGE_BLOCK, $(searchForm)).val(parseInt(pageNumber/10, 10));
				}					
				eval(searchFunction+'()');
			}
		}
	};
	
})(jQuery, uxl);


$(document).ready(function(){

	//페이징 이벤트 바인딩
	$('.ub-control.pagging a[param]').live('click', function(event) {
		
		var formName   = $(this).parent().attr('formId');
		var searchForm = $('#'+formName);
		var vfunction = $(this).parent().attr('function');

		if(uxl.isNull(formName)){
			alert('formName 속성이 지정되지 않았습니다. 확인후 다시 실행해 주십시요.');
			return;
		}

		if(uxl.isNull(vfunction)){
			alert('function 속성이 지정되지 않았습니다. 확인후 다시 실행해 주십시요.');
			return;
		}
		
		if(searchForm != null) {
			var params = $(this).attr('param');
			
			if($('#'+_KEY_PAGE_NUMBER, $(searchForm)).size() == 0){
				uxl.addHidden(searchForm, _KEY_PAGE_NUMBER, parseInt(params, 10));
			}else{
				$('#'+_KEY_PAGE_NUMBER, $(searchForm)).val(parseInt(params, 10));
			}
			if($('#'+_KEY_PAGE_BLOCK, $(searchForm)).size() == 0){
				uxl.addHidden(searchForm, _KEY_PAGE_BLOCK, parseInt(params/10, 10));
			}else{
				$('#'+_KEY_PAGE_BLOCK, $(searchForm)).val(parseInt(params/10, 10));
			}
			
			//조회
			if(vfunction != null){
				eval(vfunction+'()');
			}
		}	
	});
	
	
	$('.ui-jqgrid-sortable').click(function(e){
		var tempId = this.id;
		var tempStr = tempId.substring(tempId.indexOf('_') + 1,tempId.length);
		var gridId = tempStr.substring(0,tempStr.indexOf('_'));
		orderColumn = tempStr.substring(tempStr.indexOf('_')+1);
		
		var formName   = $(".ub-control.pagging[for='"+gridId+"']").attr('formId');
		var searchForm = $('#'+formName);
		var vfunction = $(".ub-control.pagging[for='"+gridId+"']").attr('function');
		
		if(orderAsc == 'DESC'){
			orderAsc = 'ASC'; 
		}else{
			orderAsc = 'DESC';
		}
		
		if($('#'+_KEY_PAGE_ORDER_COLUMN).size() == 0){
			uxl.addHidden(searchForm, _KEY_PAGE_ORDER_COLUMN, orderColumn);
		}else{
			$('#'+_KEY_PAGE_ORDER_COLUMN).val(orderColumn);
		}
		
		if($('#'+_KEY_PAGE_ORDER_ASC).size() == 0){
			uxl.addHidden(searchForm, _KEY_PAGE_ORDER_ASC, orderAsc);
		}else{
			$('#'+_KEY_PAGE_ORDER_ASC).val(orderAsc);
		}
		
		//조회
		if(vfunction != null){
			eval(vfunction+'()');
		}
	});
});