(function($, uxl) {
	/**
	 * HighCharts의 기본 stack bar Chart 옵션
	 */
	uxl.chartOptions = {
			chart: {
                type: 'column'
            },
            title: {
                text: 'Stacked column chart'
            },
            xAxis: {
            	gridLineWidth: -1,
	            lineWidth: 1,
                categories: ['Apples', 'Oranges', 'Pears', 'Grapes', 'Bananas']
            },
            yAxis: {
            	enabled: false,
	            gridLineWidth: 1,
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
                        color: '#CCCCCC'
                    }
                }
            },
            legend: {
                align: 'right',
                x: -100,
                verticalAlign: 'top',
                y: 20,
                floating: true,
                backgroundColor: '#CCCCCC',
                borderColor: '#CCC',
                borderWidth: 1,
                shadow: false
            },
            tooltip: {
                formatter: function() {
                    return '<b>'+ this.x +'</b><br/>'+
                        this.series.name +': '+ this.y +'<br/>'+
                        'Total: '+ this.point.stackTotal;
                }
            },
            plotOptions: {
                column: {
                    stacking: 'normal',
                    dataLabels: {
                        enabled: true,
                        color: (Highcharts.theme && Highcharts.theme.dataLabelsColor) || 'white'
                    }
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