require './temperature_log'

class Temperature
  def initialize
    @filelocation = ENV['temperature_file_path']
    @target_temp = ENV['target_temp'].to_f
  end

  def get
    # if last.time - 
    current
  end

  def last
    TemperatureLog.all(order: [:time.desc], limit: 1).first
  end

  def current
    last_recorded = last
    if last_recorded.time < 45.seconds.ago
      p '== fetching...'
      if ENV['environment'] == 'development'
        temp = value_random
      else
        temp = value_from_modprobe
      end
      TemperatureLog.create(temperature: temp, time: Time.now)
    else
      p '== using last value...'
    end
    temp
  end

  def self.recent_temperatures(limit: 50)
    TemperatureLog.all(order: [:time.desc], limit: limit)
  end

private
  def value_from_modprobe  
    if ENV['run_modprobe'] == 'yes'
      `sudo modprobe w1-gpio`
      `sudo modprobe w1-therm`
    end
    return unless !Dir.glob(@filelocation).empty?
    line = `tail -n 1 #{@filelocation}`
    return if line.empty?
    temp_str = line.split('=',2).last
    temp_str.to_i
  end

  def value_random
    (13000..19000).to_a.sample
  end

end