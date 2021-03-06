require 'twilio-ruby'

class TwilioVideo::JoinRoom
  def initialize(identity, room_name)
    @account_sid = Rails.application.credentials.twilio[:account_sid]
    @auth_token = Rails.application.credentials.twilio[:auth_token]
    @api_key_sid = Rails.application.credentials.twilio[:api_key_sid]
    @api_key_secret = Rails.application.credentials.twilio[:api_key_secret]
    @identity = identity
    @room_name = room_name
  end

  def call
    create_token
    grant_access
    token
  end

  private

  attr_reader :token, :grant, :identity, :room_name
  attr_reader :account_sid, :auth_token, :api_key_sid, :api_key_secret

  def create_token
    @token = Twilio::JWT::AccessToken.new(account_sid, api_key_sid, api_key_sid, ttl: 3600, identity: identity)
  end

  def grant_access
    @grant = Twilio::JWT::AccessToken::VideoGrant.new
    grant.room = room_name
    token.add_grant(grant)
  end

  def serialize_token
    token.to_jwt
  end
end
