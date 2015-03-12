class CommentsController < ApplicationController
  before_action :find_and_set_project

  def index
    @comments = @task.comments.all
  end

  def new
    @comment = @task.comments.new
  end

  def create
    @comment = @task.comments.new(comment_params)
    @comment.user_id = current_user.id
    if @comment.save
      redirect_to project_task_path(@project, @task)
    else
      flash[:notice] - "Opps, Please try again."
    end
  end


  private

  def comment_params
    params.require(:comment).permit(:message, :user_id, :task_id)
  end

  def find_and_set_project
    @task = Task.find(params[:task_id])
  end

end
