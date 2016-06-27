class Idea < ActiveRecord::Base
  belongs_to :suggestion
  validates :body, presence: true, uniqueness: {scope: :suggestion_id}
end
