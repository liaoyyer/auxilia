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
            text: 'Current Ticket Totals'
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
            name: 'resolved',
            data: gon.monthly_resolved_activity
        }



        ]


        




        
    });











    $('#total_tickets').html(gon.total_tickets)
    $('#resolved_tickets').html(gon.resolved_tickets)
    $('#avg_initial_response_time').html(gon.avg_initial_response_time)
    $('#avg_resolution_time').html(gon.avg_resolution_time)





 











 $('#admin_bar_chart_container').highcharts({
        chart: {
            type: 'bar'
        },
        title: {
            text: 'Tickets Resolved by Admin'
        },
        xAxis: {
            categories: gon.admins,
            title: {
                text: 'Admins by ID'
            }        
        },
        yAxis: {
            min: 0,
            title: {
                text: 'Resolved Tickets',
                align: 'high'
            },
            labels: {
                overflow: 'justify'
            }

        },
        plotOptions: {
           bar: {
                dataLabels: {
                    enabled: true
                }
            }
        },
        legend: {
            enabled: false,
            layout: 'vertical',
            align: 'right',
            verticalAlign: 'top',
            x: -40,
            y: 80,
            floating: true,
            borderWidth: 1,
            backgroundColor: ((Highcharts.theme && Highcharts.theme.legendBackgroundColor) || '#FFFFFF'),
            shadow: true
        },
        



        series: [{
            name: "Tickets resolved",
            colorByPoint: true,
            data: gon.admin_counts
        }],




});












 $('#admin_resolution_times_bar_chart_container').highcharts({
        chart: {
            type: 'bar'
        },
        title: {
            text: 'Average Resolution Times by Admin'
        },
        xAxis: {
            categories: gon.admins,
            title: {
                text: 'Admins by ID'
            }        
        },
        yAxis: {
            min: 0,
            title: {
                text: 'Resolution Time (hours)',
                align: 'high'
            },
            labels: {
                overflow: 'justify'
            }

        },
        plotOptions: {
           bar: {
                dataLabels: {
                    enabled: true
                }
            }
        },
        legend: {
            enabled: false,
            layout: 'vertical',
            align: 'right',
            verticalAlign: 'top',
            x: -40,
            y: 80,
            floating: true,
            borderWidth: 1,
            backgroundColor: ((Highcharts.theme && Highcharts.theme.legendBackgroundColor) || '#FFFFFF'),
            shadow: true
        },
        



        series: [{
            name: "Resolution Times",
            colorByPoint: true,
            data: gon.avg_admin_resolution_times
        }],




});



























    $('#polar_chart_container').highcharts({

        chart: {
            polar: true
        },

        title: {
            text: 'Highcharts Polar Chart'
        },

  
        
        pane: {
            size: '80%'
        },
        
        xAxis: {
            categories: gon.admins,
            tickmarkPlacement: 'on',
            lineWidth: 0
        },
            
        yAxis: {
            gridLineInterpolation: 'polygon',
            lineWidth: 0,
            min: 0
        },




        series: [{
            type: 'area',
            name: 'Area',
            data: gon.admin_counts
        }]
    });
































});
























