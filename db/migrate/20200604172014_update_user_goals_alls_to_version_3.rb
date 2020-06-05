class UpdateUserGoalsAllsToVersion3 < ActiveRecord::Migration[6.0]
  def change
    update_view :user_goals_alls, version: 3, revert_to_version: 2
  end
end
