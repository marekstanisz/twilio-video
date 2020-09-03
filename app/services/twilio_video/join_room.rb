require 'twilio-ruby'

class TwilioVideo::JoinRoom
  def initialize
    @account_sid = Rails.application.credentials.twilio[:account_sid]
    @auth_token = Rails.application.credentials.twilio[:auth_token]
    @api_key_sid = Rails.application.credentials.twilio[:api_key_sid]
    @api_key_secret = Rails.application.credentials.twilio[:api_key_secret]
  end

  def call
    create_token
    grant_access
    token
  end

  private

  attr_reader :token, :grant
  attr_reader :account_sid, :auth_token, :api_key_sid, :api_key_secret

  def create_token
    @token = Twilio::JWT::AccessToken.new(ACCOUNT_SID, API_KEY_SID, API_KEY_SECRET, ttl: 3600, identity: 'example-user')
  end

  def grant_access
    @grant = Twilio::JWT::AccessToken::VideoGrant.new
    grant.room = 'cool room'
    token.add_grant grant
  end

  def serialize_token
    token.to_jwt
  end
end
