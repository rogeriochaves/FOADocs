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
//= require jquery_ujs
//= require jquery-ui
//= require bootstrap
//= require rails.validations
//= require google_analytics
//= not_require turbolinks
//= not_require jquery.turbolinks
//= require nprogress
//= not_require_tree ./fancybox
//= require_tree ./parallax
//= require handlebars
//= require_self

var scene = document.getElementById('nuvens-rodape');
if(scene){
	$('#nuvens-rodape').show();
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

		$('.frm-login').submit(function(e){
			e.preventDefault();

			NProgress.start();
			$.post('/_login', $('.frm-login').serialize(), function(data){
				if(data == "ok"){
					NProgress.done();
					$('.box-login').animate({bottom: "120%"}, 1000);
					$('#nuvens-rodape').animate({top: "100%"}, 1000);
					$('body').delay(500).fadeOut(1000);
					setTimeout(function(){
						window.location = '/';
					}, 1200);
				}else{
					NProgress.done();
					$('.nuvem-girar').effect('shake');
					$('.frm-login input[type=submit]').val("Login ou Senha inválidos");
				}
			});
		});
	});
}

$(".select-projetos").change(function(){
	window.location = $(this).val();
});

$(".comentario-textarea").keydown(function(e){
	if (e.keyCode == 13){
        if (e.shiftKey) {
            //$(this).val($(this).val() + "\n");
        }else{
        	var params = $(this).closest("form").serialize();
        	var self = $(this);
        	self.attr("disabled", "disabled");
            $.post("_comentar", params, function(data){
            	if(data == "error"){
            		alert("Erro ao salvar comentário");
            	}else{
            		var comentario = self.val().replace(/\n/g, "<br />");
            		var source   = $("#comentarios-template").html();
					var template = Handlebars.compile(source);
					var html     = template({nome: current_usuario.nome, image: current_usuario.image, comentario: comentario, id: data});
					self.val("");
					self.removeAttr("disabled");
					self.closest(".comentario-novo").before(html);
					self.focus();
            	}
            });
        }
    }
});
$(document).ready(function(){
	$('body').delegate('.excluirComentario', 'click', function(){
		$.post("_excluir_comentario", {id: $(this).data("id") }, function(data){
			// callback
		}).error(function(){
			alert("Erro ao excluir comentário");
		});
	});
	$('#renomearArquivoModal').modal('hide');
});

$(".checkall").change(function(){
	var self = $(this);
	setTimeout(function(){
		if(self.is(":checked")){
			$("input[type='checkbox']:not(.checkall)").prop('checked', true);
		}else{
			$("input[type='checkbox']:not(.checkall)").prop('checked', false);
		}
	}, 4);
});

$('#excluirArquivos').click(function(){
		$('.arquivoCheck:checked').each(function() {
			$.post('_excluir_arquivo', {fileId: $(this).attr('data-fileId')});
			location.reload();
		});
});
$('#renomearArquivo').click(function() {
	$('#renomearArquivoModal').modal('show');
	$('#arquivoAntigo').text($('.arquivoCheck:checked').parent().parent().text());

});

