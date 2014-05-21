if Rails.env.production?
  CONFIG = YAML.load_file(File.expand_path("/home/deploy/cfktracker/shared/config/config.yml"))[Rails.env]
else
  CONFIG = YAML.load_file(File.expand_path("config/config.yml"))[Rails.env]
end
