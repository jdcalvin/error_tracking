$(function () {
    $('#chart').highcharts({
        chart: {
            plotBackgroundColor: null,
            plotBorderWidth: null,
            plotShadow: false

        },
        title: {
            text: 'Errors by Category'
        },

        plotOptions: {
            pie: {
                allowPointSelect: true,
                cursor: 'pointer',
                dataLabels: {
                    enabled: true,
                    color: '#000000',
                    connectorColor: '#000000',
                    format: '<b>{point.name}</b>: {point.percentage:.1f} %'
                }
            }

        },
        series: [{
            type: 'pie',
            name: 'Browser share',
            data: gon.chart_data
            
        }]
    });   
});
    