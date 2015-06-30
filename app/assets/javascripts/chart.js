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
            color: '#333333',
            connectorColor: '#333333',
            format: '<b>{point.name}</b>: {point.percentage:.2f} %'
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
            click: function(event) {
              $(window).resize();
              var chart_class = (this.name).toLowerCase().replace(' ','_')+'-container';
              //gets valid class name. ie 'Task 1' = 'task_1-container'
              //$('#render-chart').removeClass();
              
              //$('#render-chart').toggleClass(chart_class);

              
              //event.PreventDefault();
              //barChart(name);
              $('.bar_chart').hide();
              $('.'+chart_class).fadeIn();
            }
          }    
        }
      }]     
    });   
  };

  function barChart(name) { 
    $('.'+name).highcharts({
        data: {
          table: document.getElementById(name)
        },
        chart: {
          type: 'column',
        },
        legend: {
          enabled: false
        },
        title: {
          text: 'Total Errors for Category '+name.capitalize().replace('_',' ').split('-container')[0]
          //Removes class formatting
        },
        yAxis: {
          allowDecimals: false,
          title: {
            text: 'Units'
          }
        },
        tooltip: {
          formatter: function() {
            return '<b>'+ this.point.name +'</b><br/>'+
              'Total: '+this.point.y+'<br/>';

            }
        }
    });
  };
}