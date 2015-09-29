# bootstrap tooltips are used throughout the application

jQuery  ->
	$('a[rel~="tooltip"]').tooltip()
	$('a.navtip').tooltip({placement: "bottom", trigger: "hover"})