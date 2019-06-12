(function($, uxl) {
	/**
	 * HighCharts의 기본 bar Chart 옵션
	 */
	uxl.chartOptions = {
			chart: {
                type: 'bar'
            },
            title: {
                text: '',
                floating : false,
                y : 0
            },
            subtitle: {
                text: ''
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
            plotOptions : {
		    	series: {
                    dataLabels: {
                        enabled: true,
                        style: {
                            fontWeight:'bold',
                            color : '#5F5F5F',
                            fontSize : '11px'
                        }
                    }
                }
		    },
            series: [{
                name: 'Year 1800',
                data: [107, 31, 635, 203, 2]
            }, {
                name: 'Year 1900',
                data: [133, 156, 947, 408, 6]
            }, {
                name: 'Year 2008',
                data: [973, 914, 4054, 732, 34]
            }],
            labels : {
            	style : {
            		color : '#5F5F5F',
            		fontSize : '8px'
            	}
            }
	};
})(jQuery, uxl);