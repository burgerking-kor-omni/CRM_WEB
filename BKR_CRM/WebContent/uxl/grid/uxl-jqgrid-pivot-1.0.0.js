(function($, uxl) {
	
	/**
	 * @class jqgrid-pivot version 1.0.0 module<br/>
	 * @author 류기태
	 *  1.0.0 : uxl.pivotgrid 초기 기능 구현
	 */
	
	var optionsList = {};
	
	/**
	 * @param {element} jquery's selector or table's id 
	 * @param {options} custom options
	 * @param {pivotOptions} pivot custom options
	 * @param {data} pivot data
	 */
	uxl.grid.pivot = function(element, options, pivotOptions, data){
		
		$this = this;
		
		if(data.length == 0){
			uxl.error('PivotGrid data is undefined');
			return false;
		}

		var gridId = uxl.isString(element)? element : $('#'+element).attr('id');
		var grid = $('#gbox_' + gridId);
		if(uxl.isNotNull(grid)){
			var parentDiv = grid.parent();
			grid.remove();
			parentDiv.append('<table class="ub-control grid" id="'+gridId+'" name="'+gridId+'"></table> ');
		}
		
		$jqGrid = uxl.isString(element)? $('#'+element) : element;
		
		// default options
		options = $.extend({
			id : gridId,
			height:261
		}, options || {});
		
		optionsList[options.id] = options;
		
		$jqGrid.jqGrid('jqPivot', data, pivotOptions, options);
		
		$(window).resize(function(){
			var $jqGridPanel = $jqGrid.parents().find('.ui-jqgrid.ui-widget');
			$jqGridPanel.width('auto');
			
			$('.ui-jqgrid-view', $jqGridPanel).width('auto');
			$('.ui-jqgrid-hdiv', $jqGridPanel).width('auto');
			$('.ui-jqgrid-bdiv', $jqGridPanel).width('auto');
			$jqGrid.setGridWidth('auto', true);

	    }).trigger('resize');
	};
	
})(jQuery, uxl);

$(document).ready(function(){

});