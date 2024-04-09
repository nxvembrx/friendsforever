# frozen_string_literal: true

class BookmarksController < ApplicationController
  before_action :authenticate_user!

  layout 'authorized'

  def index
    @bookmarked = current_user.bookmarked_memos.reverse
  end

  private

  def bookmark_params
    params.require(:bookmark).permit(:memo_id, :user_id)
  end
end
