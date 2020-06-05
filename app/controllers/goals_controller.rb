class GoalsController < ApplicationController
  before_action :set_goal, only: [:show, :edit, :update, :destroy]

  # GET /goals
  # GET /goals.json
  def index
    @goals = []
    current_user.user_group_memberships.each do |ugm|
      @goals << UserGoalsAll.where("group_id = #{ugm.group_id}")
    end
    @first_goal = @goals.first().first()
  end

  def persGoals
    @goals = []
    current_user.user_group_memberships.each do |ugm|
      @goals << UserGoalsAll.where("user_id = #{current_user.id}")
    end
    @first_goal = @goals.first().first()
  end

  # GET /goals/1
  # GET /goals/1.json
  def show
    respond_to do |format|
      format.html { render @goal }
      format.json { render json: @goal.to_json(:include => [:goal_owner => {:include => [:user]}]) }
    end
  end

  # GET /goals/new
  def new
    @goal = Goal.new
  end

  # GET /goals/1/edit
  def edit
  end

  # POST /goals
  # POST /goals.json
  def create
    @goal = Goal.new
    @goal.name = goal_params['goal_name']
    @goal.target = goal_params['goal_target']
    @goal.keywords = goal_params['keywords']

    @goal_owner = GoalOwner.new
    if goal_params['group_id'] > 0
      @goal_owner.group = Group.find(goal_params['group_id'])
    else
      @goal_owner.user = User.find(goal_params['user_id'])
    end
    @goal_owner.goal = @goal

    respond_to do |format|
      if @goal_owner.save && @goal.save
        format.html { redirect_to @goal, notice: 'Goal was successfully created.' }
        format.json { render :show, status: :created, location: @goal }
      else
        format.html { render :new }
        format.json { render json: @goal.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /goals/1
  # PATCH/PUT /goals/1.json
  def update
    respond_to do |format|
      if @goal.update(goal_params)
        format.html { redirect_to @goal, notice: 'Goal was successfully updated.' }
        format.json { render :show, status: :ok, location: @goal }
      else
        format.html { render :edit }
        format.json { render json: @goal.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /goals/1
  # DELETE /goals/1.json
  def destroy
    @goal.destroy
    respond_to do |format|
      format.html { redirect_to goals_url, notice: 'Goal was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_goal
      @goal = Goal.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def goal_params
      params.permit(:goal_name, :goal_keywords, :goal_target, :group_id, :user_id)
    end
end
