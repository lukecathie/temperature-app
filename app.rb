require 'sinatra/base'
require 'sinatra-initializers'
require './temperature'
require './temperature_log'
require 'sinatra/config_file'
require 'data_mapper'
require 'time'

class App < Sinatra::Base
  register Sinatra::Initializers

  get '/' do
    temp = Temperature.new.get
    TemperatureLog.record_now
    @logs = {}
    TemperatureLog.all(order: [:time.asc], limit: 100).each do |log|
      @logs[log.time.strftime('%Y-%m-%d%-I:%M%p')] = log
      @last = log
    end
    erb :chart
  end
end
