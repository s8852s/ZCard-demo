module SessionsHelper
    def current_user
      if session[:user9527].present?
        @user9487 ||= User.find_by(id: session[:user9527])
        # session的key通常會比較複雜 避免重複產生衝突
        # @user ||= User.find_by(email: session[:user9527])
        # 用號碼牌上的資訊(email)去資料庫把暱稱撈出來
        # ||=的意思等同於a += 1 / a = a + 1，沒有@user就執行後面的撈資料，撈完存到@user裡，下次執行此方法就不用再去撈，=紀錄用的工具人變數。但僅限於在同一頁時不用重複撈，若換頁還是需要再撈一次，因為HTTP沒有狀態
        #注意變數名稱重複可能出錯
      else
        nil
        # 如果session[:user9527]存在，去撈暱稱，如果不存在，回傳nil
      end
    end

    def user_signed_in?
      #跟current_user的差別是回傳的東西不一樣  user_sign_in?只回傳T or F
      if current_user
        return true
      else
        return false
      end

    end

    # def session_required
      # redirect_to sign_in_user_path, notice: "請先登入會員" if not user_signed_in?
      # before_action :session_required, only[:edit, :update]
      #如果開無痕 session=nil會跳錯
    # end

end
