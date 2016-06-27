class SuggestionsController < ApplicationController

  before_action :find_suggestion, only: [:show, :update, :destroy]
  before_action :authenticate_user!, except: [:show, :index]
  before_action :authorize_owner, only: [:edit, :destroy,:update]

def new
  @suggestion = Sugggestion.new
end

def create
  @suggestion = Sugggestion.new suggestion_params
  @suggestion.user = current_user
    if @suggestion.save
      redirect_to suggestion_path(@suggestion), notice: "Thanks for the suggestion!"
    else
      flash[:alert] = "Come again now?"
      render :new
    end
  end

def show
  @suggestion.increment!(:view_count)
  @idea = Idea.new
end

def index
  @suggestions = Suggestion.order(created_at: :desc)
end

def update
  if @suggestion.update suggestion_params
    redirect_to suggestion_path(@suggestion), notice: "your suggestion has been updated"
  else
    render :edit
  end
end

def destroy
  @suggestion.destroy
  redirect_to suggestion_path, notice: "Suggestion rescinded"
end

private

def suggestion_params
  params.require(:suggestion).permit(:title, :body)
end

def find_suggestion
  @suggestion = Suggestion.find params[:id]
end

def authorize_owner
  redirect_to root_path, alert: "You shall not pass!" unless can? :manage, @suggestion
end
