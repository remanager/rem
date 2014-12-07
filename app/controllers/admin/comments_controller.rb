class Admin::CommentsController < ApplicationController
  before_filter :set_comment, only: [:edit, :update, :destroy, :publish]

  def new
    @comment = Comment.new
  end

  def create
    @comment = Comment.save(params_comment)
    return render('new') unless @comment.save
    get_redirection
  end

  def edit
  end

  def update
    return render('edit') unless @comment.update_attributes(params_comment)
    get_redirection
  end

  def destroy
    @comment.destroy
    get_redirection
  end

  def publish
    @comment.publish
    get_redirection
  end

  private

  def params_comment
    params.require(:comment).permit(:property_id, :realestate_id, :email, :text)
  end

  def set_comment
    @comment = Comment.find(:id)
  end

  def get_redirection
    return redirect_to edit_admin_property(params[:property_id]) if params[:property_id]
    return redirect_to edit_admin_realestate(params[:realestate_id]) if params[:realestate_id]
    redirect_to admin_dashboard
  end
end
