require 'sinatra/base'
require './temperature'

class App < Sinatra::Base
  get '/' do
    temp = Temperature.new.get
    "<p>This is <i>dynamic</i> content: #{temp}"
  end
end
