# encoding: utf-8

namespace :atualizar_projetos do
	task :start => :environment do
		AtualizarProjetos.new.perform
	end
end