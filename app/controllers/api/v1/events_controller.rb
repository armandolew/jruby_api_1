module API
  module V1
    class Api::V1::EventsController < ApplicationController
      before_action :set_event, only: [:update, :destroy]

      # GET /events
      # GET /events.json
      def index
        @events = Event.all
        render 'api/v1/events/index', status: :ok
      end

      # GET /events/1
      # GET /events/1.json
      def show
        @event = Event.includes(:photos).find_by(:id => params[:id])
        render 'api/v1/events/show', status: :ok
      end

      # POST /events
      # POST /events.json
      def create
        @event = Event.new(event_params)
        @event.generate_token

        if @event.save
          user = User.find_by(:id => event_params[:user_id])
          if !user.nil?
            NotificationsMailer.delay(:queue => 'notifications').send_notification(user.id)
          end
          render 'api/v1/events/show', status: :created
        else
          render 'api/v1/events/show', status: :unprocessable_entity
        end
      end

      # PATCH/PUT /events/1
      # PATCH/PUT /events/1.json
      def update
        if @event.update(event_params)
          render :show, status: :ok, location: @event
        else
          render json: @event.errors, status: :unprocessable_entity
        end
      end

      # DELETE /events/1
      # DELETE /events/1.json
      def destroy
        @event.destroy
      end

      private
        # Use callbacks to share common setup or constraints between actions.
        def set_event
          @event = Event.find_by(:id => params[:id])
        end

        # Never trust parameters from the scary internet, only allow the white list through.
        def event_params
          params.require(:event).permit(:name, :date, :location, :latitude, :longitude, :user_id)
        end
    end
  end
end
