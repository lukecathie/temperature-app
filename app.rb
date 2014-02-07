require 'sinatra/base'
require 'sinatra-initializers'
require './temperature'
require './temperature_log'
require 'sinatra/config_file'
require 'data_mapper'
require 'time'
require 'json'


class App < Sinatra::Base
  register Sinatra::Initializers

  get '/' do
    temp = Temperature.new.get
    TemperatureLog.record_now
    @logs = {}
    TemperatureLog.all(order: [:time.desc], limit: 100).each do |log|
      @logs[log.time.strftime('%Y%m%d%H%M')] = log
      @last = log
    end
    @logs = @logs.sort_by{|time,_|time}
    erb :chart
  end

  get '/temperature.json' do
    content_type :json
    log = TemperatureLog.record_now
    { temperature: log.temperature, time: log.time }.to_json
  end
end
