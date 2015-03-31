class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user, :owner_count

  def current_user
    if session[:user_id].present?
      User.find(session[:user_id])
    end
  end

  def ensure_signed_in
    unless current_user
      flash[:error] = "You must sign in"
      redirect_to sign_in_path
    end
  end

  def verify_member_of_project
    unless current_user.projects.include?(@project)
      flash[:error] = "You do not have access to that project"
      redirect_to projects_path
    end
  end

  def verify_project_owner
    unless Membership.where(project_id: @project.id).include?(current_user.memberships.find_by(project_id: @project.id, role: 1))
      flash[:error] = "You do not have access to that project"
      redirect_to projects_path
    end
  end

  def owner_count(project)
    project.memberships.where(role:1).count
  end

end
