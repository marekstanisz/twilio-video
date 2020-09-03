require 'twilio-ruby'

class TwilioVideo::CreateRoom
  def initialize
    @account_sid = Rails.application.credentials.twilio[:account_sid]
    @auth_token = Rails.application.credentials.twilio[:auth_token]
  end

  def call
    create_client
    create_room
    room.sid
  end

  private

  attr_reader :client, :room
  attr_reader :account_sid, :auth_token

  def create_client
    @client = Twilio::REST::Client.new(account_sid, auth_token)
  end

  def create_room
    @room = client.video.rooms.create(
      enable_turn: true,
      type: 'peer-to-peer',
      unique_name: 'DailyStandup'
    )
  end
end
