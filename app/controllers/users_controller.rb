class UsersController < ApplicationController

  before_action :authenticate_user!

  layout 'authorized'
  def show
    @user = User.find_by_username(params[:username])
  end
end