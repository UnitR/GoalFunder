class CreateReportGoals < ActiveRecord::Migration[6.0]
  def change
    create_view :report_goals
  end
end
