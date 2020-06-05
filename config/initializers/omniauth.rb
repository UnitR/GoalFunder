Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, '232486544531879', '1936a373495719aa636fc991d8a49cb0'
end