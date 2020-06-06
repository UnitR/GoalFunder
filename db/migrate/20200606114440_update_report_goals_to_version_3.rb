class UpdateReportGoalsToVersion3 < ActiveRecord::Migration[6.0]
  def change
    update_view :report_goals, version: 3, revert_to_version: 2
  end
end
