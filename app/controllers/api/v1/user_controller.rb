class Api::V1::UserController < Api::V1::ApplicationController
  before_action :define_current_user
  

  def profile
    render :file => "api/v1/registration/create"    
  end

  def update
    #logger.warn("================#{params[:photo]}")
    #@user.photo_upload(params[:photo])
    if @user.update_attributes(user_params)
      render_json(:message => "profile update", :status => 200)
    else
      render_json(:errors => @user.errors.full_messages, :status => 404)
    end
  end

  private
  def user_params   
    params.require(:user).permit(:email,:password,:password_confirmation,:first_name,:last_name,:phone_number,:city,:state,:country,:device_id,:device_type)
  end
end 