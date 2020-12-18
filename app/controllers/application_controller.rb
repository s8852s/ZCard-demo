class ApplicationController < ActionController::Base
  include CartsHelper
  include SessionsHelper
  include Pundit
    rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  
    private
    def record_not_found
      render file: 'public/404.html',
             layout: false,
             status: :not_found
    end

    def session_required
      redirect_to sign_in_users_path, notice: "請先登入會員" if not user_signed_in?
      # before_action :session_required, only[:edit, :update]
      #如果開無痕 session=nil會跳錯
    end
  end
  