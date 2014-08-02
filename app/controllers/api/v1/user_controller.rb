class Api::V1::UserController < Api::V1::ApplicationController
  before_action :define_current_user
  
  def profile
    render :file => "api/v1/registration/create"    
  end

  def update
     #@user.photo_upload(params[:photo])
    if @user.update_attributes(user_params)
      render_json(:message => "You updated your profile successfully.", :status => 200)
    else
      render_json(:errors => @user.display_error, :status => 404)
    end
  end

  private
  def user_params   
    params.require(:user).permit(:email,:password,:password_confirmation,:firstname,:lastname,:phonenumber,:city,:state,:country,:device_id,:device_type)
  end
end 