require 'twilio-ruby'

class TwilioVideo::CompleteRoom
  def initialize(room_sid)
    @account_sid = Rails.application.credentials.twilio[:account_sid]
    @auth_token = Rails.application.credentials.twilio[:auth_token]
    @room_sid = room_sid
  end

  def call
    create_client
    complete_room
  end

  private

  attr_reader :client, :room_sid
  attr_reader :account_sid, :auth_token

  def create_client
    @client = Twilio::REST::Client.new(account_sid, auth_token)
  end

  def complete_room
    client.video.rooms(room_sid).update(status: 'completed')
  end
end
