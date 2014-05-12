function testAlert(name) {
  alert("."+name);
};



if ($(document).has('#chart')) {
  function pieChart() {
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
        allowPointSelect: true,
        type: 'pie',
        name: 'Total',
        data: gon.chart_data,
        point: {
          events: {
            click: function() {
              var select_chart = (this.name).toLowerCase().replace(' ','_')+'-container';
              $('.'+select_chart).toggleClass('hidden');
            }
          }    
        }

      }]

      
    });   
  };
String.prototype.capitalize = function() {
    return this.charAt(0).toUpperCase() + this.slice(1);
}
  function barChart(name) {
    $('.'+name).highcharts({
        data: {
            table: document.getElementById(name)
        },
        chart: {
            type: 'column'
        },
        title: {
            text: name.capitalize().split('-container')[0]
        },
        yAxis: {
            allowDecimals: false,
            title: {
                text: 'Units'
            }
        },
        tooltip: {
            formatter: function() {
                return '<b>'+ this.series.name +'</b><br/>'+
                    this.point.y +' '+ this.point.name.toLowerCase();
            }
        }
    });
  };
}