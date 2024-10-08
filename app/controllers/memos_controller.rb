class MemosController < ApplicationController
  before_action :authenticate_user!
  before_action :set_memo, only: %i[show edit update destroy bookmark unbookmark]

  layout 'authorized'

  # GET /memos or /memos.json
  def index
    @memos = Memo.all.reverse
  end

  # GET /memos/new
  def new
    @memo = Memo.new
  end

  def bookmark
    if @memo.bookmark(current_user)
      respond_to do |format|
        format.html { redirect_to memos_path(@memo), notice: 'Memo bookmarked successfully.' }
        format.turbo_stream do
          render 'bookmark', content_type: Mime[:turbo_stream]
        end
      end
    else
      flash[:alert] = 'Failed to bookmark memo.'
    end
  end

  def unbookmark
    if @memo.unbookmark(current_user)
      respond_to do |format|
        format.html { redirect_to memos_path(@memo), notice: 'Memo unbookmarked.' }
        format.turbo_stream do
          render 'bookmark', content_type: Mime[:turbo_stream]
        end
      end
    else
      flash[:alert] = 'Failed to bookmark memo.'
    end
  end

  # POST /memos or /memos.json
  def create
    @memo = Memo.new(memo_params)
    @memo.user_id = current_user.id

    respond_to do |format|
      if @memo.save
        format.html { redirect_to timeline_path, notice: 'Memo was successfully created.' }
        # format.json { render :show, status: :created, location: @memo }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @memo.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /memos/1 or /memos/1.json
  def update
    respond_to do |format|
      if @memo.update(memo_params)
        format.html { redirect_to memo_url(@memo), notice: 'Memo was successfully updated.' }
        format.json { render :show, status: :ok, location: @memo }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @memo.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /memos/1 or /memos/1.json
  def destroy
    @memo.destroy

    respond_to do |format|
      format.html { redirect_to memos_url, notice: 'Memo was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_memo
    @memo = Memo.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def memo_params
    params.fetch(:memo, {}).permit(:body)
  end
end
