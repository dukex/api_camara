require 'rubygems'
require 'bundler/setup'

Bundler.require

require 'models'

data = File.read("db/deputados.xml")

Crack::XML.parse(data)["deputados"]["deputado"].each do |deputado|
  puts "deputado #{deputado["nome"]}"

  Deputado.create :id => deputado["idParlamentar"],
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
