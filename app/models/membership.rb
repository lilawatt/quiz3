class Membership < ActiveRecord::Base
  belongs_to :user
  belongs_to :suggestion

  validates :user, uniqueness: {scope: :suggestion}
end
