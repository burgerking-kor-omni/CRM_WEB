(function($, uxl) {
	/**
	 * HighCharts의 기본 Line Chart 옵션
	 */
	uxl.chartOptions = {
			chart: {
                type: 'line'
            },
            title: {
                text: '',
            },
            credits: {
                enabled: false
            },
            exporting: {
                enabled: false
            },
            xAxis: {
            	gridLineWidth: -1,
            	gridLineColor: '#EAEAEA',
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
	            gridLineColor : '#EAEAEA',
	            lineWidth: -1,
	            min: 0,
	            title: {
	                text: '',
	                margin: 0
	            },
	            labels: {
	                enabled: false
	            }
            },
            tooltip: {
                valueSuffix: '°C'
            },
            legend : {
            	padding : 5,
            	borderRadius: 0,
	            itemMarginTop: 0,
	            itemMarginBottom: -11,
		        itemStyle: {
				         font: '8pt Trebuchet MS, NanumGothic, sans-serif',
				         color: '#5A5A5A',
				         lineHeight: '4px'

			    },
			    symbolPadding: 10,
	            symbolWidth: 10,
	            verticalAlign : 'bottom',
	            y : 14
	         },
            series: [{
                name: 'Tokyo',
                data: [7.0, 6.9, 9.5, 14.5, 18.2, 21.5, 25.2, 26.5, 23.3, 18.3, 13.9, 9.6]
            }, {
                name: 'New York',
                data: [-0.2, 0.8, 5.7, 11.3, 17.0, 22.0, 24.8, 24.1, 20.1, 14.1, 8.6, 2.5]
            }, {
                name: 'Berlin',
                data: [-0.9, 0.6, 3.5, 8.4, 13.5, 17.0, 18.6, 17.9, 14.3, 9.0, 3.9, 1.0]
            }, {
                name: 'London',
                data: [3.9, 4.2, 5.7, 8.5, 11.9, 15.2, 17.0, 16.6, 14.2, 10.3, 6.6, 4.8]
            }]			
	};
})(jQuery, uxl);