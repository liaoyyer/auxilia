# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


jQuery  ->
	myvalues = [10, 8, 5, 7, 4, 3]		
	$('#resolution_time_sparkline').sparkline(myvalues, {type: 'line', lineColor: 'red', fillColor: '#ffe5e5', spotColor: '', minSpotColor: '', maxSpotColor: '', width: '40px', height: '30px', lineWidth: '3'} )