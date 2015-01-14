module Admin
  class BaseController < ::ApplicationController
    layout "/admin/admin"

    before_action :auth_admin!

    def auth_admin!
      redirect_to root_url unless (current_user && current_user.admin?)
    end

  end
end