class CreateUserGoalsAlls < ActiveRecord::Migration[6.0]
  def change
    create_view :user_goals_alls
  end
end
