require 'byebug'

class TagsController < ApplicationController
  protect_from_forgery except: :new
  before_action :set_tag, only: [:edit, :update, :destroy]


  def index
    @tags = Tag.where(user_id: current_user.id)
  end

  def new
    @tag = Tag.new
    respond_to do |format|
      format.js
    end
  end

  def create
    @tag = Tag.new(tag_params)
    @tag.user = current_user
    respond_to do |format|
      if @tag.save
        format.json { head :no_content }
        format.js
      else
        format.json { render json: @tag.errors.full_messages, status: :unprocessable_entity }
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
      if @tag.update(tag_params)
        format.json { head :no_content }
        format.js
      else
        format.json { render json: @tag.errors.full_messages, status: :unprocessable_entity }
        format.js { render :edit }
      end
    end
  end

  def destroy
    @tag.destroy
    respond_to do |format|
      format.json { head :no_content }
      format.js
    end
  end

  private
  def tag_params
    params.require(:tag).permit(:title, :color)
  end

  def set_tag
      @tag = Tag.find(params[:id])
  end
end
