if Rails.env.production?
  CONFIG = YAML.load_file(File.expand_path("/home/deploy/cfktracker/shared/config/config.yml"))[Rails.env]
elsif Rails.env.test?
  CONFIG = YAML.load_file(File.expand_path("config/sample.config.yml"))[Rails.env]
else
  CONFIG = YAML.load_file(File.expand_path("config/config.yml"))[Rails.env]
end
