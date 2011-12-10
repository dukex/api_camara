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
    options = {:exclude => :id}
    case format
      when 'csv'
        content_type :csv
        resource.to_csv
      when 'xml'
        content_type :xml
        resource.to_xml options
      else
        content_type :json
        resource.to_json options
    end
  end
end
