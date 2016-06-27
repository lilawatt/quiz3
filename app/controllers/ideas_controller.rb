class IdeasController < ApplicationController
  def create
    @idea          = Idea.new answer_params
    @suggestion        = Suggestion.find params[:suggestion_id]
    @idea.suggestion = @idea
    if @idea.save
      redirect_to suggestion_path(@suggestion), notice: "Idea created!"
    else
      render "/suggestions/show"
    end
  end

  def destroy
  suggestion = Suggestion.find params[:suggestion_id]
    idea   = Idea.find params[:id]
    idea.destroy
    redirect_to suggestion_path(suggestion), notice: "Idea deleted"
  end

  private

  def answer_params
    params.require(:idea).permit(:body)
  end
end
