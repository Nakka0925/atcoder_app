# frozen_string_literal: true

class SessionsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def new
    # ログインフォームを表示するだけなので、特に処理は必要ありません
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user&.authenticate(params[:session][:password])
      handle_successful_login(user)
    else
      handle_failed_login
    end
  end

  def destroy
    reset_session
    flash[:success] = 'ログアウトしました'
    redirect_to login_path
  end

  private

  def handle_successful_login(user)
    log_in user
    flash[:success] = 'ログインしました'
    redirect_to root_path
  end

  def handle_failed_login
    flash.now[:danger] = 'メールアドレスまたはパスワードが正しくありません'
    render 'new'
  end
end
