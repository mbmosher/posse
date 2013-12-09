class GroupsController < ApplicationController
  
  before_filter :authenticate_user!
  
  def new
  	@group = Group.new
  end

  def create
  	@group = Group.new(group_params)
    if @group.save
      Invite.create(:user_id => current_user.id, :group_id => @group.id, :accepted => true)
    	redirect_to groups_path
    else
    	render 'new'
    end
  end

  def show
  	@group = Group.find(params[:id])
  	@events = @group.events.where("datetime >= ?", Date.today).order(:datetime)
  	# members needs to check invites for group acceptance
  	# @members = @group.users.where("user.invite.accepted = ?", true)
  	@members = []
  	@group.users.each do |user|
  	  invite = user.invites.find_by group_id: @group.id
  	  if invite.accepted == true
  	    @members << user
	    end
    end
  	@myinvite = Invite.find_by group_id: @group.id, user_id: current_user.id
  	@user = User.new
  end

  def index
  	@groups = current_user.groups.where("accepted = ?", true)
  end

  def destroy
  	@group = Group.find(params[:group_id])
  	@group.destroy
  	redirect_to groups_path
  end
  	
   def sendInvite
     @group = Group.find(params[:user][:group_id])
     @user = User.new(params.require(:user).permit(:email))
   	 finduser = User.find_by email: @user.email
   	 if finduser
   	   Invite.create( :user_id => finduser.id, :group_id => @group.id, :accepted => false)
   	   flash[:notice] = "Invite sent!"
   	 else
   	   flash[:notice] = "User not registered"
 	   end
   	 redirect_to group_path(@group)
 	end
	  


  private
  
  def group_params
  	params.require(:group).permit(:name, :description)
  end
  
end
