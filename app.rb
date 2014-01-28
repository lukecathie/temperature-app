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
    last = TemperatureLog.last
    # log = TemperatureLog.record_now
    # "<p>This is <i>dynamic</i> content: #{temp}"
    @logs = TemperatureLog.last(100)
    erb :chart
  end
end
