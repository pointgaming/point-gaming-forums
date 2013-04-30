class PgUser < ActiveResource::Base
  include ActiveResource::Extend::AuthWithApi

  self.site = "#{APP_CONFIG['main_app_api_url']}api/v1/"
  self.element_name = 'user'

  self.api_key = APP_CONFIG['forum_api_auth_token']
end
