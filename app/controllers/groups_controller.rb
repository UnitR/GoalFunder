class GroupsController < ApplicationController

  # Get Group information before CRUD actions
  before_action :set_group, only: [:show, :edit, :update, :destroy]

  # Ensure that the user has necessary attributes/permitions before allowing them to modify
  # before_action :check_gorup, only: [:edit, :update, :destroy]

  # GET /groups
  # GET /groups.json
  def index
    @groups = Group.all

    # Devise integration
    # @groups = current_user.groups.all

  end

  # GET /groups/1
  # GET /groups/1.json
  def show
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
