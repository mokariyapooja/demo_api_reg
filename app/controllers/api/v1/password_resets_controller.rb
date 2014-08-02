class Api::V1::PasswordResetsController < Api::V1::ApplicationController
  before_action :define_current_user, only: :change_password

  #forgot_password
  def create
    @user = User.find_by(email: params[:email])
     if @user.present? 
        if @user.send_reset_password_instructions
          render_json(:message => "You will receive an email with instructions about how to reset your password in a few minutes.", :status => 200)
        else
          render_json(:errors => @user.display_error, :status => 404)
        end
      else
        render_json(:errors => "No user found with this email", :status => 404)
      end
  end
  
  def change_password 
    if @user.update_with_password(change_password_params)
      render_json(:message => "Your password was changed successfully. You are now signed in.", :status => 200)
    else
      render_json(:errors => @user.display_error, :status => 404)
    end
  end

  private
  def change_password_params
    params.require(:user).permit(:current_password,:password,:password_confirmation)
  end
end
