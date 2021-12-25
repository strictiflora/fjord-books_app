# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_comment, only: %i[edit update destroy]
  before_action :set_commentable, only: %i[create edit update destroy]
  before_action :ensure_user, only: %i[edit update destroy]

  # POST /comments
  def create
    @comment = @commentable.comments.new(comment_params.merge(user: current_user))
    if @comment.save
      redirect_to url_for(@commentable), notice: t('controllers.common.notice_create', name: Comment.model_name.human)
    elsif @comment.commentable_type == 'Book'
      @book = @commentable
      render 'books/show'
    else
      @report = @commentable
      render 'reports/show'
    end
  end

  def edit; end

  # PATCH/PUT /comments/1
  def update
    if @comment.update(comment_params)
      redirect_to url_for(@commentable), notice: t('controllers.common.notice_update', name: Comment.model_name.human)
    else
      render :edit
    end
  end

  # DELETE /comments/1
  def destroy
    @comment.destroy
    redirect_to url_for(@commentable), notice: t('controllers.common.notice_destroy', name: Comment.model_name.human)
  end

  private

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:body)
  end

  def set_commentable
    resource, id = request.path.split('/')[1, 2]
    @commentable = resource.singularize.classify.constantize.find(id)
  end

  def ensure_user
    comments = current_user.comments
    comment = comments.find_by(id: params[:id])
    redirect_to polymorphic_path(@commentable) unless comment
  end
end
