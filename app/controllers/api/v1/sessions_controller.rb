class Api::V1::SessionsController < Api::V1::ApplicationController
    before_action :define_current_user, only: :destroy
  def create
    @user = User.find_by(email: params[:email])
    if @user.present? && @user.valid_password?(params[:password])
      @auth_tokan=@user.auth_tokans.build
      @auth_tokan.save 
      render :file => "api/v1/registration/create"
    else
      render_json(:errors => "email or password invalid", :status => 404)
    end 
  end

  def destroy
    @auth_tokan.destroy
    render_json(:success => "signed out", :status => 200)
  end
end