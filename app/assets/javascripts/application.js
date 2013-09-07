// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require bootstrap
//= not_require rails.validations
//= require google_analytics
//= require turbolinks
//= require jquery.turbolinks
//= require_tree ./fancybox
//= require_tree ./parallax
//= require_self

/*

$("[rel=fancybox]").fancybox({
	openEffect: 'elastic',
	closeEffect: 'elastic',
	helpers: {title: {type: 'outside'}}
});

*/

$('#nuvens-rodape').show();
var scene = document.getElementById('nuvens-rodape');
var parallax = new Parallax(scene);

$(document).ready(function(){
	$('.box-login').delay(500).animate({bottom: "50%"}, 2000, function(){
		$('.logo').fadeIn();
	});
	$('.btn-login').click(function(){
		$('.nuvem-girar').addClass('girar');
		$(this).fadeOut();
	});

	$('#usuario_password').keyup(function(){
		if ($(this).val().length > 0) {
			$('.nuvem-login input[type=submit]').fadeIn();
		}
	});

	$('.frm-login').submit(function(){
		$('.box-login').animate({bottom: "120%"}, 1000);
		$('#nuvens-rodape').animate({top: "100%"}, 1000);
		$('body').delay(500).fadeOut(1000);

		return false;
	});

	$("h1").lettering();
});