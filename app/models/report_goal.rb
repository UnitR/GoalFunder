class ReportGoal < ApplicationRecord
  belongs_to :goal, polymorphic: true
end
