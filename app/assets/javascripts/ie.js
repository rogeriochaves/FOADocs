//= require respond/respond.min
//= require placeholder

(function(){
	var onLoad = function(){
		$("[placeholder]").textPlaceholder();
	}
	$(window).load(onLoad);
	$(document).ready(onLoad);
	setTimeout(onLoad, 3000);
})();