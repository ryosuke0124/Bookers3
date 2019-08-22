class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :books, dependent: :destroy

  attachment :profile_image

  #以下を追加
  validates :name, presence: true, uniqueness: true, length: {minimum: 2,maximum: 20}
  validates :email, presence: true
  validates :introduction, length: { maximum: 50 }
  #登録時にメールアドレスを不要とする
  def email_required?
    false
  end
end
