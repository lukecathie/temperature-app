class Temperature
  def initialize
    @filelocation = '/sys/bus/w1/devices/28-*/w1_slave'
  end

  def get
    fetch_value
  end

  def fetch_value
    return unless !Dir.glob(@filelocation).empty?
    `sudo modprobe w1-gpio`
    `sudo modprobe w1-therm`
    line = `tail -n 1 #{@filelocation}`
    return if line.empty?
    temp_str = line.split('=',2).last
    temp_str.to_i
  end

end