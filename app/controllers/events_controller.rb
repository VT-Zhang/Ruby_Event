class EventsController < ApplicationController
  def index
      @event_same_state = Event.where(state: session[:state]).order(date: :desc)
      @event_rest = Event.where.not(state: session[:state]).order(date: :desc)
      @user = User.find(session[:user_id])
  end

  def create
      event = Event.new(name: params[:name], date: params[:date], location: params[:location], state: params[:state], user: current_user)
      if event.valid?
          event.save
          flash[:notices] = ["You have successfully added an event!"]
          redirect_to "/events"
      else
          flash[:errors] = event.errors.full_messages
          redirect_to "/events"
      end
  end

  def destroy
      event = Event.find(params[:id])
      event.destroy
      redirect_to "/events"
  end

  def edit
      @event = Event.find(params[:id])
  end

  def update
      event = Event.find(params[:id])
      event.update(name: params[:name], date: params[:date], location: params[:location], state: params[:state], user: current_user)
      if event.valid?
          flash[:notices] = ["You have successfully UPDATED an event!"]
          redirect_to "/events"
      else
          flash[:errors] = event.errors.full_messages
          redirect_to "/events/#{event.id}/edit"
      end
  end

  def show
      @event = Event.find(params[:id])
      @participations = Participation.where(event_id: params[:id])
      @comments = Comment.where(event_id: params[:id])
  end
end
