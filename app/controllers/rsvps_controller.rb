class RsvpsController < ApplicationController
  
  def attend
    @event = Event.find(params[:id])
    @rsvp = @event.rsvps.find_by user_id: current_user.id
    @rsvp.attending = true
    @rsvp.save
    @group = @event.group
    redirect_to group_event_path(@group, @event)
  end
  
  def flake
    @event = Event.find(params[:id])
    @rsvp = @event.rsvps.find_by user_id: current_user.id
    @rsvp.attending = false
    @rsvp.save
    @group = @event.group
    positiveRSVPS = @event.rsvps.where("attending = ?", true)
    # flash[:notice] = positiveRSVPS.first
    if positiveRSVPS.first.nil?
      rsvps = @event.rsvps
      rsvps.each do |rsvp|
        rsvp.destroy
      end
      @event.destroy
    end
    redirect_to group_path(@group)
  end 
  
  def destroy	
    @rsvp = RSVP.find(params[:id])
  	@rsvp.destroy
  end
  
end
