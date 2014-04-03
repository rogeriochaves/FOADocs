# encoding: utf-8

namespace :atualizar_projetos do
	task :start => :environment do
		Projeto.all.each do |projeto|
			AtualizarProjetos.new.perform(projeto)
		end
	end
end