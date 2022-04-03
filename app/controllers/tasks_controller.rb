require 'byebug'

class TasksController < ApplicationController
    protect_from_forgery except: :new
  before_action :set_task, only: [:edit, :update, :destroy]


  def index


    if (params["/tasks"]  )

      params["/tasks"]["start_date"]
      @task_user = current_user.tasks
      @tasks = @task_user.where(importance: 10) #<ActiveRecord::Relation []> Para que arroje este tipo de dato  no funciona  ActiveRecord::Relation
      @task_task_name = @task_user.where("title ILIKE ?", "%#{params[:task_name]}%")
      case params[:importt]
      when 'tres' then @task_importance = @task_task_name.where(importance: 3)
      when 'dos' then @task_importance = @task_task_name.where(importance: 2)
      when 'uno' then @task_importance = @task_task_name.where(importance: 1)
      when 'cuatro' then @task_importance = @task_task_name.where(importance: 4)
      when 'cinco' then  @task_importance = @task_task_name.where(importance: 5)
      else
        @task_importance = @task_task_name
      end

      @task_start_date = @task_importance.where(start_date: "#{params["/tasks"]["start_date"]} 00:00:00.000000000 +0000")
      # @task_start_date = @task_importance if params["/tasks"]["start_date"] = ""

      @task_end_date = @task_start_date.where(end_date: "#{params["/tasks"]["end_date"] } 00:00:00.000000000 +0000")
      # @task_end_date = @task_start_date if params["/tasks"]["end_date"] = ""
      raise
      @tasks = @task_end_date
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

  def search_tasks(usuario,task_name,tag_id,importt,start_date,end_date )
      # @task_user = usuario.tasks
      # @tasks = @task_user.where(importance: 10) #<ActiveRecord::Relation []> Para que arroje este tipo de dato  no funciona  ActiveRecord::Relation
      # @task_task_name = @task_user.where("title ILIKE ?", "%#{task_name]}%")
      # case params[:importt]
      # when 'tres' then @task_importance = @task_user.where(importance: 3)
      # when 'dos' then @task_importance = @task_user.where(importance: 2)
      # when 'uno' then @task_importance = @task_user.where(importance: 1)
      # when 'cuatro' then @task_importance = @task_user.where(importance: 4)
      # when 'cinco' then  @task_importance = @task_user.where(importance: 5)
      # else
      #   @task_importance = @task_user.where(importance: 10)
      # end
      # @task_start_date = @task_user.where(start_date: params[:start_date])
      # @task_start_date = @task_user.where(importance: 10) if @task_start_date.nil?
      # @task_end_date = @task_user.where(start_date: params[:end_date])
      # @task_end_date = @task_user.where(importance: 10) if @task_end_date.nil?

      # @tasks = @task_task_name + @task_importance + @task_start_date + @task_end_date
      # @tasks = @task_user.where(user_id: current_user.id) if @tasks.nil?
      # @tasks.uniq
  end

end
