class Api::V1::RegistrationController < Api::V1::ApplicationController
 
  def create
 
    @user = User.new(user_params)
    unless @user.save
      # respond_to do |format|
      #   format.html
      #   format.json{render json: @user}
      # end
     
      #render_json(:messages => "User saved", :status => 200)

      render_json(:errors => @user.errors.full_messages, :status => 404)
    else
      @auth_tokan=@user.auth_tokans.build
      @auth_tokan.save
    end

  end

  private
  def user_params   
    params.require(:user).permit(:email,:password,:password_confirmation,:first_name,:last_name,:phone_number,:city,:state,:country,:device_id,:device_type)
  end
 
end
