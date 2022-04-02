require 'byebug'

class TasksController < ApplicationController
    protect_from_forgery except: :new
  before_action :set_task, only: [:edit, :update, :destroy]


  def index
    if (params[:task_name] || params[:tag_id] || params[:importt] || params[:start_date] || params[:end_date] )

      @task_task_name = Task.where("title ILIKE ?", "%#{params[:task_name]}%")

      case params[:importt]
      when 'tres' then @task_importance = Task.where(importance: 3)


      end
      # @task_importance = Task.where(importance: params[:importt]) if  params[:import] =! "No Especificado"

      @task_start_date = Task.where(start_date: params[:start_date] ) if params[:start_date] =! ""

      @task_end_date = Task.where(start_date: params[:end_date]) if params[:end_date] =! ""

      unless @task_task_name.nil?
        @tasks = @task_task_name
        unless @task_importance.nil?
          @tasks= @task_importance
        end
      end
      @tasks = @task_importance
      # raise
      @tasks = Task.where(user_id: current_user.id) if @tasks.nil?
      @tasks.uniq
    else
      @tasks = Task.where(user_id: current_user.id)
    end

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
        Labelled.create(task_id: @task.id)
        Labelled.create(task_id: @task.id)
        Labelled.create(task_id: @task.id)
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

  def search

  end

  private
  def task_params

    params.require(:task).permit(:title, :description, :importance, :start_date, :end_date)
  end

  def set_task
      @task = Task.find(params[:id])
  end
end
