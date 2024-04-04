class StaticPagesController < ApplicationController
  def index
    redirect_to timeline_path if user_signed_in?
  end
end
