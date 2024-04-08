class ProfilesController < ApplicationController
  before_action :set_profile

  layout 'authorized'

  # PATCH/PUT /profiles/1 or /profiles/1.json
  def update
    if @profile.user.eql?(current_user)
      respond_to do |format|
        if @profile.update(profile_params)
          format.html { redirect_to user_path(@profile.user.username), notice: 'Profile was successfully updated.' }
        else
          format.html { render :edit, status: :unprocessable_entity }
        end
      end
    else
      format.html { render :edit, status: :unprocessable_entity }
    end
  end

  private

  def set_profile
    @profile = current_user.profile
  end

  def profile_params
    params.require(:profile).permit(:user_id, :display_name, :location, :website, :pronouns, :bio, :birthday, :profile_picture, :banner_picture)
  end
end
