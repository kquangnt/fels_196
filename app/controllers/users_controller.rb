class UsersController < ApplicationController
  before_action :logged_in_user, only: :index
  before_action :load_user, only: :show

  def index
    @users = User.paginate(page: params[:page]).per_page Settings.per_page.user
  end

  def show
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      log_in @user
      flash[:success] = t "sign_up_success"
      redirect_to @user
    else
      render :new
    end
  end

  private
  def user_params
    params.require(:user).permit :name, :email, :password, :password_digest
  end

  def load_user
    @user = User.find_by_id params[:id]
    if @user.nil?
      flash[:danger] = t "id_not_exist"
      redirect_to users_path
    end
  end
end
