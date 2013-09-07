Rails.application.config.middleware.use OmniAuth::Builder do
  provider :developer unless Rails.env.production?
  provider :box, AUTH['box']['client_id'], AUTH['box']['client_secret']
end