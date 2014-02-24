require 'sinatra/base'
require 'sinatra-initializers'
require './temperature'
require './thermostat'
require './temperature_log'
require 'sinatra/config_file'
require 'data_mapper'
require 'time'
require 'json'
require 'active_support/all'


class App < Sinatra::Base
  register Sinatra::Initializers

  get '/' do
    temp = Thermostat.new.get_current_temperature
    @logs = {}
    Temperature.recent_temperatures.each do |log|
      @logs[log.time.strftime('%Y%m%d%H%M')] = log
      @last ||= log
    end
    @logs = @logs.sort_by{|time,_|time}
    erb :chart
  end

  get '/temperature.json' do
    content_type :json
    last_log = TemperatureLog.all(order: [:time.desc], limit: 1).first
    { temperature: last_log.temperature, time: last_log.time }.to_json
  end
end
