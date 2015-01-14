module Admin
  class EventsController < BaseController
    before_action :set_event, except: [:index, :new, :create]

    def index
      @events = Event.recent.page(params[:page])
    end

    def show

    end

    def new
      @event = Event.new
    end

    def create
      @event = Event.new(event_params)

      respond_to do |format|
        if @event.save
          format.html { redirect_to admin_events_path }
        else
          format.html { render action: 'new' }
        end
      end
    end

    def edit

    end

    def update

      if @event.update(event_params)
        redirect_to admin_events_path
      else
        render :edit
      end
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
