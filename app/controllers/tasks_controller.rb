require 'byebug'

class TasksController < ApplicationController
    protect_from_forgery except: :new

  def index
    @tasks = Task.where(user_id: current_user.id)
  end
  def show
  end
  def new
    @task = Task.new
    respond_to do |format|
      format.js
    end
  end
  def create
    @task = Task.new(task_params)
    @task.user=current_user
    respond_to do |format|
      if @task.save
        format.json { head :no_content }
        format.js
      else
        format.json { render json: @task.errors.full_messages, status: :unprocessable_entity }
        format.js { render :new }
      end
    end
  end
  def edit

  end
  def update

  end
  def destroy

  end

  private
  def task_params

    params.require(:task).permit(:title, :description, :importance)
  end

end
