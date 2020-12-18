class BoardPolicy < ApplicationPolicy
  def hide?
    user && user.role == 'bm' && record.user == user
    # 邏輯閘 前面成立 後面才會繼續判斷，不然user.role，如果user=nil就會跳錯
  end

  def lock?
    hide?
  end

  def open?
    hide?
  end
  
  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
