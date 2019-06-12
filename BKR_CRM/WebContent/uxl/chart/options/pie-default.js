(function($, uxl) {
	/**
	 * HighCharts의 기본 pie Chart 옵션
	 */
	uxl.chartOptions = {
			 chart: {
	                type: 'pie',
	                plotBackgroundColor: null,
	                plotBorderWidth: null,
	                plotShadow: false
	            },
	            title: {
	                text: '',
					floating : false,
					y : 0
	            },
	            credits: {
	                enabled: false
	            },
	            exporting: {
	                enabled: false
	            },
	            xAxis : {
	            	labels :{
	            		style :{
	            			font : '8pt Trebuchet MS, NanumGothic, sans-serif',
	            			color : '#9D9D9D'
	            		}
	            	}
	            },
	            tooltip: {
	        	    pointFormat: '{series.name}: <b>{point.percentage}%</b>',
	            	percentageDecimals: 1
	            },
	            plotOptions: {
	                pie: {
	                    allowPointSelect: true,
	                    cursor: 'pointer',
	                    dataLabels: {
	                        enabled: true,
	                        color: '#000000',
	                        connectorColor: '#000000',
	                        formatter: function() {
	                            return '<b>'+ this.point.name +'</b>: '+ this.percentage +' %';
	                        }
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
	            series: [{
	                name: 'Browser share',
	                data: [
	                    ['Firefox',   45.0],
	                    ['IE',       26.8],
	                    {
	                        name: 'Chrome',
	                        y: 12.8,
	                        sliced: true,
	                        selected: true
	                    },
	                    ['Safari',    8.5],
	                    ['Opera',     6.2],
	                    ['Others',   0.7]
	                ]
	            }]		
	};
})(jQuery, uxl);