jQuery(function(){






    $('#pie_chart_container').highcharts({





        chart: {
            plotBackgroundColor: null,
            plotBorderWidth: null,
            plotShadow: false,
            type: 'pie'
        },
        title: {
            text: 'Ticket Categories'
        },
        tooltip: {
            pointFormat: '{series.name}: <b>{point.percentage:.1f}%</b>'
        },
        plotOptions: {
            pie: {
                    allowPointSelect: true,
                    cursor: 'pointer',
                    dataLabels: {
                        enabled: false,
                        format: '<b>{point.name}</b>: {point.percentage:.1f} %',
                        style: {
                                    color: (Highcharts.theme && Highcharts.theme.contrastTextColor) || 'black'
                                }
                    },


                    showInLegend: true

            }
        },
        series: [{
            name: "Category",
            colorByPoint: true,
            data: gon.category_data
        }]
    });



















 $('#bar_chart_container').highcharts({
        chart: {
            type: 'column'
        },
        title: {
            text: 'Current Ticket Data'
        },
        xAxis: {
            type: 'category'
        },
        yAxis: {
            title: {
                text: 'Tickets'
            }

        },
        legend: {
            enabled: false
        },
        plotOptions: {
            series: {
                borderWidth: 0,
                dataLabels: {
                    enabled: true
                }
            }
        },

        tooltip: {
            headerFormat: '<span style="font-size:11px">{series.name}</span><br>',
            pointFormat: '<span style="color:{point.color}">{point.name}</span>: <b>{point.y}</b> tickets<br/>'
        },

        series: [{
            name: "Ticket Status",
            colorByPoint: true,
            data: gon.status_data
        }],




});

















$('#area_chart_container').highcharts({
        chart: {
            type: 'area'
        },
        title: {
            text: 'Monthly Ticket Activity For The Past Year',
            x: -20 //center
        },
        xAxis: {
            categories: gon.month_interval
        },
        yAxis: {
            title: {
                text: 'Tickets'
            },
        },

        tooltip: {
            pointFormat: '<b>{point.y:,.0f}</b> tickets {series.name}'
        },




        plotOptions: {
            area: {
                marker: {
                    enabled: false,
                    symbol: 'circle',
                    radius: 2,
                    states: {
                        hover: {
                            enabled: true
                        }
                    }
                }
            }
        },

        series: 
        [


        {
            name: 'created',
            data: gon.monthly_created_activity
        }, {
            name: 'closed',
            data: gon.monthly_closed_activity
        }



        ]


        




        
    });











    $('#total_tickets').html(gon.total_tickets)
    $('#closed_tickets').html(gon.closed_tickets)
    $('#avg_response_time').html(gon.avg_response_time)










        alert(gon.month_interval);





});
























