class Temperature
  def initialize
    @filelocation = ENV['temperature_file_path']
  end

  def get
    fetch_value
  end

  def fetch_value
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

end