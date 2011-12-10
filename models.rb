require 'rubygems'
require 'bundler/setup'

Bundler.require

DataMapper::Logger.new($stdout, :debug)

DataMapper.setup(:default, ENV['DATABASE_URL']||"sqlite3://#{Dir.pwd}/db/camara.sqlite3")


class Deputado
  include DataMapper::Resource

  property :id,         Serial
  property :idParlamentar,  Integer, :key => true
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
