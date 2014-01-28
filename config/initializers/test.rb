
config_file_path = File.expand_path('../../config.yml', __FILE__)
if File.exists?(config_file_path)
    config = YAML.load(File.read(config_file_path))
    config.each do |key, value|
      ENV[key] = value unless value.kind_of? Hash
    end
end
