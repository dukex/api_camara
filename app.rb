require 'rubygems'
require 'bundler/setup'

Bundler.require

require 'models'


class CamaraApp < Sinatra::Base
  get '/deputados.?:format?'  do
    format = params.delete("format")
    @deputados = Deputado.all(params)
    output @deputados, format
  end

  get '/deputados/:id.:format' do
    format = params.delete("format")
    @deputado = Deputado.first(:idParlamentar => params[:id])
    output @deputado, format
  end

  def output(resource, format)
    case format
      when 'csv'
        content_type :csv
        resource.to_csv
      when 'xml'
        content_type :xml
        resource.to_xml
      else
        content_type :json
        resource.to_json
    end
  end
end
