require 'sinatra/base'
require 'sinatra-initializers'
require './temperature'
require "sinatra/config_file"

class App < Sinatra::Base
  register Sinatra::Initializers

  get '/' do
    temp = Temperature.new.get
    "<p>This is <i>dynamic</i> content: #{temp}"
  end




end
