class RoomsController < ApplicationController
  def new; end

  def create
    render json: { room_sid: TwilioVideo::CreateRoom.new.call }, status: :created
  end

  def show
    render json: { token: TwilioVideo::JoinRoom.new.call }, status: :ok
  end

  def destroy
    TwilioVideo::CompleteRoom.new(params[:room_sid]).call
    head :no_content
  end
end
