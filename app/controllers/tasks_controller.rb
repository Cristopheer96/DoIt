require 'byebug'

class TasksController < ApplicationController
    protect_from_forgery except: :new
  before_action :set_task, only: [:edit, :update, :destroy]


  def index


    if (params["/tasks"]  )

      # @tasks = Labelled.joins(:task).where(tag_id: params["/tasks"]["tag_id"] )
      @task_name = params["/tasks"]["task_name"]
      @importace = params["/tasks"]["importance"]
      @start_date = params["/tasks"]["start_date"]
      @end_date = params["/tasks"]["end_date"]
      @tag_id = params["/tasks"]["tag_id"]
      @tasks_all = search_tasks(current_user,@task_name,@tag_id,@importace,@start_date,@end_date )
      @tasks = @tasks_all.where(state: false)
      @tasks_completed = Task.where(state: true)
    else
      @tasks_completed = Task.where(user_id: current_user.id).order(:start_date).where(state: true)

      @tasks = Task.where(user_id: current_user.id).order(:start_date).where(state: false)
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

  def complete
    #.toggle!(:active)
    @task = Task.find(params[:task_id])
    if @task.state
      @task.state = false
    else
      @task.state = true
    end
    @task.save
  end

  private
  def task_params

    params.require(:task).permit(:title, :description, :importance, :start_date, :end_date)
  end

  def set_task
      @task = Task.find(params[:id])
  end

  def search_tasks(usuario,task_name,tag_id,importace,start_date,end_date ) # metodo solicitado
    @tasks = usuario.tasks
          # @task_user = current_user.tasks
    @task_task_name = @tasks.where("title ILIKE ?", "%#{task_name}%")

    @task_importance = @task_task_name.where(importance: importace)
    @task_importance = @task_task_name if @task_importance.size == 0

    @task_start_date = @task_importance.where(start_date: "#{start_date} 00:00:00.000000000 +0000")
    @task_start_date = @task_importance if @task_start_date.size == 0

    @task_end_date = @task_start_date.where(end_date: "#{end_date} 00:00:00.000000000 +0000")
    @task_end_date = @task_start_date if @task_end_date.size == 0
    @tasks = @task_end_date
    @tasks = @tasks.joins(:labelleds).where( 'labelleds.tag_id' => tag_id)
    @tasks = @task_end_date if @tasks.size == 0
    return @tasks.order(:start_date)
  end

end
