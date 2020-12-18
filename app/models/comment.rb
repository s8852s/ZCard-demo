class Comment < ApplicationRecord
  acts_as_paranoid

  belongs_to :user
  belongs_to :post
  validates :content, presence: true

  
  default_scope { order(id: :desc) }
  # default_scope { where(deleted_at: nil) }
  # default_scope預設過濾器，就算進console查詢也會強制套用，除非用.unscope()
  # 平常少用

  def owned_by?(user)
    self.user == user
  end
  # def destroy
  #   update(deleted_at: Time.now)
  # end
end

# model
# scope :cheap, -> { where("price < 50") }
# scope :forb, -> { where("age >= 18") }
# scope :x, -> { cheap.forb }

# controller
# Product.forb.cheap
# Product.x

