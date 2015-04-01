class TrackerProjectsController < ApplicationController
  def show
    @tracker_stories = TrackerAPI.new.stories(current_user.pivotal_token, params[:id])
    @tracker_project = params[:tracker_project_name]
  end
end
