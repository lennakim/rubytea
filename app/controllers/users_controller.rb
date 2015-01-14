class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
  end

  def edit
  end

  def update
  end

  private

  def user_params
    # http://stackoverflow.com/questions/15528649/how-to-permit-all-attributes-besides-user-id-using-strong-parameters
    params.require(:user).permit!.except(:role, :created_at, :updated_at)
  end
end
