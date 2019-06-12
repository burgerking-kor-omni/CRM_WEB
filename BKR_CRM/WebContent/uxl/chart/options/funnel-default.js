(function($, uxl) {
	/**
	 * HighCharts의 기본 funnel Chart 옵션
	 */
	uxl.chartOptions = {
			chart: {
	            type: 'funnel',
	            marginRight: 100
	        },
	        title: {
	            text: 'Sales funnel',
	            x: -50
	        },
	        plotOptions: {
	            series: {
	                dataLabels: {
	                    enabled: true,
	                    format: '<b>{point.name}</b> ({point.y:,.0f})',
	                    color: 'black',
	                    softConnector: true
	                },
	                neckWidth: '30%',
	                neckHeight: '25%'
	                
	                //-- Other available options
	                // height: pixels or percent
	                // width: pixels or percent
	            }
	        },
	        legend: {
	            enabled: false,
	            backgroundColor: '#CCCCCC'
	        },
	        series: [{
	            name: 'Unique users',
	            data: [
	                ['Website visits',   15654],
	                ['Downloads',       4064],
	                ['Requested price list', 1987],
	                ['Invoice sent',    976],
	                ['Finalized',    846]
	            ]
	        }]
	};
})(jQuery, uxl);