(function($, uxl) {

	uxl.chartOptions = {};
	
	uxl.Chart = function(element, options, callback) {
		
		var $chart = uxl.isString(element)? $('#'+element) : element;

		var initOptions = {
			ubOptionFile : 'line-default'
		};
		
		initOptions = $.extend(initOptions, options);
		
		if($chart.size() == 0){
			alert('차트생성 오류 : ['+element+']에 해당하는 객체가 존재하지 않습니다.');
			return;
		}else{
			if($chart[0].tagName != 'DIV'){
				alert('차트생성 오류 : ['+element+']의 Tag는 DIV만 지원합니다.');
				return;
			}
		}
		
		// default options
		if(uxl.isNotEmpty(initOptions.ubOptionFile)){
			jQuery.getScript('/uxl/chart/options/'+initOptions.ubOptionFile+'.js', function(script, textStatus, jqXHR){
				uxl.chartOptions = $.extend(uxl.chartOptions, options || {});
				$chart.highcharts(uxl.chartOptions, callback);
			});
		}else{
			$chart.highcharts(initOptions, callback);
		}
	};
	
})(jQuery, uxl);