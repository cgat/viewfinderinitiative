Fog.credentials_path = Rails.root.join('config/fog_credentials.yml')
fog_dir = if Rails.env == 'production'
  'viewfinderinitiatve.org'
elsif Rails.env == 'development'
  'development.viewfinderinitiative.org'
else
  'development.viewfinderinitiative.org' #'test-bucket'
end
CarrierWave.configure do |config|
  config.fog_credentials = {:provider => 'AWS'}
  config.fog_directory  = fog_dir                    # required
  config.fog_public     = true
end

if Rails.env.test? or Rails.env.cucumber?
  CarrierWave.configure do |config|
    config.storage = :file
    config.enable_processing = false
  end
end
