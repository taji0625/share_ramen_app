require 'carrierwave/storage/abstract'
require 'carrierwave/storage/file'
require 'carrierwave/storage/fog'

CarrierWave.configure do |config|
  if Rails.env.production?
    config.storage = :fog
    config.fog_provider = 'fog/aws'
    config.fog_directory  = 'share-ramen-app-for-bucket'
    config.asset_host = 'https://s3-ap-northeast-1.amazonaws.com/share-ramen-app-for-bucket'
    config.fog_credentials = {
      provider: 'AWS',
      aws_access_key_id: ENV["AWS_ACCESS_KEY_ID"],
      aws_secret_access_key: ENV["AWS_SECRET_ACCESS_KEY"],
      region: 'ap-northeast-1'
    }
  else
    config.storage :file
    config.enable_processing = false if Rails.env.test?
  end  

end