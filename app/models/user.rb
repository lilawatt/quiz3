class User < ActiveRecord::Base
  has_secure_password

  has_many :suggstions, dependent: :nullify

  has_many :likes, dependent: :destroy
  has_many :liked_suggestions, through: :likes, source: :suggestion

  has_many :memberships, dependent: :destroy
  has_many :membershipped_suggestions, through: :memberships, source: :suggestion

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true,
                    uniqueness: true,
                    format: /\A([\w+\-]\.?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i

  def full_name
    "#{first_name} #{last_name}"
  end

end
