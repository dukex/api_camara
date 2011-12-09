require 'rubygems'
require 'bundler/setup'


Bundler.require()

DataMapper.setup(:default, ENV['DATABASE_URL']||"sqlite3://#{Dir.pwd}/db/camara.sqlite3")

class Deputado
  include DataMapper::Resource

  property :id,         Serial
  property :nome,       String
  property :nomeParlamentar, String
  property :sexo, String
  property :uf, String
  property :partido, String
  property :gabinete, String
  property :anexo, String
  property :fone, String
  property :email, String
end

DataMapper.auto_upgrade!

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
