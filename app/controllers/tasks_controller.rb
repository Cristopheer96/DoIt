require 'byebug'

class TasksController < ApplicationController
    protect_from_forgery except: :new
  before_action :set_task, only: [:edit, :update, :destroy]


  def index
    if (params[:task_name] || params[:tag_id] || params[:importt] || params[:start_date] || params[:end_date] )

      @task_user = current_user.tasks
      @tasks = @task_user.where(importance: 10) #<ActiveRecord::Relation []> Para que arroje este tipo de dato  no funciona  ActiveRecord::Relation
      @task_task_name = @task_user.where("title ILIKE ?", "%#{params[:task_name]}%")
      case params[:importt]
      when 'tres' then @task_importance = @task_user.where(importance: 3)
      when 'dos' then @task_importance = @task_user.where(importance: 2)
      when 'uno' then @task_importance = @task_user.where(importance: 1)
      when 'cuatro' then @task_importance = @task_user.where(importance: 4)
      when 'cinco' then  @task_importance = @task_user.where(importance: 5)
      else
        @task_importance = @task_user.where(importance: 10)
      end
      @task_start_date = @task_user.where(start_date: params[:start_date])
      @task_start_date = @task_user.where(importance: 10) if @task_start_date.nil?
      @task_end_date = @task_user.where(start_date: params[:end_date])
      @task_end_date = @task_user.where(importance: 10) if @task_end_date.nil?

      @tasks = @task_task_name + @task_importance + @task_start_date + @task_end_date
      @tasks = @task_user.where(user_id: current_user.id) if @tasks.nil?
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

  def search_tasks(userio,task_name,tag_id,importt,start_date )
        if (params[:task_name] || params[:tag_id] || params[:importt] || params[:start_date] || params[:end_date] )

  end

end
