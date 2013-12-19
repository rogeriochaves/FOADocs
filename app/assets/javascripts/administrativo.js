// This is a manifest file that'll be compiled into including all the files listed below.
// Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
// be included in the compiled file accessible from http://example.com/assets/application.js
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
//= require jquery
//= require jquery_ujs
//= require jquery-ui
//= require_tree ./admin
//= require bootstrap
//= require jquery_nested_form
//= require turbolinks
//= require jquery.turbolinks
//= require select2
//= require nprogress
//= not_require rails.validations
//= not_require rails.validations.simple_form
//= require_self

var afterLoad = function(){
  $('select.select2').select2();
  $('input[type=submit]').click(function(){
  	NProgress.start();
  });
}

$(document).ready(afterLoad);
document.addEventListener('page:load', afterLoad);
document.addEventListener('page:fetch',   function() { NProgress.start(); });
document.addEventListener('page:change',  function() { NProgress.done(); });
document.addEventListener('page:restore', function() { NProgress.remove(); });