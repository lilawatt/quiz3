class LikesController < ApplicationController

  before_action :authenticate_user!

  def index
    @suggstions = current_user.liked_suggestions
  end

  def create
    suggestion = Suggestion.find params[:suggestion_id]
    l        = Like.new(suggetsion: suggetsion, user: current_user) unless can? :manage, @suggestion, notice: "Calm down, bro. We know you like your own suggestions."
    if l.save
      redirect_to suggestion_path(suggestion), notice: "We like that you like this!"
    else
      redirect_to suggestion_path(suggestion), alert: "Liked already."
    end
  end

  def destroy
    like     = Like.find params[:id]
    suggestion = Suggestion.find params[:suggestion_id]
    like.destroy if can? :destroy, Like
    redirect_to suggestion_path(suggestion), notice: "Un-liked"
  end

end
