if(typeof App.all == 'undefined') App.all = {};

App.all.index = function() {
	var lista = $('table#lista')
	  , headers = {};
	headers[lista.find('th').length - 1] = {sorter: false};

	var sortList = [[0, 0]];
	if(typeof lista.attr('sort-list') != 'undefined'){
		sortList = eval(lista.attr('sort-list'));
		lista.tablesorter({
			sortList: sortList,
			headers: headers
		});
	}else{
		lista.tablesorter();
	}

	lista.find('td').click(function(){
		var link = $(this).parent().find('td:last a:first');
		if(link.length > 0) window.location = link.attr('href');
	});
};