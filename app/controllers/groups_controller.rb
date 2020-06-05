class GroupsController < ApplicationController

  # Don't try to get Group record for the index page (show all)
  before_action :set_group, except: :index
  layout "secondary-page"
  # Ensure that the user has necessary attributes/permitions before allowing them to modify
  # before_action :check_gorup, only: [:edit, :update, :destroy, :add_member]

  # GET /groups
  # GET /groups.json
  def index
    # Devise integration
    @groups = []
    current_user.user_group_memberships.each do |gm|
      @groups << gm.group
    end
  end


  # GET /groups/1
  # GET /groups/1.json
  def show

    group_goal = nil
    funded_amount = 0
    if @group.goal_owners.any?
      group_goal =  @group.goal_owners.first().goal
      funded_amount = (group_goal.payments.sum(:amount) / group_goal.target) * 100
      pers_contrib = current_user.payments.where("goal_id = #{group_goal.id}").sum('amount');
    end

    render json: {
          group_name: @group.name,
          group_goal: group_goal,
          group_members: @group.user_group_memberships,
          funded_amount: funded_amount,
          pers_contrib: pers_contrib
      }, status: :ok

  end

  # GET /groups/new
  def new
    @group = Group.new

    # Devise integration
    # @group.user_id = current_user.id
  end

  # GET /groups/1/edit
  def edit
  end

  # POST /groups
  # POST /groups.json
  def create

    @group = Group.new(group_params)

    # Devise integrated
    # Creates a new group under the current user to ensure relationship integrity
    # @group = current_user.groups.new(group_params)

    respond_to do |format|
      if @group.save
        format.html { redirect_to @group, notice: 'Group was successfully created.' }
        format.json { render :show, status: :created, location: @group }
      else
        format.html { render :new }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /groups/1
  # PATCH/PUT /groups/1.json
  def update

    # Devise integration
    # Do not allow a user to update another user's groups
    # if @group.user_id != current_user.id
    #   respond_to do |format|
    #     format.html { render :edit }
    #     format.json { render json: @group.errors, status: :unauthorized }
    #   end
    #   return
    # end

    respond_to do |format|
      if @group.update(group_params)
        format.html { redirect_to @group, notice: 'Group was successfully updated.' }
        format.json { render :show, status: :ok, location: @group }
      else
        format.html { render :edit }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end

  end

  # DELETE /groups/1
  # DELETE /groups/1.json
  def destroy

    # Ensure that other users cannot delete groups that do not belong to them
    # Integrated with devise
    # if @group.user_id = current_user.id
    #   respond_to do |format|
    #     format.html { render :index }
    #     format.json { render json: @group.errors, status: :unauthorized }
    #   end
    #   # Exit early as no need to do anything else
    #   return
    # end

    @group.destroy
    respond_to do |format|
      format.html { redirect_to groups_url, notice: 'Group was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  # GET /groups/:id/add_member
  # GET /groups/:id/add_member.json
  def show_add_member
  end

  # POST /groups/:id/add_member
  # POST /groups/:id/add_member
  def add_group_member

    # Ensure that other users cannot delete groups that do not belong to them
    # Integrated with devise
    # if @group.user_id = current_user.id
    #   respond_to do |format|
    #     format.html { redirect_to @group, notice: 'Only the owners of groups can add members to them.' }
    #     format.json { render json: @group.errors, status: :unauthorized }
    #   end
    #   # Exit early as no need to do anything else
    #   return
    # end

    # Create a group membership based on current state
    @user = User.find_by username: params[:username]
    @membership = User.user_group_memberships.new
    @membership.group_id = @group.id

    # Save the membership
    respond_to do |format|
      if @membership.save
        format.html { redirect_to @group, notice: 'Member succesfully added to group.' }
        format.json { render :show, status: :ok, location: @group }
      else
        format.html { render :show }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end

  end

  private

    # Use callbacks to share common setup or constraints between actions.
    def set_group
      @group = Group.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def group_params
      params.require(:group).permit(:name)
    end

  # Ensures the user is the owner of a group
  def check_group

    # Check if user ID matches group owner's ID
    raise User::NotAuthorized unless current_user.id = @group.user_id

  end



end
