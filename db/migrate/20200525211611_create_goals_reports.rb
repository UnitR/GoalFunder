class CreateGoalsReports < ActiveRecord::Migration[6.0]
  def change
    create_table :goals_reports do |t|
      t.date :date_generated
      t.string :type

      t.timestamps
    end
  end
end
