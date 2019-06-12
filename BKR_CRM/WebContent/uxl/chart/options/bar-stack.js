(function($, uxl) {
	/**
	 * HighCharts의 기본 stack bar Chart 옵션
	 */
	uxl.chartOptions = {
			chart: {
                type: 'bar'
            },
            title: {
                text: '',
		         floating: false,
		         y : 0
            },
            credits: {
                enabled: false
            },
            exporting: {
                enabled: false
            },
            xAxis: {
	            lineWidth: 1,
                categories: ['Apples', 'Oranges', 'Pears', 'Grapes', 'Bananas'],
                labels : {
	            	style : {
	            		color : '#9E9E9E',
	            		font : '8pt',
	            		fontWeight : 'bold'
	            	}
	            },
	            lineColor: '#EAEAEA',
	            tickColor : '#EAEAEA'
            },
            yAxis: {
            	enabled: false,
	            gridLineWidth: 1,
	            gridLineColor: '#EAEAEA',
	            lineWidth: -1,
	            min: 0,
	            title: {
	                text: '',
	                margin: 0
	            },
	            labels: {
	                enabled: false
	            },
	            stackLabels: {
                    enabled: true,
                    style: {
                        fontWeight: 'bold',
                        color: '#5F5F5F'
                    }
                }
            },
            legend : {
            	padding : 5,
            	borderRadius: 0,
	            itemMarginTop: 0,
	            itemMarginBottom: -12,
		        itemStyle: {
				         font: '8pt Trebuchet MS, NanumGothic, sans-serif',
				         color: '#5A5A5A',
				         lineHeight: '4px'
			    },
			    symbolPadding: 5,
	            symbolWidth: 5,
	            verticalAlign: 'bottom',
	            y : 16
            },
            plotOptions: {
                series: {
                    stacking: 'normal'
                }
            },
            series: [{
                name: 'John',
                data: [5, 3, 4, 7, 2]
            }, {
                name: 'Jane',
                data: [2, 2, 3, 2, 1]
            }, {
                name: 'Joe',
                data: [3, 4, 4, 2, 5]
            }]
            
			
	};
})(jQuery, uxl);