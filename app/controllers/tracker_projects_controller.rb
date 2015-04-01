class TrackerProjectsController < ApplicationController
  def show
    @stories = TrackerAPI.new.stories(current_user.pivotal_token, params[:id])
  end
end
