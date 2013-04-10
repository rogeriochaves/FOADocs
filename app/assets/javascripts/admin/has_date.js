jQuery(function($){
  $.datepicker.regional['pt-BR'] = {
    closeText: 'Fechar',
    prevText: '&#x3c;Anterior',
    nextText: 'Pr&oacute;ximo&#x3e;',
    currentText: 'Hoje',
    monthNames: ['Janeiro','Fevereiro','Mar&ccedil;o','Abril','Maio','Junho',
    'Julho','Agosto','Setembro','Outubro','Novembro','Dezembro'],
    monthNamesShort: ['Jan','Fev','Mar','Abr','Mai','Jun',
    'Jul','Ago','Set','Out','Nov','Dez'],
    dayNames: ['Domingo','Segunda-feira','Ter&ccedil;a-feira','Quarta-feira','Quinta-feira','Sexta-feira','Sabado'],
    dayNamesShort: ['Dom','Seg','Ter','Qua','Qui','Sex','Sab'],
    dayNamesMin: ['Dom','Seg','Ter','Qua','Qui','Sex','Sab'],
    weekHeader: 'Sm',
    dateFormat: 'dd/mm/yy',
    firstDay: 0,
    isRTL: false,
    showMonthAfterYear: false,
    yearSuffix: ''};
  $.datepicker.setDefaults($.datepicker.regional['pt-BR']);
});

$.datepicker.setDefaults({changeYear: true, changeMonth: true, minDate:new Date(1930, 1 - 1, 1)});
var afterLoad = function(){
  jQuery.datepicker.dpDiv.appendTo( jQuery('body') );
  $('.has_date').datepicker("destroy").datepicker($.datepicker.regional['pt-BR']);
}

$(document).ready(afterLoad);
document.addEventListener("page:load", afterLoad);