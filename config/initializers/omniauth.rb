require 'omniauth'
require 'omniauth-saml'
require 'yaml'

#OKTA_CONFIGS = YAML.load(File.read(File.join(Rails.application.config.root,"config", "okta.yml")))


Rails.application.config.middleware.use OmniAuth::Builder do
  provider :saml,
    :issuer                             => "https://enigmatic-beach-7933.herokuapp.com/topics",
    :idp_sso_target_url                 => ENV["idp_sso_target_url"],
    :idp_sso_target_url_runtime_params  => {:redirectUrl => :RelayState},
    :idp_cert_fingerprint               => ENV["idt_cert_fingerprint"],
    :name_identifier_format             => "urn:oasis:names:tc:SAML:1.1:nameid-format:emailAddress"
end
