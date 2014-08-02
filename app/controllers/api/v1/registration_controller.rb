class Api::V1::RegistrationController < Api::V1::ApplicationController

  def create
    @user = User.new(user_params) 
    #@user.photo_upload(params[:photo])
    unless @user.save 
      render_json(:errors => @user.display_error, :status => 404)
    else
      @auth_tokan = @user.auth_tokans.build
      @auth_tokan.save
    end
  end

  private
  def user_params   
    params.require(:user).permit(:email,:password,:password_confirmation,:firstname,:lastname,:phonenumber,:city,:state,:country,:device_id,:device_type)
  end
end 
 