class AdminReportsController < ApplicationController

  before_action :check_params, only: :index

  @report = nil

  def index
    @report = GoalsReport.new(report_type: params[:report_type], date_generated: Time.now)
    @report.save
    @report_goals = @report.fetch_report_goals
    render pdf: "Admin reports for Goal types: #{@report.report_type}",
           page_size: 'A4',
           template: 'admin_reports/show.html.erb',
           layout: 'pdf.html',
           orientation: 'Landscape',
           lowquality: true,
           zoom: 1,
           dpi: 75,
           disposition: 'attachment',
           locals: { report_goals: @report_goals }
    end

  private

  def check_params
    params.permit(:report_type)
  end

end
