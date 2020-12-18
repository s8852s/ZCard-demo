class RegistrationsController < ApplicationController
    
    
    def new
        @user = User.new
    end

    def create 
        @user = User.new(user_params)

        if @user.save
            redirect_to root_path, notice: "ok"
        else
            render :new
            # render "1223/123" :new 如果在不同資料夾
        end
    end

    def edit 
    #   @user = User
    end

    def update
      if current_user.update(user_params)
        redirect_to edit_users_path, notice: "資料更新成功"
      else
      end
    end

    private
    def user_params
        params.require(:user).permit(:email, :password, :password_confirmation, :nickname)
    end

    
    
end
