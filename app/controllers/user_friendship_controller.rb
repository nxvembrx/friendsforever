# frozen_string_literal: true

class UserFriendshipController < ApplicationController
  before_action :set_friendship, only: %i[destroy create]

  def create
    return unless current_user.invite(@friend)

    redirect_to "/#{@friend.username}", notice: 'Invited successfully'
  end

  def destroy
    if current_user.unfriend(@friend)
      redirect_to "/#{@friend.username}", notice: 'Unfriended successfully'
    else
      redirect_to "/#{@friend.username}", notice: 'Failed to unfriend'
    end
  end

  private

  def set_friendship
    @friend = User.find(params[:id])
  end
end
