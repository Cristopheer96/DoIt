require 'byebug'
class LabelledsController < ApplicationController
  def edit
    @tags = Tag.where(user_id: current_user.id)
    respond_to do |format|
      format.js
    end
  end

  def update
    # byebug
    @labelleld = Labelled.find(params[:id])
    respond_to do |format|
      if @labelleld.update(set_labelled)
        format.json { head :no_content }
        format.js
      else
        format.json { render json: @labelleld.errors.full_messages, status: :unprocessable_entity }
        format.js { render :edit }
      end
    end
  end

  private
  def set_labelled
    params.require(:labelled1).permit(:tag_id)
  end
end
