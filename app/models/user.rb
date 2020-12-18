class User < ApplicationRecord
    # acts_as_paranoid
    include AASM
    # validation----------------------------------------------
    validates :email, presence: true,
                    uniqueness: true,
                    format: { with: /[\w]+@([\w-]+\.)+[\w-]{2,4}/ }
                        
    validates :password, presence: true, 
                    confirmation: true,
                    length: { minimum: 4 }
    validates :nickname, presence: true

    # before_save
    before_create :encrypt_password

    # ----------------------------------------------
    has_many :boards
    has_many :posts
    has_many :comments
    has_many :favorite_posts
    has_many :my_favorites, through: :favorite_posts, source: "post"
    has_many :orders
    # ----------------------------------------------

    def self.login(user)
        pw = Digest::SHA1.hexdigest("a#{user[:password]}z")
        User.find_by(email: user[:email], password: pw )
        # pw = Digest::SHA1.hexdigest("a#{params[:user][:password]}z")
        # User.find_by(email: params[:user][:email], password: pw] )
    end
    # validation----------------------------------------------

    def favorite?(post)
        my_favorites.include?(post)
    end


    aasm column: 'state', no_direct_assignment: true do
        state :user, initial: true
        state :vip, :vvip

        event :pay_vip do
            transitions from: :user, to: :vip
        end
    
        event :pay_vvip do
            transitions from: [:user, :vip], to: :vvip
        end
    end

    private
    def encrypt_password
        self.password = Digest::SHA1.hexdigest("a#{self.password}z")
        # salting撒鹽增加複雜度 如頭尾+字
    end
end
