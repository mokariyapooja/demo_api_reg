class Api::V1::PasswordResetsController < Api::V1::ApplicationController

  before_action :define_current_user, only: :change_password
  def create
    @user = User.find_by(email: params[:email])
     if @user.present? 
        if @user.send_reset_password_instructions
          render_json(:message => "mail sent", :status => 200)
        else
          render_json(:errors => @user.errors.full_messages, :status => 404)
        end
      else
        render_json(:errors => " no user found with this email", :status => 404)
      end
  end
  
  def change_password 
    if @user.update_with_password(change_password_params)
      render_json(:message => "password update", :status => 200)
    else
      render_json(:errors => @user.errors.full_messages, :status => 404)
    end
  end

  def change_password_params
    params.require(:user).permit(:current_password,:password,:password_confirmation)
  end
end
