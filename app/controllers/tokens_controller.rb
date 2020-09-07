class TokensController < ApplicationController
  def show
    render html: TwilioVideo::JoinRoom.new(params[:identity], params[:room_name]).call, status: :ok
  end
end
