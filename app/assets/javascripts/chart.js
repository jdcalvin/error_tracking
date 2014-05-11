if ($(document).has('#chart')) {
function pieChart() {
    $('#chart').highcharts({
      chart: {
        plotBackgroundColor: null,
        plotBorderWidth: null,
        plotShadow: false
      },
//ok
      title: {
        text: 'Errors by Category'
      },
//ok
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
//ok
      series: [{
        type: 'pie',
        name: 'Total',
        data: gon.chart_data  
      }]

    });   
  };
  }