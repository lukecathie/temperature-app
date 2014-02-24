require './temperature'
require './heater'

class Thermostat
  def initialize
    @heater = Heater.new
    @temperature = Temperature.new
    @target_temp = ENV['target_temp'].to_f
  end

  def get_current_temperature
    temp = @temperature.get
    adjust_heater(temp)
    temp
  end

  def adjust_heater(temp)
    Heater.new.switch_off if (temp.to_f/1000) >= @target_temp + 0.5
    Heater.new.switch_on if (temp.to_f/1000) <= @target_temp - 0.5
  end

end