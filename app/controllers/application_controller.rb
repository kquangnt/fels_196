class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include CategoriesHelper
  include SessionsHelper

  protected
  def logged_in_user
    unless logged_in?
      flash[:danger] = t "please_login"
      redirect_to login_url
    end
  end

  def load_user
    @user = User.find_by_id params[:id]
    unless @user
      flash[:danger] = t "id_not_exist"
      redirect_to users_path
    end
  end

  def correct_user
    redirect_to root_url unless current_user.is_user? @user
  end
end
