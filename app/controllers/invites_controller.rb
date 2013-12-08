class InvitesController < ApplicationController
  
  def new
   	@invite = Invite.new
   end

   def index
   	@invites = current_user.invites.where("accepted = ?", false)
   end
   
   def accept
     @invite = Invite.find(params[:id])
     @invite.accepted = true
     @invite.save
     redirect_to invites_path
   end

   def destroy
   	@invite = Invite.find(params[:id])
   	@invite.destroy
   	redirect_to invites_path
   end
   
   def leave
    	@invite = Invite.find(params[:id])
    	@group = Group.find(@invite.group_id)
    	@invite.destroy
    	checkInvite = Invite.find_by group_id: @group.id
    	if checkInvite.nil?
    	  @group.destroy
  	  end
    	redirect_to groups_path
   end
   
end
