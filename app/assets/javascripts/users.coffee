jQuery  ->
	$('a.navtip').tooltip({placement: "bottom", trigger: "hover"})
	$('#user_management_table').DataTable({autoWidth: true; "iDisplayLength": 25; "fnDrawCallback": $('a[rel~="tooltip"]').tooltip() })
