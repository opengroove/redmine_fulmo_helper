class ProjectTrackersController < ApplicationController
  unloadable

  before_filter :find_project
  before_filter :authorize
  accept_api_auth :index

  def index
    respond_to do |format|
      format.api {
        @trackers = @project.trackers
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
