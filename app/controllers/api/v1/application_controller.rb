class Api::V1::ApplicationController < ActionController::Base
  rescue_from ActionController::RoutingError,:with => :bad_record
  rescue_from ActiveRecord::RecordNotFound, :with => :bad_record
  #protect_from_forgery with: :null_session, if: Proc.new { |c| c.request.format == 'application/json' }
  #skip_before_filter :verify_authenticity_token, :if => Proc.new { |c| c.request.format == 'application/json' }

  protected

  def render_json(json)
    callback = params[:callback]
    response = begin
      if callback
        "#{callback}(#{json});"
      else
        json
      end
    end
    render({:content_type => :js, :text => response})
  end

  def bad_record
    render_json({:errors => "No Record Found!", :status => 404}.to_json)
  end


  def define_current_user
    @auth_tokan =AuthTokan.find_by(tokan: params[:authentication_token])
    if @auth_tokan.present?
      @user = User.find(@auth_tokan.user_id)
      unless @user.present? 
        render_json(:errors => "User did not find with this authy token", :status => 404)
      end
    else
      render_json(:errors => "invalid AuthTokan", :status => 404)
    end
  end
end 