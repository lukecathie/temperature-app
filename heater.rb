class Heater
  def initialize
    # @filelocation = ENV['temperature_file_path']
    @wemo_name = ENV['wemo_name']
    # @target_temp = ENV['target_temp'].to_f
  end

  def switch_on
    `wemo switch "#{@wemo_name}" on`
  end


  def switch_off
    `wemo switch "#{@wemo_name}" off`
  end
end