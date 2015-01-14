module Admin
  class UserController < BaseController
    def index

    end

    def show

    end

    def new

    end

    def create

    end

    def edit

    end

    def update

    end

    def destroy

    end

    private

    def user_params
      params.require(:user).permit!
    end

    def set_user
      @user = User.find(params[:id])
    end
  end
end
