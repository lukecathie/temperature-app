require './app'
namespace :temperature do
  task :log do
    p TemperatureLog.record_now
  end
end