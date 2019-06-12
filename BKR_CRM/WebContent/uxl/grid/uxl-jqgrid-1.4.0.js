(function($, uxl) {
	
	/**
	 * @class jqgrid version 1.2.0 module<br/>
	 * @author 류기태
	 *  
	 *  1.4.0 : 1) EditableCell ClassName 추가 (시각적인 효과 표시를 위함)
	 *  
	 *  1.3.0 : 1) 이전검색조건 셋팅시 첫페이지로 이동하는 버그 (IE8)
	 *          2) uxl.grid.init 함수의 input:hidden 컨트롤 초기화 버그 수정(IE8)
	 *  1.2.0 : APMD에 있는 PageSize와 그리드옵션의 rowNum 값 Sync 처리 추가
	 *          초기 options에서 설정한 값은 데이터 조회후 무시됨.
	 *  1.1.0 : SortColumn sortable:false에는 정렬이 되지 않게 수정
	 *          ubPlugins 기능 도입 (redmine 정리)
	 *           - multiselect.disableByCondition - 조건에따른 체크박스 비활성화 기능 
	 *           - multiselect.onlyOneCheck - 체크박스 하나만 선택가능하도록 하는 기능
	 *           - footerSum - 그리드 목록 데이터의 합계를 풋터에 나타내는 기능 (2015-06-19)
	 *          optionsList에 option을 추가하는 부분을 grid excute 하기 전으로 수정 (2015-05-18)
	 *           - excute중 optionsList를 참조하는 부분이 존재하여, 후에 option을 추가시 undefined error 발생
	 *        
	 *  1.0.0 : 초기 기능 구현
	 */
	
	var optionsList = {};
	
	/**
	 * @param {element} jquery's selector or table's id 
	 * @param {options} custom options
	 * @param {pagerFlag} check whether making navigation is true or not
	 */
	uxl.grid= function(element, options) {
		$this = this;
		
		// making jqgrid object
		$('.ub-control.temp').remove();
		
		$jqGrid = uxl.isString(element)? $('#'+element) : element;

		// default options
		options = $.extend({
			id : $jqGrid.attr('id'),
			optionsOrg:options,
			datatype:"local",
			viewrecords:true,
			sortable:true,
			rowNum:"10",
			scroll:true,
			height:"261px",
			multiselect : false,
			footerrow : false,
			cellEdit: false,
			ubPlugins:{}
		}, options || {});

		// 정의된 ubPlugin init
		uxl.grid.plugin.footerSum.init(options);
		uxl.grid.plugin.multiselect.onlyOneCheck.init(options);
		uxl.grid.plugin.multiselect.disableByCondition.init(options);

		// event binding
		options = $.extend(options, {
			onCellSelect:function(rowid, iCol, cellContent, e){
				var result = true;
				//disableByCondition 플러그인 조회 및 적용
				if(uxl.grid.plugin.multiselect.disableByCondition.checkPlugin.call(this)){
					result = uxl.grid.plugin.multiselect.disableByCondition.onCellSelect.call(this, rowid, iCol, cellContent, e);
				}
				
				//원본 option event 호출
				if(result && uxl.isNotNull(options.optionsOrg.onCellSelect)){
					options.optionsOrg.onCellSelect.call(this, rowid, iCol, cellContent, e);
				}
			},
			afterInsertRow : function(rowid, rowdata, rowelem){

				//editable 플러그인 조회 및 적용
				if(uxl.grid.plugin.cell.editable.checkPlugin.call(this)){
					uxl.grid.plugin.cell.editable.afterInsertRow.call(this, rowid, rowdata, rowelem);
				}
				
				//disableByCondition 플러그인 조회 및 적용
				if(uxl.grid.plugin.multiselect.disableByCondition.checkPlugin.call(this)){
					uxl.grid.plugin.multiselect.disableByCondition.afterInsertRow.call(this, rowid, rowdata, rowelem);
				}
				
				//원본 option event 호출
				if(uxl.isNotNull(options.optionsOrg.afterInsertRow)){
					options.optionsOrg.afterInsertRow.call(this, rowid, rowdata, rowelem);
				}
			},
			onSelectAll : function(aRowids, status){
				//disableByCondition 플러그인 조회 및 적용
				if(uxl.grid.plugin.multiselect.disableByCondition.checkPlugin.call(this)){
					uxl.grid.plugin.multiselect.disableByCondition.onSelectAll.call(this, aRowids, status);
				}
				
				//onlyOneCheck 플로그인 조회 및 적용
				if(uxl.grid.plugin.multiselect.onlyOneCheck.checkPlugin.call(this)){
					uxl.grid.plugin.multiselect.onlyOneCheck.onSelectAll.call(this, aRowids, status);
				}
				
				//원본 option event 호출
				if(uxl.isNotNull(options.optionsOrg.onSelectAll)){
					options.optionsOrg.onSelectAll.call(this, aRowids, status);
				}
			},
			onSelectRow:function(rowid, status, e){
				//onlyOneCheck 플로그인 조회 및 적용
				if(uxl.grid.plugin.multiselect.onlyOneCheck.checkPlugin.call(this)){
					uxl.grid.plugin.multiselect.onlyOneCheck.onSelectRow.call(this, rowid, status, e);
				}
				
				//원본 option event 호출
				if(uxl.isNotNull(options.optionsOrg.onSelectRow)){
					options.optionsOrg.onSelectRow.call(this, rowid, status, e);
				}
			},
			onSortCol:function(index,iCol,sortorder){
				uxl.grid.sortColumn(options.id, index, iCol, sortorder);
			},
			gridComplete:function(){
				//footerSum 플러그인 조회 및 적용
				if(uxl.grid.plugin.footerSum.checkPlugin.call(this)){
					uxl.grid.plugin.footerSum.gridComplete.call(this);
				}
				
				//원본 option event 호출
				if(uxl.isNotNull(options.optionsOrg.gridComplete)){
					options.optionsOrg.gridComplete.call(this);
				}
			}
		});
		// 그리드가 완료되기 전에 optionsList를 참조하는 부분이 생길 경우가 있으므로 그리드 생성 전으로 위치 변경
		optionsList[options.id] = options;
		// excuting jqgrid!
		$jqGrid.jqGrid(options);
		
		// recovery PageNumber
		if(uxl.isNotNull(uxl.pageNumber)){
			uxl.grid.recoveryParameter(uxl.pageNumber);
		}
		
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
		$('#'+_KEY_PAGE_NUMBER , $form).val(''); 
		$('#'+_KEY_PAGE_BLOCK , $form).val('');
		$('#'+_KEY_PAGE_ORDER_COLUMN , $form).val('');
		$('#'+_KEY_PAGE_ORDER_ASC , $form).val('');
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
		
		//[1.2.0] 그리드 옵션의 rowNum을 서비스의 pageSize로 바꿔준다.
		if(pageSize > 0){
			$jqGrid.jqGrid('setGridParam', {rowNum:pageSize});
		}
		
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
	
	
	uxl.grid.sortColumn = function(gridId,index,iCol,sortorder){
		var formName   = $(".ub-control.pagging[for='"+gridId+"']").attr('formId');
		var searchForm = $('#'+formName);
		var vfunction = $(".ub-control.pagging[for='"+gridId+"']").attr('function');

		// orderColumn은 이전 검색된 컬럼정렬의 값이 들어 있으므로
		// 현재 orderColumn과 index를 비교하여 컬럼이 같은 컬럼의 정렬여부를 체크한다.
		if(orderColumn == index){
			if(orderAsc == 'DESC'){
				orderAsc = 'ASC'; 
			}else{
				orderAsc = 'DESC';
			}
		}else{
			orderAsc = 'ASC'; 
		}

		// 최종 변경된 index 값을 orderColumn에 반영한다.
		orderColumn = index;		

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
	};
	
	uxl.grid.plugin = {
		multiselect : {
			disableByCondition : {
				init : function(options){
					 if(uxl.isNotNull(options.ubPlugins.multiselect)){
						 if(uxl.isNotNull(options.ubPlugins.multiselect.disableByCondition)){
							 options.multiselect = true;
						 }
					 }
				}
				, checkPlugin : function(){
					var options = optionsList[$(this).attr('id')];
					var returnValue = false;
					if(options.multiselect != true){
						return false;
					}
					if(uxl.isNotNull(options.optionsOrg.ubPlugins)){
						if(uxl.isNotNull(options.optionsOrg.ubPlugins.multiselect)){
							if(uxl.isNotNull(options.optionsOrg.ubPlugins.multiselect.disableByCondition)){
								if(uxl.isFunction(options.optionsOrg.ubPlugins.multiselect.disableByCondition.condition)){
									returnValue = true;
								}
							}
						}
					}
					return returnValue;
				}
				, onCellSelect : function(rowid, iCol, cellContent, e){
					if(iCol == 0){
						//체크박스가 disabled 이면 선택하지 않음
						var ckbDis = $('tr#'+rowid+".jqgrow > td > input.cbox:disabled", $(this));
						if(ckbDis.length != 0){
							$(this).setSelection(rowid, false);
						}
						return false;
					}else{
						$(this).setSelection(rowid, false);
						return true;
					}
				}
				,afterInsertRow : function(rowid, rowdata, rowelem){
					//로우가 생성될 때 마다 조건을 체크하여 리턴값이 true면 disabled 처리
					var options = optionsList[$(this).attr('id')].optionsOrg;
					var result = options.ubPlugins.multiselect.disableByCondition.condition.call(this, $(this).getRowData(rowid)); 
					if(result){
						var checkbox = $('#jqg_'+$(this).attr('id')+'_'+rowid);
						checkbox.attr('disabled', true).attr('readonly','readonly');
					}
				}
				,onSelectAll : function(aRowids, status){
					//체크박스 전체선택 클릭 시 비활성화 체크박스 필터링
					if(status){
						var ckb = $('tr.jqgrow > td > input.cbox:disabled', $(this));
						ckb.removeAttr('checked');
						
						//선택된 로우값 치환
						var checkedRows = $.find('tr.jqgrow:has(td > input.cbox:checked)');
						var newSelarrrow = new Array();
						for(var i = 0 ; i < checkedRows.length ; i++){
							newSelarrrow.push(checkedRows[i].id);
						}
						$(this)[0].p.selarrrow = newSelarrrow;
						
						//체크되지 않은 로우 속성 변경
						var unCheckedRows = $.find('tr.jqgrow:has(td > input.cbox:disabled)');
						for(var i = 0 ; i < unCheckedRows.length ; i ++){
							$(unCheckedRows[i]).attr('aria-selected', 'false').removeClass('ui-state-highlight');
						}
					}
				}
			}
			, onlyOneCheck : {
				init : function(options){
					 if(uxl.isNotNull(options.ubPlugins.multiselect)){
						 if(uxl.isNotNull(options.ubPlugins.multiselect.onlyOneCheck)){
							 options.multiselect = true;
						 }
					 }
				}
				, checkPlugin : function(){
					var options = optionsList[$(this).attr('id')];
					var returnValue = false;
					if(options.multiselect != true){
						return false;
					}
					if(uxl.isNotNull(options.optionsOrg.ubPlugins)){
						if(uxl.isNotNull(options.optionsOrg.ubPlugins.multiselect)){
							if(uxl.isNotNull(options.optionsOrg.ubPlugins.multiselect.onlyOneCheck)
									&& options.optionsOrg.ubPlugins.multiselect.onlyOneCheck == true){
								returnValue = true;								
							}
						}
					}
					return returnValue;
				}
				, onSelectRow : function(rowid, status, e){
					if($('#jqg_'+$(this).attr('id')+'_'+rowid).is(":checked")){
		    			$(this).resetSelection();
				    	$(this).setSelection(rowid, false);
					}
				}
				, onSelectAll : function(aRowids, status){
					$(this).resetSelection();
				}
			}
		}
		, footerSum : {
			 init : function(options){
				 if(uxl.isNotNull(options.ubPlugins.footerSum)){
					 options.footerrow = true;
				 }
			 }
			 , checkPlugin : function(){
				var options = optionsList[$(this).attr('id')];
				var returnValue = false;
				if(options.footerrow != true){
					return false;
				}
				if(uxl.isNotNull(options.optionsOrg.ubPlugins)){
					if(uxl.isNotNull(options.optionsOrg.ubPlugins.footerSum)){
						returnValue = true;
					}
				}
				return returnValue;
			}
			, gridComplete : function(){
				var gridId = $(this).attr('id');
				var options = optionsList[gridId];
				var pluginData = options.optionsOrg.ubPlugins.footerSum;
				
				var colSums = new Array(pluginData.sumColumns.length);
				for(var z = 0 ; z < pluginData.sumColumns.length ; z++){
					var colName = pluginData.sumColumns[z];
					colSums[z] = $('#' + gridId).jqGrid('getCol', colName, false, 'sum');
					var dataStr = '{"' + colName + '":"' + colSums[z] + '"}';
					var data = JSON.parse(dataStr);
					$('#' + gridId).jqGrid('footerData', 'set', data);
				}
				
				var titleColName = $('#' + gridId).jqGrid('getGridParam','colModel')[pluginData.sumTitle.index].name;
				var dataStr = '{"' + titleColName + '":"' + pluginData.sumTitle.title + '"}';
				var data = JSON.parse(dataStr);
				$('#' + gridId).jqGrid('footerData', 'set', data);
			}
		}
		,cell:{
			/**
			 * 수정가능한 Cell에 ub-cell-editable ClassName을 추가하는 PlugIn
			 */
			editable : {
				checkPlugin : function(){
					var options = optionsList[$(this).attr('id')];
					return options.cellEdit;
				}
				, afterInsertRow : function(rowid, rowdata, rowelem){
					var options = optionsList[$(this).attr('id')];
					for(var i=0; i < options.colModel.length; i++){
						var model = options.colModel[i];
						if(uxl.isNotNull(model['editable'])){
							if(typeof(model.editable) == "boolean"){
								if(model.editable){
									var $editCells = $('td[aria-describedby=ResourceList_'+model.name+']:last', $jqGrid);
									$editCells.addClass("ub-cell-editable");
								}
							}
						}
					}
				}
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
});