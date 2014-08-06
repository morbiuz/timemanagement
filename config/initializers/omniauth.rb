Rails.application.config.middleware.use OmniAuth::Builder do
  provider :developer unless Rails.env.production?
  provider :twitter, 'Gx0nM6cCRj5Y5VVgXBIEImi2t', 'zkvFWn5mvxr18LuGKBdI33KHdCKZ6tZCKAzVvCOKNlpzgIfvrc'
  provider :facebook, '1458084611117134', 'fc47c1c6d3fd14a2dabc28424ee04d61'
end


