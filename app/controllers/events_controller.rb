class EventsController < ApplicationController
  
  before_filter :authenticate_user!
  
  helper_method :reliability
  
  def new
    @group = Group.find(params[:group_id])
    @event = Event.new
  end
  
  def create
  	@group = Group.find(params[:group_id])
  	@event = @group.events.new(event_params) 
    if @event.save
      @group.users.each do |user|
        if user.id == current_user.id
          Rsvp.create(:user_id => current_user.id, :event_id => @event.id, :group_id => @group.id, :attending => true)
        else
          Rsvp.create(:user_id => user.id, :event_id => @event.id, :group_id => @group.id, :attending => false)
        end
      end   
      redirect_to group_path(@group)
    else
      render 'new'
    end
  end

  def show
    @group = Group.find(params[:group_id])
    @event = Event.find(params[:id])
    @attendees = []
  	@event.users.each do |user|
  	  rsvp = user.rsvps.find_by event_id: @event.id
  	  if rsvp.attending == true
  	    @attendees << user
	    end
    end
  end
  
  def destroy
  	@event = Event.find(params[:id])
  	@event.destroy
  end
  
  def edit
  	@event = Event.find(params[:id])
  	@group = Group.find(params[:group_id])
  end

  def update
    @group = Group.find(params[:group_id])
  	@event = Event.find(params[:id])
  	if @event.update(params[:event].permit(:location, :time))
  		redirect_to group_event_path(@event.group_id, @event)
  	else
  		redirect_to edit_group_event_path(@event.group_id, @event)
  	end
  end
  
  def index
    @myevents = current_user.rsvps.where("attending = ?", true).joins(:event).where("date >= ?", Date.today).order('date desc') 
  end
  
  def allevents
    @myevents = current_user.events.where("date >= ?", Date.today).order(:date)
  end
  
  def pastevents
    @myevents = current_user.rsvps.where("attending = ?", true).joins(:event).where("date <= ?", Date.today).order('date desc')
  end
  
end

private

def reliability(attendee)
  @group = Group.find(params[:group_id])
  @event = Event.find(params[:id])
  myevents = @group.rsvps.where("user_id = ? and attending = ?", attendee.id, true)
  myevents.count * 100 / @group.rsvps.where("user_id = ?", attendee.id).count
end

def event_params
  params.require(:event).permit(:title, :description, :location, :date, :time)
end
