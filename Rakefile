require 'rubygems'
require 'bundler/setup'

Bundler.require

$:.unshift(File.expand_path(File.dirname(__FILE__)))

require 'models'
require 'open-uri'

desc "Get deputados"
task :deputados do

  data = open("http://www.camara.gov.br/sitcamaraws/deputados.asmx/ObterDeputados", "User-Agent"=> "I am Mozilla Firefox Lady").read

  Crack::XML.parse(data)["deputados"]["deputado"].each do |deputado|
    puts "deputado #{deputado["nome"]}"


    Deputado.create :idParlamentar => deputado["idParlamentar"],
      :nome => deputado["nome"],
      :nomeParlamentar => deputado["nomeParlamentar"],
      :sexo => deputado["sexo"],
      :uf => deputado["uf"],
      :partido => deputado["partido"],
      :gabinete => deputado["gabinete"],
      :anexo => deputado["anexo"],
      :fone => deputado["fone"],
      :email => deputado["email"]
  end


end
