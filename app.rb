require 'rubygems'
require 'sinatra/base'
require 'open-uri'
require 'nokogiri'
require 'crack' # for xml and json
require 'json'

class CamaraApp < Sinatra::Base

  get '/deputados.:format'  do
    get_deputados(params[:format])
  end

  get '/deputados/:id.:format' do
    deputados = Nokogiri::XML get_deputados('xml')
  end

  def get_deputados(format)
    deputados = open("http://www.camara.gov.br/sitcamaraws/deputados.asmx/ObterDeputados", "User-Agent"=> "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_7_2) AppleWebKit/535.2 (KHTML, like Gecko) Chrome/15.0.874.121 Safari/535.2").read
    if format == "json"
      content_type :json
      ::JSON.generate Crack::XML.parse(deputados)
    elsif format == "xml"
      content_type :xml
      deputados
    end
  end
end
