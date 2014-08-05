Rails.application.config.middleware.use OmniAuth::Builder do
  provider :developer unless Rails.env.production?
  provider :twitter, ENV['Gx0nM6cCRj5Y5VVgXBIEImi2t'], ENV['zkvFWn5mvxr18LuGKBdI33KHdCKZ6tZCKAzVvCOKNlpzgIfvrc']
end