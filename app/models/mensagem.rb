# encoding: utf-8
class Mensagem < ActiveRecord::Base
  validates_presence_of :nome, :email, :telefone, :mensagem, :message => "não pode ser vazio"
  validates_format_of :email, :with => /\A([^\s]+)((?:[-a-z0-9]\.)[a-z]{2,})([a-z ])?\z/i, :message => "é inválido"
  validates_length_of :mensagem, :within => 0..5000
end