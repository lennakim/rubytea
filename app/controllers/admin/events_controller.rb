module Admin
  class EventsController < BaseController
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
      params.require(:event).permit!
    end

    def set_event
      @event = Event.find(params[:id])
    end
  end
end
