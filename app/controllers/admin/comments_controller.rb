class Admin::CommentsController < ApplicationController
  before_filter :set_comment, only: [:destroy, :seen, :publish, :unpublish]

  def index
    @comments = (current_realestate ? current_realestate.comments : Comment).order(:realestate_id, :property_id)
  end

  def destroy
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to admin_comments_path }
    end
  end

  def seen
    @comment.update_attribute(:published, false)
    respond_to do |format|
      format.html { redirect_to admin_comments_path }
    end
  end

  def publish
    @comment.publish
    respond_to do |format|
      format.html { redirect_to admin_comments_path }
    end
  end

  def unpublish
    @comment.publish(false)
    respond_to do |format|
      format.html { redirect_to admin_comments_path }
    end
  end

  private

  def set_comment
    @comment = Comment.find(params[:id])
  end
end
