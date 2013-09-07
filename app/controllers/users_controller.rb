class UsersController < ApplicationController

  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def update
    @user.update(user_params)

    redirect_to '/document_upload'
  end

  def edit
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = current_user
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def user_params
    params.require(:user).permit(:name, :email, :landline, :mobile,)
  end
end
