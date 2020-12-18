class SessionsController < ApplicationController
    def new
        @user = User.new
    end

    def create
        user = User.login(params[:user])
    
        if user
            # def self.login(user)  >#這裡的 user=User.login(params[:user])
            #     pw = Digest::SHA1.hexdigest("a#{user[:password]}z")
            #     User.find_by(email: user[:email], password: pw] )
            # end
            
            #發號碼牌，但是有號碼牌不代表已經登入，需要被承認(檢查你手上有沒有票 票的內容)
            # session[:user9527] = params[:user][:email]
            session[:user9527] = user.id

            redirect_to root_path, notice: "登入成功"
        else
            redirect_to sign_up_users_path, notice: "登入失敗"

        end
    end

    def destroy
        session[:user9527] = nil
        redirect_to root_path, notice: "已登出"
    end

    
end
