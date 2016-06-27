class Suggestion < ActiveRecord::Base
  has_many :ideas, dependent: :destroy
  belongs_to :user

  has_many :likes, dependent: :destroy
  has_many :liking_users, through: :likes, source: :user

  has_many :members, dependent: :destroy
  has_many :members_users, through: :members, source: :user

  validates(:title, {presence: {message: "must be present!"}, uniqueness: true})

  validates :body, presence:   true,           length:     {minimum: 7},                 uniqueness: {scope: :title}

  validates :view_count, numericality: {greater_than_or_equal_to: 0}

  def self.recent(count)
    where("created_at > ?", 2.day.ago).limit(count)
  end

  def self.search(word)
    where("title ILIKE :word OR body ILIKE :word", {word: "%#{word}%"})
  end
  def new_first_ideas
    ideas.order(created_at: :desc)
  end

  def liked_by?(user)
    likes.exists?(user: user)
  end

  def like_for(user)
    likes.find_by_user_id user
  end

  def member_of?(user)
    members.exists?(user: user)
  end

  private

  def cap_title
    self.title = title.capitalize if title
  end

  def squeeze_title_and_body
    self.title.squeeze!(" ") if title
    self.body.squeeze!(" ") if body
  end
end
