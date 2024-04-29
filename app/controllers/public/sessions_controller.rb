# frozen_string_literal: true

class Public::SessionsController < Devise::SessionsController
  before_action :user_state, only: [:create]
  # before_action :configure_sign_in_params, only: [:create]
  def guest_sign_in
    user = User.guest
    sign_in user
    redirect_to user_path(user.id), notice: "ゲストユーザーとしてログインしました"
  end 

  def after_sign_out_path_for(resource)
    root_path
  end
  
  def user_state
    @user = User.find_by(email: params[:user][:email])
    return if @user.nil?
    return unless @user.valid_password?(params[:user][:password])
    if @user.is_active
      sign_in(@user)
      redirect_to user_path(@user.id)
    else 
      flash[:alert] = "管理者によってブロックされているアカウントです"
      redirect_to root_path
    end 
  end


  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end

end
