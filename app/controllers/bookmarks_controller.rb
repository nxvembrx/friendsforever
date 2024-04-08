# frozen_string_literal: true

class BookmarksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_bookmark, only: %i[destroy]

  layout 'authorized'

  def index
    @bookmarked = current_user.bookmarked_memos.reverse
  end

  def create
    @bookmark = current_user.bookmarks.build(memo_id: params[:memo_id])

    respond_to do |_format|
      if @bookmark.save
        flash[:notice] = 'Memo bookmarked successfully.'
      else
        flash[:alert] = 'Failed to bookmark memo.'
      end
    end
  end

  def destroy
    @bookmark.destroy

    respond_to do |_format|
      flash[:notice] = 'Memo un-bookmarked successfully.'
    end
  end

  private

  def set_bookmark
    @bookmark = Bookmark.find(params[:id])
  end

  def bookmark_params
    params.require(:bookmark).permit(:memo_id, :user_id)
  end
end
