require 'byebug'

class TasksController < ApplicationController
    protect_from_forgery except: :new
  before_action :set_task, only: [:edit, :update, :destroy]


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
    @task.user = current_user
    respond_to do |format|
      if @task.save
        format.js
      else
        format.json { render json: @task.errors.full_messages, status: :unprocessable_entity }
        format.js { render :new }
      end
    end
  end
  def edit
    respond_to do |format|
      format.js
    end
  end
  def update
    respond_to do |format|
      if @task.update(task_params)
        format.json { head :no_content }
        format.js
      else
        format.json { render json: @task.errors.full_messages, status: :unprocessable_entity }
        format.js { render :edit }
      end
    end
  end
  def destroy
    @task.destroy
    respond_to do |format|
      format.json { head :no_content }
      format.js
    end
  end

  private
  def task_params

    params.require(:task).permit(:title, :description, :importance, :start_date, :end_date)
  end

  def set_task
      @task = Task.find(params[:id])
  end
end
