class IssueAttributesController < ApplicationController
  unloadable

  before_filter :find_project
  before_filter :authorize
  accept_api_auth :index

  def index
    respond_to do |format|
      format.api {
        @project = Project.find(params[:project_id])

        @issue = Issue.new
        @issue.project = @project
        @issue.tracker = @project.trackers.find(params[:tracker_id])
        @issue.start_date ||= Date.today if Setting.default_issue_start_date_to_creation_date?

        @priorities = IssuePriority.active
        @allowed_statuses = @issue.new_statuses_allowed_to(User.current, true)
        @available_watchers = (@issue.project.users.sort + @issue.watcher_users).uniq
      }
    end
  end

  private

  def find_project
    @project = Project.find(params[:project_id])
  rescue ActiveRecord::RecordNotFound
    render_404
  end
end
