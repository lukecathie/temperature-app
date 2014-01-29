require 'data_mapper' 
DataMapper.setup(:default, "sqlite3://#{Dir.pwd}/#{ENV['env']}.db")

class TemperatureLog
  include DataMapper::Resource
  property :id,           Serial
  property :temperature,  Integer, :required => true
  property :time,         DateTime, :required => true

  def self.record_now
    TemperatureLog.create(temperature: Temperature.new.get, time: Time.now)
  end
end
DataMapper.finalize
DataMapper.auto_upgrade!