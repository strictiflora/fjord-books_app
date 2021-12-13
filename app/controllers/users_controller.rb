class UsersController < ApplicationController
  layout 'devise'

  before_action :authenticate_user!

  def index
    @users = User.all.order(:id).page(params[:page])
  end

  def show
    @user = User.find(params[:id])
  end
end
