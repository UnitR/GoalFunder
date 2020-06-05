class GoalsReport < ApplicationRecord
  has_many :goals

  attr_accessor :report_type

  REPORT_TYPE = {
      ALL: 'ALL',
      FUNDED: 'FUNDED',
      NON_FUNDED: 'NON_FUNDED'
  }

  def fetch_report_goals
    case @report_type.to_sym
    when :all
      @report_goals = ReportGoal.all
    when :funded
      get_reports_funded(true)
    when :non_funded
      get_reports_funded(false)
    end
    @report_goals
  end

  private

  def get_reports_funded(return_funded)
    @report_goals = []
    ReportGoal.all.each do |goal|
      if goal.goal_target == goal.goal_funded && return_funded
        @report_goals << goal
      elsif goal.goal_target != goal.goal_funded && !return_funded
        @report_goals << goal
      end
    end
  end

end
