module Admin
  class EventsController < BaseController
    before_action :set_event, except: [:index, :new, :create]

    def index
      @events = Event.recent.page(params[:page])
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

    def event_params
      params.require(:event).permit!
    end

    def set_event
      @event = Event.find(params[:id])
    end
  end
end
