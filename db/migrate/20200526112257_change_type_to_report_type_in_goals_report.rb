class ChangeTypeToReportTypeInGoalsReport < ActiveRecord::Migration[6.0]
  def change
    rename_column :goals_reports, :type, :report_type
  end
end
