class CommentsController < ApplicationController
  
  def create
  	@event = Event.find(params[:event_id])
  	@comment = @event.comments.new(params[:comment].permit(:body)) 
  	@comment.user_id = current_user.id
  	@comment.event_id = @event.id
      # @comment.commenter = current_user.email
      @comment.save
  	redirect_to group_event_path(@event.group_id, @event)
  end

  def destroy
  	@event = Event.find(params[:event_id])
  	@comment = @event.comments.find(params[:id])
  	@comment.destroy
  	redirect_to group_event_path(@event.group_id, @event)
  end
  
end
